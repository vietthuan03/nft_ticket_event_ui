import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nft_ticket_event_ui/models/booked_ticket.dart';
import 'package:nft_ticket_event_ui/models/ticket.dart';
import 'package:nft_ticket_event_ui/models/event.dart';

class TicketStorageService {
  static const String _bookedTicketsKey = 'booked_tickets';

  // Save booked tickets to local storage
  static Future<bool> saveBookedTickets(List<BookedTicket> tickets) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Convert tickets to JSON
      final ticketsJson = tickets.map((ticket) {
        return {
          'nftId': ticket.nftId,
          'tokenId': ticket.tokenId,
          'mintTxHash': ticket.mintTxHash,
          'status': ticket.status,
          'mintedAt': ticket.mintedAt.toIso8601String(),
          'ticket': ticket.ticket.toJson(),
          'event': ticket.event.toJson(),
        };
      }).toList();

      final jsonString = jsonEncode(ticketsJson);

      print('Saving ${tickets.length} tickets to storage');
      return await prefs.setString(_bookedTicketsKey, jsonString);
    } catch (e) {
      print('Error saving tickets: $e');
      return false;
    }
  }

  // Load booked tickets from local storage
  static Future<List<BookedTicket>> loadBookedTickets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_bookedTicketsKey);

      if (jsonString == null || jsonString.isEmpty) {
        print('No saved tickets found');
        return [];
      }

      final List<dynamic> ticketsJson = jsonDecode(jsonString);

      final tickets = ticketsJson.map((json) {
        return BookedTicket(
          nftId: json['nftId'] ?? '',
          tokenId: json['tokenId'] ?? '',
          mintTxHash: json['mintTxHash'] ?? '',
          status: json['status'] ?? 'minted',
          mintedAt: DateTime.parse(json['mintedAt']),
          ticket: TicketModel.fromJson(json['ticket']),
          event: EventModel.fromJson(json['event']),
        );
      }).toList();

      print('Loaded ${tickets.length} tickets from storage');
      return tickets;
    } catch (e) {
      print('Error loading tickets: $e');
      return [];
    }
  }

  // Clear all saved tickets
  static Future<bool> clearBookedTickets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_bookedTicketsKey);
    } catch (e) {
      print('Error clearing tickets: $e');
      return false;
    }
  }

  // Update single ticket status (for check-in)
  static Future<bool> updateTicketStatus(
      String tokenId,
      String newStatus,
      ) async {
    try {
      final tickets = await loadBookedTickets();

      final index = tickets.indexWhere((t) => t.tokenId == tokenId);

      if (index == -1) {
        print('Ticket not found: $tokenId');
        return false;
      }

      // Update status
      tickets[index] = BookedTicket(
        nftId: tickets[index].nftId,
        tokenId: tickets[index].tokenId,
        mintTxHash: tickets[index].mintTxHash,
        status: newStatus,
        mintedAt: tickets[index].mintedAt,
        ticket: tickets[index].ticket,
        event: tickets[index].event,
      );

      // Save back
      return await saveBookedTickets(tickets);
    } catch (e) {
      print('Error updating ticket status: $e');
      return false;
    }
  }
}