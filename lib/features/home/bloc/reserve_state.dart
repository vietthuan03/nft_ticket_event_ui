import 'package:equatable/equatable.dart';
import 'package:nft_ticket_event_ui/features/home/models/ticket_model.dart';

class ReserveState extends Equatable {
  final bool isDark;
  final TicketModel? ticket;
  final bool isLoading;

  const ReserveState({
    this.isDark = false,
    this.ticket,
    this.isLoading = false,
  });

  ReserveState copyWith({
    bool? isDark,
    TicketModel? ticket,
    bool? isLoading,
  }) {
    return ReserveState(
      isDark: isDark ?? this.isDark,
      ticket: ticket ?? this.ticket,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isDark, ticket, isLoading];
}
