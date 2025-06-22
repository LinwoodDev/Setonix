import 'dart:async';
import 'dart:io';

import 'package:consoler/consoler.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/server.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/asset.dart';
import 'package:setonix_server/src/bloc.dart';
import 'package:setonix_server/src/config.dart';
import 'package:setonix_server/src/programs/kick.dart';
import 'package:setonix_server/src/programs/packs.dart';
import 'package:setonix_server/src/programs/players.dart';
import 'package:setonix_server/src/programs/reset.dart';
import 'package:setonix_server/src/programs/save.dart';
import 'package:setonix_server/src/programs/say.dart';
import 'package:setonix_server/src/programs/stop.dart';
import 'package:setonix_plugin/setonix_plugin.dart';
import 'package:setonix_server/src/programs/whitelist.dart';
import 'package:setonix_server/src/services/user/file.dart';
import 'package:setonix_server/src/services/user/remote.dart';

String limitOutput(Object? value, [int limit = 500]) {
  final string = value.toString();
  if (string.length > limit) {
    return '${string.substring(0, limit)}...';
  }
  return string;
}

final class SetonixServer {
  final Consoler consoler;
  final ConfigManager configManager;
  final ServerAssetManager assetManager;
  final UserManager userManager;
  final ChallengeManager? challengeManager;
  final Map<String, WorldBloc> _worlds = {};
  final Map<Channel, String> _userWorlds = {};

  NetworkerSocketServer? _server;
  NetworkerPipe<dynamic, WorldEvent>? _pipe;

  Set<Channel> get channels => _server?.clientConnections ?? {};

  WorldBloc get defaultWorld =>
      _worlds[defaultWorldName] ??
      (_worlds[defaultWorldName] = WorldBloc(
        _buildDefaultWorld(),
        this,
        defaultWorldName,
      ));

  SetonixData _buildDefaultWorld() {
    final location = configManager.gameMode;
    GameMode? gameMode;
    if (location != null) {
      gameMode = assetManager.getPack(location.namespace)?.getMode(location.id);
    }
    final data = SetonixData.fromMode(location, gameMode).setInfo(GameInfo(
      packs: assetManager.getPackIds().toList(),
    ));
    return data;
  }

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
    this.consoler,
    this.assetManager,
    this.configManager,
    this.userManager,
    this.challengeManager,
  );

  static Future<SetonixServer> load({
    String? worldFile,
    SetonixConfig argsConfig = const SetonixConfig(),
  }) async {
    final assetManager = ServerAssetManager();
    final consoler = Consoler(
      defaultProgramConfig: DefaultProgramConfiguration(
        description: "Setonix server",
      ),
    );
    await _runStaticLogZone(
        consoler, () => assetManager.init(console: consoler));
    final configManager = ConfigManager(argsConfig: argsConfig);
    await configManager.loadConfig();
    final apiEndpoint = configManager.apiEndpoint;
    UserService userService;
    if (apiEndpoint.isNotEmpty) {
      userService = RemoteUserService(apiEndpoint: apiEndpoint);
    } else {
      final fileService = FileUserService();
      await fileService.setup();
      userService = fileService;
    }
    final userManager = UserManager(
        guestPrefix: configManager.guestPrefix,
        service: userService,
        whitelistEnabled: configManager.whitelistEnabled);
    final challengeManager =
        configManager.accountRequired ? ChallengeManager() : null;
    return SetonixServer._(
        consoler, assetManager, configManager, userManager, challengeManager);
  }

  void log(Object? message, {LogLevel? level}) =>
      consoler.print(message, level: level);

  static final String defaultWorldFile = 'world.stnx';

  Map<int, ConnectionInfo> get players =>
      Map.fromEntries((_server?.clientConnections ?? {})
          .map((e) => MapEntry(e, _server!.getConnectionInfo(e)!)));

  Future<void> init({
    bool verbose = false,
  }) async {
    if (verbose) {
      consoler.minLogLevel = LogLevel.verbose;
    }
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
    if (configManager.whitelistEnabled && !configManager.accountRequired) {
      log('Whitelist is enabled, but account requirement is disabled. This allows users to join without an account.',
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
      'kick': KickProgram(this),
      'whitelist': WhitelistProgram(this),
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

    _userWorlds.remove(user);
    userManager.removeUser(user);
    challengeManager?.removeChallenge(user);
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

  bool kick(int id, [KickMessage? reason]) {
    final info = _server?.getConnectionInfo(id);
    if (info == null) return false;
    info.close(WebSocketStatus.goingAway,
        reason?.toJson() ?? 'You have been kicked from the server.');
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
