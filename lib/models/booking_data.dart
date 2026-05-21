// models/booking_data.dart
import 'package:nft_ticket_event_ui/models/ticket.dart';

import 'event.dart';

class BookingData {
  final EventModel event;
  final Map<String, BookingTicket> selectedTickets;
  final double totalPrice;
  final int totalQuantity;

  BookingData({
    required this.event,
    required this.selectedTickets,
    required this.totalPrice,
    required this.totalQuantity,
  });
}

class BookingTicket {
  final TicketModel ticket;
  final int quantity;

  BookingTicket({
    required this.ticket,
    required this.quantity,
  });

  int get subtotal => (ticket.price ?? 0) * quantity;
}