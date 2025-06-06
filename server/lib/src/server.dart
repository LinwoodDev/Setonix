import 'dart:async';
import 'dart:io';

import 'package:consoler/consoler.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/server.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/asset.dart';
import 'package:setonix_server/src/bloc.dart';
import 'package:setonix_server/src/config.dart';
import 'package:setonix_server/src/programs/packs.dart';
import 'package:setonix_server/src/programs/players.dart';
import 'package:setonix_server/src/programs/reset.dart';
import 'package:setonix_server/src/programs/save.dart';
import 'package:setonix_server/src/programs/say.dart';
import 'package:setonix_server/src/programs/stop.dart';
import 'package:setonix_plugin/setonix_plugin.dart';

String limitOutput(Object? value, [int limit = 500]) {
  final string = value.toString();
  if (string.length > limit) {
    return '${string.substring(0, limit)}...';
  }
  return string;
}

final class SetonixServer {
  final Consoler consoler;
  final ConfigManager configManager = ConfigManager();
  final ServerAssetManager assetManager;
  final String? worldFile;
  final Map<String, WorldBloc> _worlds = {};
  final Map<Channel, String> _userWorlds = {};
  late final PluginSystem pluginSystem;

  NetworkerSocketServer? _server;
  NetworkerPipe<dynamic, WorldEvent>? _pipe;

  Set<Channel> get channels => _server?.clientConnections ?? {};

  WorldBloc get defaultWorld =>
      _worlds[defaultWorldName] ??
      (_worlds[defaultWorldName] = WorldBloc(
        SetonixData.empty(),
        this,
        defaultWorldName,
      ));

  EventSystem get defaultEventSystem => defaultWorld.eventSystem;

  WorldState get defaultState => defaultWorld.state;

  WorldBloc? getWorld(String name) => _worlds[name];

  String getUserWorldName(Channel channel) =>
      _userWorlds[channel] ?? defaultWorldName;

  WorldBloc? getUserWorld(Channel channel) =>
      getWorld(getUserWorldName(channel));

  WorldState? getUserWorldState(Channel channel) =>
      getUserWorld(channel)?.state;

  SetonixServer._(
      this.worldFile, this.consoler, SetonixData data, this.assetManager);

  static Future<SetonixServer> load({
    String? worldFile,
    bool disableLoading = false,
  }) async {
    final assetManager = ServerAssetManager();
    final consoler = Consoler(
      defaultProgramConfig: DefaultProgramConfiguration(
        description: "Setonix server",
      ),
    );
    await _runStaticLogZone(
        consoler, () => assetManager.init(console: consoler));
    worldFile ??= defaultWorldFile;
    final file = File(worldFile);
    SetonixData? data;
    if (!disableLoading && await file.exists()) {
      final bytes = await file.readAsBytes();
      data = SetonixData.fromData(bytes);
    }
    data ??= SetonixData.empty().setInfo(GameInfo(
      packs: assetManager.getPackIds().toList(),
    ));
    return SetonixServer._(worldFile, consoler, data, assetManager);
  }

  void log(Object? message, {LogLevel? level}) =>
      consoler.print(message, level: level);

  static final String defaultWorldFile = 'world.stnx';

  Map<int, ConnectionInfo> get players =>
      Map.fromEntries((_server?.clientConnections ?? {})
          .map((e) => MapEntry(e, _server!.getConnectionInfo(e)!)));

  Future<void> init({
    SetonixConfig argsConfig = const SetonixConfig(),
    bool verbose = false,
  }) async {
    if (verbose) {
      consoler.minLogLevel = LogLevel.verbose;
    }
    configManager.setArgsConfig(argsConfig);
    await configManager.loadConfig();
    log("Starting server on ${configManager.host}:${configManager.port}",
        level: LogLevel.info);
    log('Verbose logging activated', level: LogLevel.verbose);
    try {
      await initPluginSystem();
      log('Plugin system initialized', level: LogLevel.info);
    } catch (e) {
      log('Error initializing plugin system: $e, continuing without',
          level: LogLevel.warning);
    }
    SecurityContext? securityContext;
    try {
      final privateKey = await File('certs/server.key').readAsBytes();
      final certificate = await File('certs/server.crt').readAsBytes();
      securityContext = SecurityContext()
        ..usePrivateKeyBytes(privateKey)
        ..useCertificateChainBytes(certificate);
      log('Certificates found, using secure connection', level: LogLevel.info);
    } on PathNotFoundException catch (_) {
      log('No certificates found, using insecure connection',
          level: LogLevel.warning);
    }
    final server = _server = NetworkerSocketServer(
        InternetAddress.anyIPv4, configManager.port,
        securityContext: securityContext,
        filterConnections: buildFilterConnections(
            loadProperty: (request) =>
                (getWorld(request.uri.path) ?? defaultWorld)
                    .eventSystem
                    .runPing(
                        request,
                        GameProperty.defaultProperty.copyWith(
                          description: configManager.description,
                          maxPlayers: configManager.maxPlayers,
                          currentPlayers: _server?.clientConnections.length,
                          packsSignature: assetManager.createSignature(),
                        ))));

    final transformer = _pipe = NetworkerPipeTransformer<String, WorldEvent>(
        WorldEventMapper.fromJson, (e) => e.toJson());
    transformer.read.listen(_onClientEvent);
    server
      ..clientConnect.listen(_onJoin)
      ..clientDisconnect.listen(_onLeave)
      ..connect(StringNetworkerPlugin()..connect(transformer));
    await _server?.init();

    consoler.registerPrograms({
      'stop': StopProgram(this),
      'save': SaveProgram(this),
      'packs': PacksProgram(this),
      'players': PlayersProgram(this),
      'say': SayProgram(this),
      'reset': ResetProgram(this),
      null: UnknownProgram(),
    });
  }

  void _onClientEvent(NetworkerPacket<WorldEvent> packet,
          {bool force = false, String? worldName}) =>
      getWorld(worldName ?? defaultWorldName)?.onClientEvent(
        packet,
        force: force,
      );

  static R _runStaticLogZone<R>(Consoler consoler, R Function() body) =>
      runZoned(body, zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, message) {
          consoler.print(message);
        },
      ));

  Future<void> run() async {
    consoler.run();
    log('Server running on ${_server?.address}', level: LogLevel.info);
    await _server?.onClosed.first;
  }

  void sendEvent(PlayableWorldEvent event,
      {Channel target = kAnyChannel, String? worldName}) {
    _pipe?.sendMessage(event, target);
    if (target == kAnyChannel || target == kAuthorityChannel) {
      getWorld(worldName ?? defaultWorldName)?.add(event);
    }
  }

  void _onJoin((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    final maxPlayers = configManager.maxPlayers;
    if (maxPlayers >= 0 && players.length > maxPlayers) {
      log('Server is full, rejecting connection from ${info.address}',
          level: LogLevel.warning);
      info.close();
      return;
    }
    log('${info.address} ($user) joined the game', level: LogLevel.info);
    _onClientEvent(NetworkerPacket(
        UserJoined(channel: event.$1, info: event.$2), event.$1));
  }

  void _onLeave((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    log('${info.address} ($user) left the game', level: LogLevel.info);
    getUserWorld(user)?.eventSystem.runLeaveCallback(event.$1, event.$2);
  }

  Future<void> saveAll({bool force = false}) async {
    await Future.wait(_worlds.values.map((e) => e.save(force: force)));
  }

  Future<void> close() async {
    for (final world in _worlds.values) {
      await world.close();
    }
    log('Closing...', level: LogLevel.info);
    _server?.close();
    consoler.dispose();
  }

  void process(WorldEvent event, [bool force = true]) {
    _onClientEvent(NetworkerPacket(event, kAuthorityChannel), force: force);
  }

  bool kick(int id) {
    final info = _server?.getConnectionInfo(id);
    if (info == null) return false;
    info.close();
    return true;
  }

  void sendMessage(String message, [Channel target = kAnyChannel]) {
    process(MessageSent(kAuthorityChannel, message));
  }

  bool spawnDeck(ItemLocation location, GlobalVectorDefinition cell,
      [bool force = true]) {
    final definition = assetManager.getDeck(location);
    if (definition == null) return false;
    final boardSpawn = BoardsSpawnRequest(cell.table);
    for (final board in definition.boards) {
      boardSpawn.board(cell.position + board.position,
          ItemLocation.fromString(board.name, location.namespace));
    }
    final objectSpawn = ObjectsSpawned(cell.table);
    for (final object in definition.figures) {
      objectSpawn.objectWithLocation(
        object.position + cell.position,
        ItemLocation.fromString(object.name, location.namespace),
        variation: object.variation,
      );
    }
    process(boardSpawn, force);
    process(objectSpawn, force);
    return true;
  }
}
