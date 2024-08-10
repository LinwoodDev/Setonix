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
    on<CellHideChanged>((event, emit) {
      final cell = state.table.cells[event.cell] ?? TableCell();
      final objectIndex = event.object;
      if (objectIndex != null) {
        final object = cell.objects[objectIndex];
        emit(state.copyWith.table.cells.replace(
            event.cell,
            cell.copyWith.objects.replace(objectIndex,
                object.copyWith(hidden: event.hide ?? !object.hidden))));
      } else {
        final hidden =
            !(event.hide ?? cell.objects.firstOrNull?.hidden ?? false);
        emit(state.copyWith.table.cells.replace(
            event.cell,
            cell.copyWith(
              objects:
                  cell.objects.map((e) => e.copyWith(hidden: hidden)).toList(),
            )));
      }
      return save();
    });
    on<CellShuffled>((event, emit) {
      final cell = state.table.cells[event.cell] ?? TableCell();
      emit(state.copyWith.table.cells.replace(
          event.cell,
          cell.copyWith(
            objects: cell.objects.toList()..shuffle(),
          )));
      return save();
    });
    on<ObjectIndexChanged>((event, emit) {
      final cell = state.table.cells[event.cell] ?? TableCell();
      final newObjects = List<GameObject>.from(cell.objects);
      final object = newObjects.removeAt(event.object);
      newObjects.insert(event.index, object);
      emit(state.copyWith.table.cells
          .replace(event.cell, cell.copyWith(objects: newObjects)));
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
