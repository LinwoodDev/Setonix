import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/helpers.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/bloc/board_state.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka/bloc/multiplayer.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc({
    required MultiplayerCubit multiplayer,
    required QuokkaFileSystem fileSystem,
    required ColorScheme colorScheme,
    String? name,
    QuokkaData? data,
    GameTable? table,
  }) : super(BoardState(
          multiplayer: multiplayer,
          fileSystem: fileSystem,
          name: name,
          data: data ?? QuokkaData.empty(),
          colorScheme: colorScheme,
          table: table ?? data?.getTable() ?? const GameTable(),
        )) {
    state.multiplayer
      ..events.listen(add)
      ..inits.listen((e) {
        if (e == 0) return;
        state.multiplayer.send(TableChanged(state.table), e);
      });

    on<TableChanged>((event, emit) {
      emit(state.copyWith(table: event.table));
      return save();
    });
    on<BackgroundChanged>((event, emit) {
      emit(state.copyWith.table(background: event.background));
    });
    on<ColorSchemeChanged>((event, emit) {
      emit(state.copyWith(colorScheme: event.colorScheme));
    });
    on<HandChanged>((event, emit) {
      emit(state.copyWith(
        showHand: event.show ??
            (!state.showHand ||
                state.selectedDeck != event.deck ||
                state.selectedCell != null),
        selectedDeck: event.deck,
        selectedCell: null,
      ));
    });
    on<CellSwitched>((event, emit) {
      emit(state.copyWith(
        selectedCell: event.cell,
        selectedDeck: null,
        showHand: true,
      ));
    });
    on<ObjectsSpawned>((event, emit) {
      final cell = (state.table.cells[event.cell] ?? TableCell());
      emit(state.copyWith.table.cells.replace(event.cell,
          cell.copyWith(objects: [...cell.objects, ...event.objects])));
      return save();
    });
    on<ObjectsMoved>((event, emit) {
      if (event.from == event.to) return null;
      var from = state.table.cells[event.from] ?? TableCell();
      var to = state.table.cells[event.to] ?? TableCell();
      final toRemove = event.objects;
      if (event.objects.any((e) => e >= from.objects.length)) return null;
      final toAdd = toRemove.map((e) => from.objects[e]).toList();
      final newObjects = List<GameObject>.from(from.objects);
      for (final i in toRemove.sorted((a, b) => b.compareTo(a))) {
        newObjects.removeAt(i);
      }
      from = from.copyWith(objects: newObjects);
      to = to.copyWith(objects: [
        ...to.objects,
        ...toAdd,
      ]);
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
        if (!objectIndex.inRange(0, cell.objects.length - 1)) return null;
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
      final random = Random(event.seed);
      emit(state.copyWith.table.cells.replace(
          event.cell,
          cell.copyWith(
            objects: cell.objects.toList()..shuffle(random),
          )));
      return save();
    });
    on<ObjectIndexChanged>((event, emit) {
      final cell = state.table.cells[event.cell] ?? TableCell();
      final object = cell.objects[event.object];
      final newObjects = List<GameObject>.from(cell.objects);
      newObjects.removeAt(event.object);
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

  @override
  void onEvent(BoardEvent event) {
    super.onEvent(event);
    if (event.isMultiplayer) state.multiplayer.send(event);
  }

  void send(BoardEvent event) {
    if (event.isMultiplayer && state.multiplayer.isConnected) {
      if (state.multiplayer.isServer) add(event);
      state.multiplayer.send(event);
    } else {
      add(event);
    }
  }
}
