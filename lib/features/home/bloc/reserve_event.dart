part of 'reserve_bloc.dart';

@freezed
class ReserveEvent with _$ReserveEvent {
  const factory ReserveEvent.loadTicket() = _LoadTicketEvent;
  const factory ReserveEvent.toggleTheme() = _ToggleThemeEvent;
}
