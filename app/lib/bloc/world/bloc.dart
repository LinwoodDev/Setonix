import 'package:flutter/material.dart' show ColorScheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networker/networker.dart';
import 'package:quokka/bloc/world/local.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/helpers/asset.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka/bloc/multiplayer.dart';
import 'package:quokka_api/quokka_api.dart';

class WorldBloc extends Bloc<PlayableWorldEvent, ClientWorldState> {
  late final GameAssetManager assetManager;
  bool _remoteEvent = false;
  WorldBloc({
    required MultiplayerCubit multiplayer,
    required QuokkaFileSystem fileSystem,
    required ColorScheme colorScheme,
    String? name,
    QuokkaData? data,
    GameTable? table,
  }) : super(ClientWorldState(
          multiplayer: multiplayer,
          fileSystem: fileSystem,
          name: name,
          data: data ?? QuokkaData.empty(),
          colorScheme: colorScheme,
          table: table ?? data?.getTable() ?? const GameTable(),
          metadata: data?.getMetadata() ?? const FileMetadata(),
          info: data?.getInfo() ?? const GameInfo(),
        )) {
    assetManager = GameAssetManager(
      bloc: this,
    );
    state.multiplayer
      ..events.listen((event) {
        _remoteEvent = true;
        add(event);
        _remoteEvent = false;
      })
      ..inits.listen((e) {
        if (e.$1 == kAnyChannel) return;
        _processEvent((null, e.$1));
      })
      ..serverEvents.listen(_processEvent);

    on<ServerWorldEvent>((event, emit) {
      try {
        final newState =
            processServerEvent(event, state, assetManager: assetManager);
        if (newState is! ClientWorldState) return null;
        emit(newState);
        return save();
      } on FatalServerEventError catch (e) {
        state.multiplayer.raiseError(e);
      }
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
  }

  Future<void> save() async {
    final data = state.save();
    final name = state.name;
    if (name == null) return;
    return state.fileSystem.worldSystem.updateFile(name, data);
  }

  void _processEvent((WorldEvent?, Channel) data) {
    final value =
        processClientEvent(data.$1, data.$2, state, assetManager: assetManager);
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
      case ClientWorldEvent e:
        final multiplayer = state.multiplayer;
        if (multiplayer.isConnected) {
          multiplayer.send(e);
        } else {
          final event = processClientEvent(e, kAuthorityChannel, state,
              assetManager: assetManager, allowServerEvents: true);
          if (event != null) add(event.$1);
        }
      case ServerWorldEvent e:
        add(e);
    }
  }

  Iterable<MapEntry<String, QuokkaData>> get packs =>
      assetManager.packs.where((e) => state.info.packs.contains(e.key));
}
