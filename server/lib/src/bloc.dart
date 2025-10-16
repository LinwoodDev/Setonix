import 'dart:io';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:consoler/consoler.dart';
import 'package:setonix_server/setonix_server.dart';

Future<ServerProcessed> _computeEvent(
  ServerWorldEvent event,
  WorldState state, {
  required List<SignatureMetadata> signature,
}) {
  return Isolate.run(
    () => processServerEvent(event, state, signature: signature),
  );
}

const scriptSuffix = '.lua';

class WorldBloc extends Bloc<PlayableWorldEvent, WorldState>
    with ServerInterface {
  final SetonixServer server;
  final String worldName;
  late final PluginSystem _pluginSystem;
  late final SetonixPlugin _serverPlugin;

  PluginSystem get pluginSystem => _pluginSystem;

  ServerAssetManager get assetManager => server.assetManager;

  bool get autosave => server.configManager.autosave;

  EventSystem get eventSystem => _serverPlugin.eventSystem;

  WorldBloc(SetonixData data, this.server, this.worldName)
    : super(
        WorldState(
          data: data,
          table: data.getTableOrDefault(),
          metadata: data.getMetadataOrDefault(),
          info: data.getInfoOrDefault(),
        ),
      ) {
    _pluginSystem = PluginSystem(server: this);
    on<ServerWorldEvent>((event, emit) async {
      final signature = assetManager.createSignature();
      final processed = await _computeEvent(
        event,
        state,
        signature: signature.values.toList(),
      );
      final newState = processed.state;
      processed.responses.forEach(process);
      if (event is WorldInitialized) {
        server.log(
          "World initialized${(event.info?.gameMode != null) ? " with script ${event.info?.gameMode}" : ""}",
          level: LogLevel.info,
        );
        await _loadScripts((newState ?? state).info.gameMode);
      }
      if (newState == null) return;
      emit(newState);
      return save();
    }, transformer: sequential());
    on<ImagesUpdated>((event, emit) {
      emit(state.copyWith(images: event.images));
    });
  }

  @override
  void print(String message, [String? plugin]) {
    if (plugin != null && plugin.isNotEmpty) {
      server.log("[$plugin] $message", level: LogLevel.info);
    } else {
      server.log(message, level: LogLevel.info);
    }
  }

  Future<bool> _loadGameMode(ItemLocation location) async {
    final mode = assetManager.getPack(location.namespace)?.getMode(location.id);
    if (mode == null) return false;
    final script = mode.script;
    if (script == null) return false;
    final scriptLocation = ItemLocation.fromString(script, location.namespace);
    return await pluginSystem.loadLuaPluginFromLocation(
          assetManager,
          scriptLocation,
        ) !=
        null;
  }

  Future<void> _loadScripts(ItemLocation? mode) async {
    pluginSystem.unregisterAll();
    try {
      if (mode != null) {
        if (!await _loadGameMode(mode)) {
          server.log(
            'Failed to load game mode script: $mode',
            level: LogLevel.warning,
          );
        }
      }
    } catch (e) {
      server.log('Error loading script: $e', level: LogLevel.error);
    }

    final scriptsFolder = Directory('scripts');
    if (!await scriptsFolder.exists()) {
      await scriptsFolder.create(recursive: true);
    }
    final scriptFiles = (await scriptsFolder.list().toList())
        .whereType<File>()
        .where((file) => file.path.endsWith(scriptSuffix));
    server.log(
      "Found ${scriptFiles.length} script file(s)",
      level: LogLevel.info,
    );
    for (final file in scriptFiles) {
      try {
        final code = await file.readAsString();
        final relativePath = file.path.substring(
          scriptsFolder.path.length + 1,
          file.path.length - scriptSuffix.length,
        );
        await pluginSystem.registerLuauPlugin(relativePath, code);
      } catch (e) {
        server.log(
          'Error loading script from ${file.path}: $e',
          level: LogLevel.warning,
        );
      }
    }
  }

  Future<void> init() async {
    _serverPlugin = await _pluginSystem.registerPlugin('', SetonixPlugin.new);
    await _loadScripts(state.info.gameMode);
  }

  Future<void> resetWorld([ItemLocation? mode]) async {
    process(ModeChangeRequest(mode));
    await stream.first;
  }

  Future<void> save({bool force = false}) async {
    var file = File(
      '${worldName == defaultWorldName ? defaultWorldName : '${SetonixServer.worldDirectory}/$worldName'}${SetonixServer.worldSuffix}',
    );
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    if (!force && autosave) return;
    final bytes = state.save().exportAsBytes();
    await file.writeAsBytes(bytes);
  }

  Future<void> onClientEvent(
    NetworkerPacket<WorldEvent> packet, {
    bool force = false,
  }) async {
    final data = packet.data;
    ServerResponse? process;
    try {
      process = await processClientEvent(
        data is UserJoined ? null : data,
        packet.channel,
        state,
        assetManager: assetManager,
        allowServerEvents: packet.isServer,
        challengeManager: server.challengeManager,
        userManager: server.userManager,
      );
    } catch (e) {
      server.log('Error processing event: $e', level: LogLevel.error);
    }
    if (process == null) return;
    switch (process) {
      case UpdateServerResponse():
        final event = Event(
          serverEvent: process.main.data,
          target: process.main.channel,
          clientEvent: data,
          source: packet.channel,
          needsUpdate: process.needsUpdate,
          worldName: worldName,
        );
        if (!force) {
          server.defaultWorld.pluginSystem.fire(event);
          if (event.cancelled) return;
          server.log(
            'Processing event by ${event.source}: ${limitOutput(event.clientEvent)}, answered with ${limitOutput(event.serverEvent)}',
            level: LogLevel.verbose,
          );
        }
        switch (packet.data) {
          case MessageRequest data:
            server.log(
              "Message by ${packet.channel}: ${data.message}",
              level: LogLevel.info,
            );
          default:
        }
        server.sendEvent(
          event.serverEvent,
          target: event.target,
          worldName: worldName,
        );
        final updatePackets = process.buildUpdatePacketsFor(
          state,
          server.channels,
          event.needsUpdate,
        );
        for (final packet in updatePackets) {
          sendEvent(packet.data, target: packet.channel);
        }
      case KickServerResponse():
        server.kick(packet.channel, process.message);
    }
  }

  @override
  void process(WorldEvent event, {bool force = true, String? plugin}) {
    onClientEvent(NetworkerPacket(event, kAuthorityChannel), force: force);
  }

  @override
  void sendEvent(
    PlayableWorldEvent event, {
    Channel target = kAnyChannel,
    String? plugin,
  }) {
    server.sendEvent(event, target: target, worldName: worldName);
  }

  @override
  List<int> get players => server.players.keys.toList(growable: false);
}
