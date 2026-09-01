import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networker/networker.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/helpers/asset.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_plugin/setonix_plugin.dart';

ServerProcessed _compute(
  (ServerWorldEvent, WorldState, List<SignatureMetadata>) m,
) => processServerEvent(m.$1, m.$2, signature: m.$3);

SetonixData _saveState((WorldState, Map<String, String>) data) =>
    data.$1.save().setScriptStates(data.$2);

class _WorldServerInterfaceImpl implements ServerInterface {
  final WorldBloc bloc;

  _WorldServerInterfaceImpl(this.bloc);

  @override
  Future<void> process(
    WorldEvent event, {
    bool force = false,
    required String plugin,
  }) => bloc.process(event);

  @override
  Future<void> sendEvent(
    PlayableWorldEvent event, {
    Channel target = kAnyChannel,
    required String plugin,
  }) => bloc._processEvent(
    NetworkerPacket(event, target),
    allowServerEvents: true,
    triggerPlugin: false,
  );

  @override
  void print(String message, [String? plugin]) {
    // TODO: implement better logging
  }

  @override
  WorldState get state => bloc.state.world;

  @override
  List<int> get players => bloc.state.multiplayer.clients.toList();

  @override
  String getScriptState(String plugin) => bloc._scriptStates[plugin] ?? '{}';

  @override
  void setScriptState(String plugin, String state) {
    bloc._scriptStates[plugin] = state;
    if (!bloc._isSaving) {
      unawaited(bloc.save(collectScriptState: false));
    }
  }
}

class WorldBloc extends Bloc<PlayableWorldEvent, ClientWorldState> {
  late final PluginSystem pluginSystem;
  late final Map<String, String> _scriptStates;
  bool _isSaving = false;
  bool _remoteEvent = false;
  WorldBloc({
    required MultiplayerCubit multiplayer,
    required ColorScheme colorScheme,
    required SetonixFileSystem fileSystem,
    String? name,
    SetonixData? data,
    GameTable? table,
    GameState gameState = GameState.play,
  }) : super(
         ClientWorldState(
           assetManager: GameAssetManager(fileSystem: fileSystem),
           multiplayer: multiplayer,
           colorScheme: colorScheme,
           world: WorldState(
             name: name,
             data: data ?? SetonixData.empty(),
             table: table ?? data?.getTable() ?? const GameTable(),
             metadata: data?.getMetadata() ?? const FileMetadata(),
             info: data?.getInfo() ?? const GameInfo(),
             gameState: gameState,
           ),
         ),
       ) {
    _scriptStates = Map.from(state.world.data.getScriptStates());
    pluginSystem = PluginSystem(server: _WorldServerInterfaceImpl(this));
    state.multiplayer
      ..events.listen((event) {
        _remoteEvent = true;
        add(event);
        _remoteEvent = false;
      })
      ..inits.listen((e) {
        if (e.$1 == kAnyChannel) return;
        _processEvent(NetworkerPacket(null, e.$1));
      })
      ..serverEvents.listen(_processEvent);

    on<CellSwitched>((event, emit) {
      emit(
        state.copyWith(
          selectedCell: event.selected ? event.cell : state.selectedCell,
          selectedDeck: null,
          showHand: true,
        ),
      );
    });
    on<ServerWorldEvent>((event, emit) async {
      try {
        if (event is AuthenticatedRequested) {
          final multiplayerState = state.multiplayer.state;
          final expected = multiplayerState is MultiplayerConnectedState
              ? multiplayerState.serverIdentity
              : null;
          requireAuthenticationOrigin(event, expected);
        }
        final signature = state.assetManager.createSignature();
        final world = state.world;
        final processed =
            await compute<
              (ServerWorldEvent, WorldState, List<SignatureMetadata>),
              ServerProcessed
            >(_compute, (event, world, signature.values.toList()));
        final newWorld = processed.state;
        processed.responses.forEach(process);
        if (newWorld == null) return;
        emit(state.copyWith(world: newWorld));
        return await save();
      } on FatalServerEventError catch (e) {
        state.multiplayer.raiseError(e);
      }
    }, transformer: sequential());
    on<ColorSchemeChanged>((event, emit) {
      emit(state.copyWith(colorScheme: event.colorScheme));
    });
    on<HandChanged>((event, emit) {
      emit(
        state.copyWith(
          showHand:
              event.show ??
              (!state.showHand ||
                  state.selectedDeck != event.deck ||
                  state.selectedCell != null),
          selectedDeck: event.deck,
          selectedCell: null,
        ),
      );
    });
    on<SwitchCellOnMoveChanged>((event, emit) {
      emit(state.copyWith(switchCellOnMove: event.value));
    });
    on<WaypointVisibilityChanged>((event, emit) {
      emit(state.copyWith(showWaypoints: event.value));
    });
    on<TableSwitched>((event, emit) {
      emit(
        state.copyWith.world(
          table: state.world.getTableOrDefault(event.name),
          tableName: event.name,
          data: state.world.data.setTable(
            state.world.table,
            state.world.tableName,
          ),
        ),
      );
    });
    on<DrawerViewChanged>((event, emit) {
      emit(state.copyWith(drawerView: event.view));
    });
    on<SearchTermChanged>((event, emit) {
      emit(state.copyWith(searchTerm: event.term));
    });
    on<ShowDuplicatesChanged>((event, emit) {
      emit(
        state.copyWith(showDuplicates: event.value ?? !state.showDuplicates),
      );
    });
  }

  Future<void> init({bool localPlayer = true}) async {
    if (!state.multiplayer.isClient) {
      await _loadGameMode(state.world.info.gameMode);
      if (localPlayer) {
        await _processEvent(NetworkerPacket(null, kAuthorityChannel));
      }
    }
  }

  Future<void> save({bool collectScriptState = true}) async {
    if (_isSaving) return;
    _isSaving = true;
    try {
      if (collectScriptState) {
        await pluginSystem.collectState();
      }
      final data = await compute(_saveState, (
        state.world,
        Map.of(_scriptStates),
      ));
      final name = state.world.name;
      if (name == null) return;
      return await state.fileSystem.worldSystem.updateFile(name, data);
    } finally {
      _isSaving = false;
    }
  }

  Future<void> _processEvent(
    NetworkerPacket<WorldEvent?> data, {
    bool allowServerEvents = false,
    bool triggerPlugin = true,
  }) async {
    bool isLocalTarget(Channel channel) =>
        channel == kAnyChannel ||
        channel == kAuthorityChannel ||
        channel == state.world.id;

    final multiplayer = state.multiplayer;
    final rawMultiplayerState = multiplayer.state;
    final multiplayerState = rawMultiplayerState is MultiplayerConnectedState
        ? rawMultiplayerState
        : null;
    final challengeManager = multiplayerState?.challengeManager;
    final inputEvent = data.data;
    if (multiplayer.isServer &&
        data.channel != kAuthorityChannel &&
        inputEvent is AuthenticateRequest &&
        !multiplayer.allowAuthenticationAttempt(data.channel)) {
      multiplayer.kick(data.channel);
      return;
    }
    if (multiplayer.isServer &&
        challengeManager != null &&
        inputEvent is ClientWorldEvent &&
        inputEvent is! AuthenticateRequest &&
        multiplayerState?.userManager.getUser(data.channel) == null) {
      return;
    }
    final value = await processClientEvent(
      inputEvent,
      data.channel,
      state.world,
      assetManager: state.assetManager,
      userManager: state.multiplayer.state.userManager,
      challengeManager: challengeManager,
      allowServerEvents: allowServerEvents,
    );
    if (value == null) return;
    switch (value) {
      case UpdateServerResponse():
        if (inputEvent is AuthenticateRequest &&
            multiplayerState?.userManager.getUser(data.channel) != null) {
          multiplayer.completeAuthentication(data.channel);
        }
        final event = Event(
          serverEvent: value.main?.data,
          target: value.main?.channel ?? kAnyChannel,
          clientEvent:
              data.data ??
              UserJoined(
                channel: data.channel,
                info: const ConnectionInfoMapper().decode({}),
              ),
          source: data.channel,
          needsUpdate: value.needsUpdate,
          worldName: state.world.name ?? '',
        );
        if (triggerPlugin) {
          await pluginSystem.fire(event);
          if (event.cancelled) return;
        }

        final packets = <NetworkerPacket<ServerWorldEvent>>[];
        final serverEvent = event.serverEvent;
        if (serverEvent != null) {
          packets.add(NetworkerPacket(serverEvent, event.target));
        }
        packets.addAll(
          value.buildUpdatePacketsFor(
            state.world,
            state.multiplayer.clients,
            event.needsUpdate,
          ),
        );
        state.multiplayer.sendServerPackets(packets);
        if (!state.multiplayer.isConnected) {
          for (final packet in packets) {
            if (isLocalTarget(packet.channel)) {
              final event = packet.data;
              add(
                data.data == null &&
                        data.channel == kAuthorityChannel &&
                        event is WorldInitialized
                    ? WorldInitialized(
                        info: event.info,
                        teamMembers: event.teamMembers,
                        id: event.id,
                        packsSignature: event.packsSignature,
                        clearUserInterface: event.clearUserInterface,
                      )
                    : event,
              );
            }
          }
        }

        for (final scheduled in event.scheduledEvents) {
          await _processEvent(
            scheduled,
            allowServerEvents: true,
            triggerPlugin: false,
          );
        }
      case KickServerResponse():
        multiplayer.kick(data.channel);
    }
  }

  @override
  void onEvent(PlayableWorldEvent event) {
    super.onEvent(event);
    if (event is ClientWorldEvent && !_remoteEvent) {
      state.multiplayer.send(event);
    }
  }

  Future<void> process(WorldEvent event) async {
    switch (event) {
      case LocalWorldEvent e:
        add(e);
      case ClientWorldEvent e:
        final multiplayer = state.multiplayer;
        if (multiplayer.isConnected) {
          multiplayer.send(e);
        } else {
          final response = await processClientEvent(
            e,
            kAuthorityChannel,
            state.world,
            assetManager: state.assetManager,
            allowServerEvents: true,
          );
          if (response is! UpdateServerResponse) break;
          final event = Event(
            serverEvent: response.main?.data,
            target: response.main?.channel ?? kAnyChannel,
            clientEvent: e,
            source: kAuthorityChannel,
            needsUpdate: response.needsUpdate,
            worldName: state.world.name ?? '',
          );
          await pluginSystem.fire(event);
          if (event.cancelled) return;
          final result = event.serverEvent;
          if (result != null) add(result);
          final updatePacket = response.buildUpdatePacketsFor(state.world, {
            kAuthorityChannel,
          }, event.needsUpdate).firstOrNull;
          if (updatePacket != null) {
            add(updatePacket.data);
          }

          for (final scheduled in event.scheduledEvents) {
            await _processEvent(
              scheduled,
              allowServerEvents: true,
              triggerPlugin: false,
            );
          }
        }
      case ServerWorldEvent e:
        add(e);
    }
  }

  Future<void> _loadGameMode(ItemLocation? location) async {
    await pluginSystem.closeAll();
    await pluginSystem.registerPlugin('', SetonixPlugin.new);
    if (kIsWeb) return;
    try {
      if (location == null) return;
      await pluginSystem.loadGameMode(state.assetManager, location);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading game mode: $e');
      }
    }
  }

  @override
  Future<void> close() async {
    await save();
    await pluginSystem.closeAll();
    await save(collectScriptState: false);
    return super.close();
  }
}
