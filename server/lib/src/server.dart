import 'dart:async';
import 'dart:io';

import 'package:consoler/consoler.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/server.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_plugin/native.dart';
import 'package:setonix_server/src/asset.dart';
import 'package:setonix_server/src/bloc.dart';
import 'package:setonix_server/src/config.dart';
import 'package:setonix_server/src/programs/kick.dart';
import 'package:setonix_server/src/programs/packs.dart';
import 'package:setonix_server/src/programs/players.dart';
import 'package:setonix_server/src/programs/reset.dart';
import 'package:setonix_server/src/programs/save.dart';
import 'package:setonix_server/src/programs/say.dart';
import 'package:setonix_server/src/programs/scripts.dart';
import 'package:setonix_server/src/programs/stop.dart';
import 'package:setonix_plugin/setonix_plugin.dart';
import 'package:setonix_server/src/programs/whitelist.dart';
import 'package:setonix_server/src/services/user/file.dart';
import 'package:setonix_server/src/services/user/remote.dart';
import 'package:path/path.dart' as p;

String limitOutput(Object? value, [int limit = 500]) {
  final string = value.toString();
  if (string.length > limit) {
    return '${string.substring(0, limit)}...';
  }
  return string;
}

String? _thumbnailContentType(String path) =>
    switch (p.extension(path).toLowerCase()) {
      '.png' => 'image/png',
      '.jpg' || '.jpeg' => 'image/jpeg',
      '.webp' => 'image/webp',
      _ => null,
    };

bool _isSafeRemoteEndpoint(Uri uri) {
  if (uri.isScheme('https')) return true;
  if (!uri.isScheme('http')) return false;
  return uri.host == 'localhost' ||
      uri.host == '127.0.0.1' ||
      uri.host == '::1';
}

final class SetonixServer {
  static const String worldDirectory = 'worlds';
  static const String worldSuffix = '.stnx';

  final Consoler consoler;
  final ConfigManager configManager;
  final ServerAssetManager assetManager;
  final UserManager userManager;
  final ChallengeManager? challengeManager;
  final String rootDirectory;
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
    PackItem<GameMode>? gameMode;
    if (location != null) {
      gameMode = assetManager
          .getPack(location.namespace)
          ?.getModeItem(location.id, location.namespace);
    }
    final data = SetonixData.fromMode(
      gameMode,
      packs: assetManager.getPackIds().toSet(),
    );
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
    this.rootDirectory,
  );

  static Future<SetonixServer> load({
    String? worldFile,
    SetonixConfig argsConfig = const SetonixConfig(),
  }) async {
    String rootDirectory = Directory.current.path;
    if (Platform.script.scheme == 'file') {
      final scriptDir = p.dirname(Platform.script.toFilePath());
      if (p.basename(scriptDir) == 'bin') {
        rootDirectory = p.dirname(scriptDir);
      }
    }

    final assetManager = ServerAssetManager();
    final consoler = Consoler(
      defaultProgramConfig: DefaultProgramConfiguration(
        description: "Setonix server",
      ),
    );
    await _runStaticLogZone(
      consoler,
      () => assetManager.init(console: consoler, rootPath: rootDirectory),
    );
    final configManager = ConfigManager(argsConfig: argsConfig);
    await configManager.loadConfig(rootPath: rootDirectory);
    final apiEndpoint = configManager.apiEndpoint;
    UserService userService;
    if (apiEndpoint.isNotEmpty) {
      final uri = Uri.tryParse(apiEndpoint);
      if (uri == null || !_isSafeRemoteEndpoint(uri)) {
        throw ArgumentError.value(
          apiEndpoint,
          'apiEndpoint',
          'Remote user API endpoints must use HTTPS, except localhost HTTP.',
        );
      }
      userService = RemoteUserService(
        apiEndpoint: apiEndpoint,
        endpointSecret: configManager.endpointSecret,
      );
    } else {
      final fileService = FileUserService();
      await fileService.setup(rootPath: rootDirectory);
      userService = fileService;
    }
    final userManager = UserManager(
      guestPrefix: configManager.guestPrefix,
      service: userService,
      whitelistEnabled: configManager.whitelistEnabled,
    );
    final challengeManager = configManager.accountRequired
        ? ChallengeManager()
        : null;
    return SetonixServer._(
      consoler,
      assetManager,
      configManager,
      userManager,
      challengeManager,
      rootDirectory,
    );
  }

  void log(Object? message, {LogLevel? level}) =>
      consoler.print(message, level: level);

  Map<int, ConnectionInfo> get players => Map.fromEntries(
    (_server?.clientConnections ?? {}).map(
      (e) => MapEntry(e, _server!.getConnectionInfo(e)!),
    ),
  );

  File? get thumbnailFile {
    final thumbnail = configManager.thumbnail;
    if (thumbnail.isEmpty) return null;
    final path = p.isAbsolute(thumbnail)
        ? thumbnail
        : p.join(rootDirectory, thumbnail);
    return File(path);
  }

  Future<bool> hasThumbnail() async {
    final file = thumbnailFile;
    if (file == null || !await file.exists()) return false;
    final contentType = _thumbnailContentType(file.path);
    if (contentType == null) return false;
    final length = await file.length();
    return length <= kMaxThumbnailSize;
  }

  Future<ServerThumbnail?> loadThumbnail() async {
    final file = thumbnailFile;
    if (file == null || !await file.exists()) return null;
    final contentType = _thumbnailContentType(file.path);
    if (contentType == null) return null;
    final length = await file.length();
    if (length > kMaxThumbnailSize) return null;
    return ServerThumbnail(
      bytes: await file.readAsBytes(),
      contentType: contentType,
    );
  }

  Future<void> init({bool verbose = false}) async {
    if (verbose) {
      consoler.minLogLevel = LogLevel.verbose;
    }
    log(
      "Starting server on ${configManager.host}:${configManager.port}",
      level: LogLevel.info,
    );
    log('Verbose logging activated', level: LogLevel.verbose);
    try {
      await initPluginSystem(
        externalLibrary: await loadExternalPluginLibrary(),
      );
      log('Plugin system initialized', level: LogLevel.info);
    } catch (e) {
      log(
        'Error initializing plugin system: $e, continuing without',
        level: LogLevel.warning,
      );
    }
    SecurityContext? securityContext;
    try {
      final privateKey = await File(
        p.join(rootDirectory, 'certs/server.key'),
      ).readAsBytes();
      final certificate = await File(
        p.join(rootDirectory, 'certs/server.crt'),
      ).readAsBytes();
      securityContext = SecurityContext()
        ..usePrivateKeyBytes(privateKey)
        ..useCertificateChainBytes(certificate);
      log('Certificates found, using secure connection', level: LogLevel.info);
    } on PathNotFoundException catch (_) {
      log(
        'No certificates found, using insecure connection',
        level: LogLevel.warning,
      );
    }
    if (configManager.whitelistEnabled && !configManager.accountRequired) {
      log(
        'Whitelist is enabled, but account requirement is disabled. With no accounts, the whitelist has no effect.',
        level: LogLevel.warning,
      );
    }
    final bindAddress = await _resolveBindAddress(configManager.host);
    final server = _server = NetworkerSocketServer(
      bindAddress,
      configManager.port,
      securityContext: securityContext,
      filterConnections: buildFilterConnections(
        loadProperty: (request) async =>
            (getWorld(request.uri.path) ?? defaultWorld).eventSystem.runPing(
              request,
              GameProperty.defaultProperty.copyWith(
                description: configManager.description,
                hasThumbnail: await hasThumbnail(),
                maxPlayers: configManager.maxPlayers,
                currentPlayers: _server?.clientConnections.length,
                packsSignature: assetManager.createSignature(),
                protocolVersions: kSetonixServerProtocolVersions,
                protocolCapabilities: kSetonixProtocolCapabilities,
              ),
            ),
        loadThumbnail: (_) => loadThumbnail(),
      ),
    );

    final transformer = _pipe = NetworkerPipeTransformer<String, WorldEvent>(
      WorldEventMapper.fromJson,
      (e) => e.toJson(),
    );
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
      'scripts': ScriptsProgram(this),
      null: UnknownProgram(),
    });
    await loadWorlds();
  }

  static Future<InternetAddress> _resolveBindAddress(String host) async {
    final parsed = InternetAddress.tryParse(host);
    if (parsed != null) return parsed;
    final addresses = await InternetAddress.lookup(host);
    return addresses.first;
  }

  void _onClientEvent(
    NetworkerPacket<WorldEvent> packet, {
    bool force = false,
    String? worldName,
  }) => getWorld(
    worldName ?? defaultWorldName,
  )?.onClientEvent(packet, force: force);

  static R _runStaticLogZone<R>(Consoler consoler, R Function() body) =>
      runZoned(
        body,
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, message) {
            consoler.print(message);
          },
        ),
      );

  Future<void> run() async {
    consoler.run();
    log('Server running on ${_server?.address}', level: LogLevel.info);
    await _server?.onClosed.isEmpty;
  }

  Future<void> sendEvent(
    PlayableWorldEvent event, {
    Channel target = kAnyChannel,
    String? worldName,
  }) async {
    final world = getWorld(worldName ?? defaultWorldName);
    final pipeTargets = [];
    if (target == kAnyChannel) {
      pipeTargets.addAll(world?.players ?? [kAnyChannel]);
    } else {
      pipeTargets.add(target);
    }
    for (final channel in pipeTargets) {
      await _pipe?.sendMessage(event, channel);
    }
    if (target == kAnyChannel || target == kAuthorityChannel) {
      world?.add(event);
    }
  }

  void _onJoin((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    final maxPlayers = configManager.maxPlayers;
    if (maxPlayers >= 0 && players.length > maxPlayers) {
      log(
        'Server is full, rejecting connection from ${info.address}',
        level: LogLevel.warning,
      );
      info.close();
      return;
    }
    log('${info.address} ($user) joined the game', level: LogLevel.info);
    _onClientEvent(
      NetworkerPacket(UserJoined(channel: event.$1, info: event.$2), event.$1),
    );
  }

  void _onLeave((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    log('${info.address} ($user) left the game', level: LogLevel.info);
    getUserWorld(user)?.eventSystem.runLeaveCallback(event.$1, event.$2);

    _userWorlds.remove(user);
    userManager.removeUser(user);
    challengeManager?.removeChallenge(user);
  }

  Future<void> loadWorlds() async {
    Map<String, SetonixData> worlds = {};
    final defaultFile = File(
      p.join(rootDirectory, worldDirectory, '$defaultWorldName$worldSuffix'),
    );
    if (await defaultFile.exists()) {
      try {
        final bytes = await defaultFile.readAsBytes();
        worlds[defaultWorldName] = SetonixData.fromData(bytes);
      } catch (e) {
        log(
          'Error loading default world from ${defaultFile.path}: $e',
          level: LogLevel.warning,
        );
      }
    } else {
      worlds[defaultWorldName] = _buildDefaultWorld();
      log('No default world found, creating new one', level: LogLevel.info);
    }
    final dir = Directory(p.join(rootDirectory, worldDirectory));
    if (await dir.exists()) {
      await for (final file in dir.list(recursive: false)) {
        if (file is! File || !file.path.endsWith(worldSuffix)) continue;
        final name = file.path.substring(
          dir.path.length + 1,
          file.path.length - worldSuffix.length,
        );
        if (name == defaultWorldName) continue;
        try {
          final bytes = await file.readAsBytes();
          worlds[name] = SetonixData.fromData(bytes);
        } catch (e) {
          log(
            'Error loading world $name from ${file.path}: $e',
            level: LogLevel.warning,
          );
        }
      }
    }
    for (final entry in worlds.entries) {
      final name = entry.key;
      final data = entry.value;
      final bloc = WorldBloc(data, this, name);
      _worlds[name] = bloc;
      await bloc.init();
      log('Loaded world $name', level: LogLevel.info);
    }
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
    info.close(
      WebSocketStatus.goingAway,
      reason?.toJson() ?? 'You have been kicked from the server.',
    );
    return true;
  }

  void sendMessage(String message, [Channel target = kAnyChannel]) {
    process(MessageSent(kAuthorityChannel, message));
  }

  bool spawnDeck(
    ItemLocation location,
    GlobalVectorDefinition cell, [
    bool force = true,
  ]) {
    final definition = assetManager.getDeck(location);
    if (definition == null) return false;
    final boardSpawn = BoardsSpawnRequest(cell.table);
    for (final board in definition.boards) {
      boardSpawn.board(
        cell.position + board.position,
        ItemLocation.fromString(board.name, location.namespace),
      );
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
