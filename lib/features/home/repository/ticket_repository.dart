import 'package:nft_ticket_event_ui/features/home/models/ticket_model.dart';

abstract class TicketRepository {
  Future<TicketModel> getTicket();
}
