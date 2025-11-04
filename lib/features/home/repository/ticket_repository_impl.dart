

import 'package:nft_ticket_event_ui/features/home/models/ticket_model.dart';
import 'package:nft_ticket_event_ui/features/home/repository/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  @override
  Future<TicketModel> getTicket() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const TicketModel(
      title: "VIP Concert Pass",
      description: "Access to all exclusive backstage areas.",
      date: "2025-11-30",
      imageUrl: "https://picsum.photos/200",
      location: "Tokyo Dome, Japan",
    );
  }
}
