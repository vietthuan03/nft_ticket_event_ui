part of 'reserve_bloc.dart';

sealed class ReserveEvent extends Equatable {
  const ReserveEvent();

  @override
  List<Object> get props => [];
}

class LoadTicketEvent extends ReserveEvent {}

class ToggleThemeEvent extends ReserveEvent {}