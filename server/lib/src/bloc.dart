import 'dart:io';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:consoler/consoler.dart';
import 'package:setonix_server/setonix_server.dart';

Future<ServerProcessed> _computeEvent(ServerWorldEvent event, WorldState state,
    List<SignatureMetadata> signature) {
  return Isolate.run(
      () => processServerEvent(event, state, signature: signature));
}

class WorldBloc extends Bloc<PlayableWorldEvent, WorldState> {
  final SetonixServer server;
  final String worldName;

  ServerAssetManager get assetManager => server.assetManager;

  bool get autosave => server.autosave;

  WorldBloc(SetonixData data, this.server, this.worldName)
      : super(WorldState(
          data: data,
          table: data.getTableOrDefault(),
          metadata: data.getMetadataOrDefault(),
          info: data.getInfoOrDefault(),
        )) {
    on<ServerWorldEvent>((event, emit) async {
      final signature = assetManager.createSignature();
      final processed =
          await _computeEvent(event, state, signature.values.toList());
      final newState = processed.state;
      processed.responses.forEach(process);
      if (event is WorldInitialized) {
        server.log(
            "World initialized${(event.info?.script != null) ? " with script ${event.info?.script}" : ""}",
            level: LogLevel.info);
        await _loadScript((newState ?? state).info.script);
      }
      if (newState == null) return;
      emit(newState);
      return save();
    }, transformer: sequential());
    on<ImagesUpdated>((event, emit) {
      emit(state.copyWith(images: event.images));
    });
  }

  Future<void> _loadScript(String? script) async {
    try {
      if (script == null) return;
      server.pluginSystem.loadLuaPlugin(assetManager, script);
    } catch (e) {
      server.log('Error loading script: $e', level: LogLevel.error);
    }
  }

  Future<void> init() async {
    await _loadScript(state.info.script);
  }

  Future<void> resetWorld([ItemLocation? mode]) async {
    process(ModeChangeRequest(mode));
    await stream.first;
  }

  Future<void> save({bool force = false}) async {
    var file = File(worldName == defaultWorldName
        ? 'world.stnx'
        : 'worlds/$worldName.stnx');
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    if (!force && autosave) return;
    final bytes = state.save().exportAsBytes();
    await file.writeAsBytes(bytes);
  }

  void onClientEvent(NetworkerPacket<WorldEvent> packet,
      {bool force = false}) async {
    final data = packet.data;
    ServerResponse? process;
    try {
      process = processClientEvent(
        data is UserJoined ? null : data,
        packet.channel,
        state,
        assetManager: assetManager,
        allowServerEvents: packet.isServer,
      );
    } catch (e) {
      server.log('Error processing event: $e', level: LogLevel.error);
    }
    if (process == null) return;
    final event = Event(
      serverEvent: process.main.data,
      target: process.main.channel,
      clientEvent: data,
      source: packet.channel,
      needsUpdate: process.needsUpdate,
      worldName: worldName,
    );
    if (!force) {
      server.eventSystem.fire(event);
      if (event.cancelled) return;
      server.log(
          'Processing event by ${event.source}: ${limitOutput(event.clientEvent)}, answered with ${limitOutput(event.serverEvent)}',
          level: LogLevel.verbose);
    }
    switch (packet.data) {
      case MessageRequest data:
        server.log("Message by ${packet.channel}: ${data.message}",
            level: LogLevel.info);
      default:
    }
    server.sendEvent(event.serverEvent,
        target: event.target, worldName: worldName);
    final updatePackets = process.buildUpdatePacketsFor(
        state, server.channels, event.needsUpdate);
    for (final packet in updatePackets) {
      sendEvent(packet.data, target: packet.channel);
    }
  }

  void process(WorldEvent event, [bool force = true]) {
    onClientEvent(NetworkerPacket(event, kAuthorityChannel), force: force);
  }

  void sendEvent(PlayableWorldEvent event, {required Channel target}) {
    server.sendEvent(event, target: target, worldName: worldName);
  }
}
