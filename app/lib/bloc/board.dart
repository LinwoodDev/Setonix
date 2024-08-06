import 'package:collection/collection.dart';
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
    on<ObjectsMoved>((event, emit) {
      var from = state.table.cells[event.from] ?? TableCell();
      var to = state.table.cells[event.to] ?? TableCell();
      final toRemove = event.objects;
      final toAdd = toRemove.map((e) => from.objects[e]).toList();
      final newObjects = List<GameObject>.from(from.objects);
      for (final i in toRemove.sorted((a, b) => b.compareTo(a))) {
        newObjects.removeAt(i);
      }
      from = from.copyWith(objects: newObjects);
      to = to.copyWith.objects.addAll(toAdd);
      emit(state.copyWith.table(cells: {
        ...state.table.cells,
        event.from: from,
        event.to: to,
      }));
    });
  }
}
