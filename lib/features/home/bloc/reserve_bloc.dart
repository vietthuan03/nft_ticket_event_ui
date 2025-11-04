import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/ticket_repository.dart';
import 'reserve_state.dart';
part 'reserve_event.dart';

class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  final TicketRepository repository;

  ReserveBloc(this.repository) : super(const ReserveState()) {
    on<LoadTicketEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final ticket = await repository.getTicket();
      emit(state.copyWith(ticket: ticket, isLoading: false));
    });

    on<ToggleThemeEvent>((event, emit) {
      emit(state.copyWith(isDark: !state.isDark));
    });
  }
}
