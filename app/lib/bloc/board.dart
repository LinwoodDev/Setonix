import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/bloc/board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(const BoardState()) {
    on<ChangeHandEvent>((event, emit) {
      emit(state.copyWith(
        showHand: event.show ?? (!state.showHand),
        selectedDeck: event.deck,
      ));
    });
    on<SwitchCellEvent>((event, emit) {
      emit(state.copyWith(selectedCell: event.cell));
    });
  }
}
