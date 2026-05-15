import 'dart:io';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:consoler/consoler.dart';
import 'package:path/path.dart' as p;
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

String _sanitizeWorldFileName(String worldName) {
  final name = p.basename(worldName);
  if (name.isEmpty || name == '.' || name == '..') {
    return defaultWorldName;
  }
  return name;
}

class WorldBloc extends Bloc<PlayableWorldEvent, WorldState>
    with ServerInterface {
  final SetonixServer server;
  final String worldName;
  late final PluginSystem _pluginSystem;
  late SetonixPlugin _serverPlugin;

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

  final List<(PlayableWorldEvent?, UpdateServerResponse, Set<int>?)>
  _scheduledUpdates = [];

  @override
  void onTransition(Transition<PlayableWorldEvent, WorldState> transition) {
    super.onTransition(transition);
    final updateIndex = _scheduledUpdates.indexWhere(
      (element) => element.$1 == transition.event,
    );
    if (updateIndex != -1) {
      final (_, response, needsUpdate) = _scheduledUpdates.removeAt(
        updateIndex,
      );
      final updatePackets = response.buildUpdatePacketsFor(
        transition.nextState,
        server.channels,
        needsUpdate,
      );
      for (final packet in updatePackets) {
        sendEvent(packet.data, target: packet.channel);
      }
    }
  }

  @override
  void print(String message, [String? plugin]) {
    if (plugin != null && plugin.isNotEmpty) {
      server.log("[$plugin] $message", level: LogLevel.info);
    } else {
      server.log(message, level: LogLevel.info);
    }
  }

  Future<void> _loadScripts(ItemLocation? mode) async {
    pluginSystem.unregisterAll();
    _serverPlugin = await _pluginSystem.registerPlugin('', SetonixPlugin.new);
    try {
      if (mode != null) {
        if (await pluginSystem.loadGameMode(assetManager, mode) == null) {
          server.log(
            'Failed to load game mode script: $mode',
            level: LogLevel.warning,
          );
        }
      }
    } catch (e) {
      server.log('Error loading script: $e', level: LogLevel.error);
    }

    final scriptsFolder = Directory(p.join(server.rootDirectory, 'scripts'));
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
    await _loadScripts(state.info.gameMode);
  }

  Future<void> resetWorld([ItemLocation? mode]) async {
    process(ModeChangeRequest(mode));
    await stream.first;
  }

  Future<void> save({bool force = false}) async {
    final safeWorldName = _sanitizeWorldFileName(worldName);
    var file = File(
      p.join(
        server.rootDirectory,
        SetonixServer.worldDirectory,
        '$safeWorldName${SetonixServer.worldSuffix}',
      ),
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
          serverEvent: process.main?.data,
          target: process.main?.channel ?? kAnyChannel,
          clientEvent: data,
          source: packet.channel,
          needsUpdate: process.needsUpdate,
          worldName: worldName,
        );
        if (!force) {
          await server.defaultWorld.pluginSystem.fire(event);
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
        _scheduledUpdates.add((event.serverEvent, process, event.needsUpdate));
        final serverEvent = event.serverEvent;
        if (serverEvent != null) {
          await sendEvent(serverEvent, target: event.target);
        }
        for (final scheduled in event.scheduledEvents) {
          await onClientEvent(scheduled, force: true);
        }
      case KickServerResponse():
        server.kick(packet.channel, process.message);
    }
  }

  @override
  Future<void> process(WorldEvent event, {bool force = true, String? plugin}) =>
      onClientEvent(NetworkerPacket(event, kAuthorityChannel), force: force);

  @override
  Future<void> sendEvent(
    PlayableWorldEvent event, {
    Channel target = kAnyChannel,
    String? plugin,
  }) => server.sendEvent(event, target: target, worldName: worldName);

  @override
  List<int> get players => server.players.keys.toList(growable: false);
}
