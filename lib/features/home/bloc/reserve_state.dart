import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nft_ticket_event_ui/features/home/models/ticket_model.dart';

part 'reserve_state.freezed.dart';

@freezed
abstract class ReserveState with _$ReserveState {
  const factory ReserveState({
    @Default(false) bool isLoading,
    @Default(false) bool isDark,
    TicketModel? ticket,
  }) = _ReserveState;
}
