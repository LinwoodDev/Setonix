import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/bloc/board_state.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/services/file_system.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc({
    required QuokkaFileSystem fileSystem,
    String? name,
    QuokkaData? data,
    GameTable? table,
  }) : super(BoardState(
          fileSystem: fileSystem,
          name: name,
          data: data ?? QuokkaData.empty(),
          table: table ?? data?.getTable() ?? const GameTable(),
        )) {
    on<ColorSchemeChanged>((event, emit) {
      emit(state.copyWith(colorScheme: event.colorScheme));
      return save();
    });
    on<HandChanged>((event, emit) {
      emit(state.copyWith(
        showHand: event.show ?? (!state.showHand),
        selectedDeck: event.deck,
        selectedCell: null,
      ));
      return save();
    });
    on<CellSwitched>((event, emit) {
      emit(state.copyWith(
        selectedCell: event.cell,
        selectedDeck: null,
        showHand: true,
      ));
      return save();
    });
    on<ObjectsSpawned>((event, emit) {
      emit(state.copyWith.table.cells.replace(
          event.cell,
          (state.table.cells[event.cell] ?? TableCell())
              .copyWith
              .objects
              .addAll(event.objects)));
      return save();
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
      return save();
    });
  }

  Future<void> save() async {
    final data = state.data.setTable(state.table);
    final name = state.name;
    if (name == null) return;
    return state.fileSystem.worldSystem.updateFile(name, data);
  }
}
