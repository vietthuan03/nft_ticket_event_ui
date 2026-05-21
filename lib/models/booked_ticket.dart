
import 'package:nft_ticket_event_ui/models/ticket.dart';

import 'event.dart';

class BookedTicket {
  final String nftId;
  final String tokenId;
  final String mintTxHash;
  final String status;
  final DateTime mintedAt;
  final TicketModel ticket;
  final EventModel event;

  BookedTicket({
    required this.nftId,
    required this.tokenId,
    required this.mintTxHash,
    required this.status,
    required this.mintedAt,
    required this.ticket,
    required this.event,
  });

  factory BookedTicket.fromMintedNFT({
    required NFT nft,
    required TicketModel ticket,
    required EventModel event,
  }) {
    return BookedTicket(
      nftId: nft.tokenId ?? '',
      tokenId: nft.tokenId ?? '',
      mintTxHash: nft.mintTxHash ?? '',
      status: nft.status ?? 'minted',
      mintedAt: nft.mintedAt ?? DateTime.now(),
      ticket: ticket,
      event: event,
    );
  }

  // Generate QR data string
  String get qrData {
    return 'NFT:$tokenId|EVENT:${event.sId}|TICKET:${ticket.sId}|TX:$mintTxHash';
  }

  bool get isOngoing {
    return status.toLowerCase() == 'minted';
  }

  bool get isCheckedIn {
    return status.toLowerCase() == 'checked-in';
  }
}