import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import 'package:nft_ticket_event_ui/models/api_response.dart';
import 'package:nft_ticket_event_ui/models/booking_data.dart';
import 'package:nft_ticket_event_ui/models/event.dart';
import 'package:nft_ticket_event_ui/models/ticket.dart';
import 'package:nft_ticket_event_ui/models/user.dart';
import '../../services/http_services.dart';
import '../../utility/snack_bar_helper.dart';
import '../models/booked_ticket.dart';
import '../services/ticket_storage_service.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<EventModel> _allEventsList = [];
  List<EventModel> _filteredEvents = [];
  List<EventModel> get events => _filteredEvents;

  List<TicketModel> _allTicketsList = [];
  List<TicketModel> _filteredTickets = [];
  List<TicketModel> get tickets => _filteredTickets;

  // List booked tickets
  List<BookedTicket> _bookedTickets = [];
  List<BookedTicket> get bookedTickets => _bookedTickets;

  List<BookedTicket> get ongoingTickets {
    return _bookedTickets.where((t) => t.isOngoing).toList();
  }

  List<BookedTicket> get completedTickets {
    return _bookedTickets.where((t) => t.isCheckedIn).toList();
  }
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  DataProvider() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    await getAllEvents();
    await getAllTickets();
    await loadBookedTicketsFromStorage(); // ← Load saved tickets
  }
  void setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
  // Mint ticket NFT
  Future<NFT?> mintTicket(String ticketId) async {
    try {
      Response response = await service.addItem(
        endpointUrl: 'tickets/$ticketId/mint',
        itemData: {},
      );

      if (response.isOk) {
        ApiResponse<Map<String, dynamic>> apiResponse =
        ApiResponse<Map<String, dynamic>>.fromJson(
          response.body,
              (json) => json as Map<String, dynamic>,
        );

        if (apiResponse.data != null) {
          // map sang mintTxHash
          final data = apiResponse.data!;

          final nftData = {
            'tokenId': data['tokenId'],
            'mintTxHash': data['txHash'], // ← Map txHash -> mintTxHash
            'status': data['status'],
            'mintedAt': data['mintedAt'],
          };

          print('NFT minted: ${nftData}'); // Debug log

          return NFT.fromJson(nftData);
        }
      } else {
        print('Mint failed: ${response.statusText}');
      }
      return null;
    } catch (e) {
      print('Error minting ticket: $e');
      rethrow;
    }
  }
  // getAllEvents
  Future<void> getAllEvents({bool showSnack = false}) async {
    final list = await fetchItems<EventModel>(
      endpointUrl: 'events',
      fromJson: (json) => EventModel.fromJson(json),
      showSnack: showSnack,
    );

    _allEventsList = list;
    _filteredEvents = List.from(list);
    notifyListeners();
  }


  // filterEvents
  void filterEvents(String query) {
    _filteredEvents = filterByQuery(
      _allEventsList,
      query,
      (event) => event.title ?? '',
    );
    notifyListeners();
  }
  // getAllTickets
  Future<void> getAllTickets({bool showSnack = false}) async {
    final list = await fetchItems<TicketModel>(
      endpointUrl: 'tickets',
      fromJson: (json) => TicketModel.fromJson(json),
      showSnack: showSnack,
    );

    _allTicketsList = list;
    _filteredTickets = List.from(list);
    notifyListeners();
  }
  Future<void> getTicketsByEvent(String eventId) async {
    final list = await fetchItems<TicketModel>(
      endpointUrl: 'events/$eventId/tickets',
      fromJson: (json) => TicketModel.fromJson(json),
    );

    // Cập nhật danh sách tickets
    _allTicketsList = list;
    _filteredTickets = List.from(list);
    notifyListeners();
  }
  //filterByQuery
  List<T> filterByQuery<T>(
    List<T> items,
    String query,
    String Function(T) getName,
  ) {
    final lowerQuery = query.toLowerCase().trim();
    if (lowerQuery.isEmpty) return items;

    return items.where((item) {
      final name = getName(item).toLowerCase();
      return name.contains(lowerQuery);
    }).toList();
  }

  // fetchData
  Future<List<T>> fetchItems<T>({
    required String endpointUrl,
    required T Function(Map<String, dynamic>) fromJson,
    bool showSnack = false,
  }) async {
    _isLoading = true;
    try {
      Response response = await service.getItems(endpointUrl: endpointUrl);
      if (response.isOk) {
        ApiResponse<List<T>> apiResponse = ApiResponse<List<T>>.fromJson(
          response.body,
          (json) => (json as List)
              .map((e) => fromJson(e as Map<String, dynamic>))
              .toList(),
        );

        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        return apiResponse.data ?? [];
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return [];
  }
  // Mint multiple tickets (for quantity > 1)
  Future<List<NFT>> mintMultipleTickets({
    required String ticketId,
    required int quantity,
    Function(int current, int total)? onProgress,
  }) async {
    List<NFT> mintedNFTs = [];

    for (int i = 0; i < quantity; i++) {
      try {
        onProgress?.call(i + 1, quantity);

        final nft = await mintTicket(ticketId);

        if (nft != null) {
          mintedNFTs.add(nft);
        } else {
          throw Exception('Failed to mint ticket ${i + 1}/$quantity');
        }

        // Delay nhỏ giữa các lần mint để tránh overload
        if (i < quantity - 1) {
          await Future.delayed(Duration(milliseconds: 500));
        }
      } catch (e) {
        throw Exception('Failed to mint ticket ${i + 1}/$quantity: $e');
      }
    }

    return mintedNFTs;
  }
// Process booking - mint all tickets
  Future<Map<String, List<NFT>>> processBooking(
      Map<String, BookingTicket> selectedTickets,
      Function(String ticketName, int current, int total)? onProgress,
      ) async {
    Map<String, List<NFT>> allMintedNFTs = {};

    for (var entry in selectedTickets.entries) {
      final ticketId = entry.key;
      final bookingTicket = entry.value;
      final quantity = bookingTicket.quantity;

      try {
        final nfts = await mintMultipleTickets(
          ticketId: ticketId,
          quantity: quantity,
          onProgress: (current, total) {
            onProgress?.call(
              bookingTicket.ticket.name ?? 'Ticket',
              current,
              total,
            );
          },
        );

        allMintedNFTs[ticketId] = nfts;
      } catch (e) {
        throw Exception(
            'Failed to mint ${bookingTicket.ticket.name}: $e'
        );
      }
    }

    return allMintedNFTs;
  }
  // Add booked tickets after minting
  Future<void> addBookedTickets(
      Map<String, List<NFT>> mintedNFTs,
      Map<String, BookingTicket> selectedTickets,
      EventModel event,
      ) async {
    List<BookedTicket> newBookedTickets = [];

    mintedNFTs.forEach((ticketId, nfts) {
      final bookingTicket = selectedTickets[ticketId];
      if (bookingTicket != null) {
        for (var nft in nfts) {
          newBookedTickets.add(
            BookedTicket.fromMintedNFT(
              nft: nft,
              ticket: bookingTicket.ticket,
              event: event,
            ),
          );
        }
      }
    });
    _bookedTickets.addAll(newBookedTickets);
    // ✅ Lưu vào storage
    await TicketStorageService.saveBookedTickets(_bookedTickets);

    notifyListeners();
    print('Added and saved ${newBookedTickets.length} new tickets');
  }
  // ✅ Update ticket status (for check-in)
  Future<void> updateTicketStatus(String tokenId, String newStatus) async {
    final index = _bookedTickets.indexWhere((t) => t.tokenId == tokenId);

    if (index != -1) {
      _bookedTickets[index] = BookedTicket(
        nftId: _bookedTickets[index].nftId,
        tokenId: _bookedTickets[index].tokenId,
        mintTxHash: _bookedTickets[index].mintTxHash,
        status: newStatus,
        mintedAt: _bookedTickets[index].mintedAt,
        ticket: _bookedTickets[index].ticket,
        event: _bookedTickets[index].event,
      );

      // Lưu vào storage
      await TicketStorageService.saveBookedTickets(_bookedTickets);

      notifyListeners();
      print('Updated ticket $tokenId status to $newStatus');
    }
  }
// ✅ Load tickets from storage
  Future<void> loadBookedTicketsFromStorage() async {
    try {
      _bookedTickets = await TicketStorageService.loadBookedTickets();
      notifyListeners();
      print('Loaded ${_bookedTickets.length} tickets from storage');
    } catch (e) {
      print('Error loading tickets from storage: $e');
    }
  }

  // ✅ Clear all booked tickets
  Future<void> clearBookedTickets() async {
    _bookedTickets.clear();
    await TicketStorageService.clearBookedTickets();
    notifyListeners();
    print('Cleared all booked tickets');
  }

  // ✅ Remove single ticket
  Future<void> removeBookedTicket(String tokenId) async {
    _bookedTickets.removeWhere((t) => t.tokenId == tokenId);
    await TicketStorageService.saveBookedTickets(_bookedTickets);
    notifyListeners();
    print('Removed ticket $tokenId');
  }
}

