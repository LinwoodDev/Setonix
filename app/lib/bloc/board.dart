import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/bloc/board_state.dart';
import 'package:quokka/models/table.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(const BoardState()) {
    on<HandChanged>((event, emit) {
      emit(state.copyWith(
        showHand: event.show ?? (!state.showHand),
        selectedDeck: event.deck,
        selectedCell: null,
      ));
    });
    on<CellSwitched>((event, emit) {
      emit(state.copyWith(selectedCell: event.cell));
    });
    on<ObjectsSpawned>((event, emit) {
      emit(state.copyWith.table.cells.replace(
          event.cell,
          (state.table.cells[event.cell] ?? TableCell())
              .copyWith
              .objects
              .addAll(event.objects)));
    });
  }
}
