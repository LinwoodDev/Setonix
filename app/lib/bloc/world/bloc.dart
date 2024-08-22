import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/helpers.dart';
import 'package:networker/networker.dart';
import 'package:quokka/bloc/world/event.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/helpers/asset.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka/bloc/multiplayer.dart';

class WorldBloc extends Bloc<PlayableWorldEvent, WorldState> {
  late final AssetManager assetManager;
  bool _remoteEvent = false;
  WorldBloc({
    required MultiplayerCubit multiplayer,
    required QuokkaFileSystem fileSystem,
    required ColorScheme colorScheme,
    String? name,
    QuokkaData? data,
    GameTable? table,
  }) : super(WorldState(
          multiplayer: multiplayer,
          fileSystem: fileSystem,
          name: name,
          data: data ?? QuokkaData.empty(),
          colorScheme: colorScheme,
          table: table ?? data?.getTable() ?? const GameTable(),
        )) {
    assetManager = AssetManager(
      bloc: this,
    );
    state.multiplayer
      ..events.listen((event) {
        _remoteEvent = true;
        add(event);
        _remoteEvent = false;
      })
      ..inits.listen((e) {
        if (e == 0) return;
        state.multiplayer.sendServer(
            WorldInitialized(
              table: state.table,
              teamMembers: state.teamMembers,
              id: e,
            ),
            e);
      })
      ..serverEvents.listen(_processEvent);

    on<WorldInitialized>((event, emit) {
      emit(state.copyWith(
        table: event.table,
        id: event.id,
        teamMembers: event.teamMembers,
      ));
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
        selectedCell: event.toggle && state.selectedCell == event.cell
            ? null
            : event.cell,
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
    /*on<ObjectVariationChanged>((event, emit) {
      final cell = state.table.cells[event.cell] ?? TableCell();
      if (cell.objects.isEmpty) return null;
      if (!event.object.inRange(0, cell.objects.length - 1)) return null;

      final newCell = cell.copyWith.objects
          .at(event.object)
          .$update((e) => e.copyWith(variation: event.variation));
    });*/
    on<CellHideChanged>((event, emit) {
      final cell = state.table.cells[event.cell] ?? TableCell();
      final objectIndex = event.object;
      if (objectIndex != null) {
        if (cell.objects.isEmpty) return null;
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
      final objects = List<GameObject>.from(cell.objects);
      final positions = event.positions;
      if (positions.any((e) => !e.inRange(0, objects.length - 1))) return null;
      final newObjects = List<GameObject>.from(objects);
      for (var i = 0; i < positions.length; i++) {
        newObjects[positions[i]] = objects[i];
      }
      emit(state.copyWith.table.cells.replace(
          event.cell,
          cell.copyWith(
            objects: newObjects,
          )));
      return save();
    });
    on<VariationChanged>((event, emit) {
      final cell = state.table.cells[event.cell] ?? TableCell();
      if (!event.object.inRange(0, cell.objects.length - 1)) return null;
      final object = cell.objects[event.object];
      emit(state.copyWith.table.cells.replace(
          event.cell,
          cell.copyWith.objects.replace(
              event.object, object.copyWith(variation: event.variation))));
    });
    on<ObjectIndexChanged>((event, emit) {
      final cell = state.table.cells[event.cell] ?? TableCell();
      if (!event.index.inRange(0, cell.objects.length - 1)) return null;
      final object = cell.objects[event.object];
      final newObjects = List<GameObject>.from(cell.objects);
      newObjects.removeAt(event.object);
      newObjects.insert(event.index, object);
      emit(state.copyWith.table.cells
          .replace(event.cell, cell.copyWith(objects: newObjects)));
      return save();
    });
    on<TeamChanged>((event, emit) {
      emit(state.copyWith.info.teams.put(event.name, event.team));
      return save();
    });
    on<TeamRemoved>((event, emit) {
      emit(state.copyWith(
        info: state.info.copyWith.teams.remove(event.team),
        teamMembers: Map.from(state.teamMembers)..remove(event.team),
      ));
      return save();
    });
    on<TeamJoined>((event, emit) {
      if (!state.info.teams.containsKey(event.team)) return null;

      final members = state.teamMembers[event.team];
      emit(state.copyWith(teamMembers: {
        ...state.teamMembers,
        event.team: {...?members, event.user},
      }));
      return save();
    });
    on<TeamLeft>((event, emit) {
      if (!state.info.teams.containsKey(event.team)) return null;

      final members = Set<Channel>.from(state.teamMembers[event.team] ?? {});
      members.remove(event.user);
      final allMembers = Map<String, Set<int>>.from(state.teamMembers);
      if (members.isEmpty) {
        allMembers.remove(event.team);
      } else {
        allMembers[event.team] = members;
      }
      emit(state.copyWith(teamMembers: allMembers));
      return save();
    });
  }

  Future<void> save() async {
    final data = state.save();
    final name = state.name;
    if (name == null) return;
    return state.fileSystem.worldSystem.updateFile(name, data);
  }

  void _processEvent((WorldEvent, Channel) data) {
    final value = processEvent(this, data.$1, data.$2);
    if (value == null) return;
    state.multiplayer.sendServer(value.$1, value.$2);
  }

  @override
  void onEvent(PlayableWorldEvent event) {
    super.onEvent(event);
    if (event is ClientWorldEvent && !_remoteEvent) {
      state.multiplayer.send(event);
    }
  }

  void process(WorldEvent event) {
    switch (event) {
      case LocalWorldEvent e:
        add(e);
      case ServerWorldEvent e:
        add(e);
      case ClientWorldEvent e:
        final multiplayer = state.multiplayer;
        if (multiplayer.isConnected) {
          multiplayer.send(e);
        } else {
          final event =
              processEvent(this, e, kAuthorityChannel, allowServerEvents: true);
          if (event != null) add(event.$1);
        }
    }
  }
}
