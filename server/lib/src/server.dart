import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:consoler/consoler.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/server.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka_server/src/asset.dart';
import 'package:quokka_server/src/events/system.dart';
import 'package:quokka_server/src/programs/packs.dart';
import 'package:quokka_server/src/programs/players.dart';
import 'package:quokka_server/src/programs/save.dart';
import 'package:quokka_server/src/programs/say.dart';
import 'package:quokka_server/src/programs/stop.dart';

import 'events/model.dart';

Future<WorldState?> _computeEvent(ServerWorldEvent event, WorldState state,
    Map<String, FileMetadata> signature) {
  return Isolate.run(
      () => processServerEvent(event, state, signature: signature));
}

final class QuokkaServer extends Bloc<PlayableWorldEvent, WorldState> {
  final Consoler consoler;
  final ServerAssetManager assetManager;
  final String? worldFile;
  final eventSystem = EventSystem();
  bool autosave = false;

  NetworkerSocketServer? _server;
  NetworkerPipe<dynamic, WorldEvent>? _pipe;

  QuokkaServer._(
      this.worldFile, this.consoler, QuokkaData data, this.assetManager)
      : super(WorldState(
          data: data,
          table: data.getTableOrDefault(),
          metadata: data.getMetadataOrDefault(),
          info: data.getInfoOrDefault(),
        )) {
    on<ServerWorldEvent>((event, emit) async {
      final signature = assetManager.createSignature();
      final newState = await _computeEvent(event, state, signature);
      if (newState == null) return;
      emit(newState);
      return save();
    }, transformer: sequential());
  }

  static Future<QuokkaServer> load({
    String? worldFile,
    bool disableLoading = false,
  }) async {
    final assetManager = ServerAssetManager();
    final consoler = Consoler(
      defaultProgramConfig: DefaultProgramConfiguration(
        description: "Quokka server",
      ),
    );
    await _runStaticLogZone(
        consoler, () => assetManager.init(console: consoler));
    worldFile ??= defaultWorldFile;
    final file = File(worldFile);
    QuokkaData? data;
    if (!disableLoading && await file.exists()) {
      final bytes = await file.readAsBytes();
      data = QuokkaData.fromData(bytes);
    }
    data ??= QuokkaData.empty().setInfo(GameInfo(
      packs: assetManager.packs.map((e) => e.key).toList(),
    ));
    return QuokkaServer._(worldFile, consoler, data, assetManager);
  }

  void log(Object? message, {LogLevel? level}) =>
      consoler.print(message, level: level);

  static final String defaultWorldFile = 'world.qka';

  Map<int, ConnectionInfo> get players =>
      Map.fromEntries((_server?.clientConnections ?? {})
          .map((e) => MapEntry(e, _server!.getConnectionInfo(e)!)));

  Future<void> init({
    int port = kDefaultPort,
    bool verbose = false,
    bool autosave = false,
    String description = '',
  }) async {
    if (verbose) {
      consoler.minLogLevel = LogLevel.verbose;
    }
    log("Starting server on port $port", level: LogLevel.info);
    log('Verbose logging activated', level: LogLevel.verbose);
    this.autosave = autosave;
    final server =
        _server = NetworkerSocketServer(InternetAddress.anyIPv4, port,
            filterConnections: buildFilterConnections(
                loadProperty: (request) => eventSystem.runPing(
                    request,
                    GameProperty.defaultProperty.copyWith(
                      description: description,
                    ))));
    final transformer = _pipe = NetworkerPipeTransformer<String, WorldEvent>(
        WorldEventMapper.fromJson, (e) => e.toJson());
    transformer.read.listen(_onClientEvent);
    server
      ..clientConnect.listen(_onJoin)
      ..clientDisconnect.listen(_onLeave)
      ..connect(StringNetworkerPlugin()..connect(transformer));
    await _server?.init();

    consoler.registerProgram('stop', StopProgram(this));
    consoler.registerProgram('save', SaveProgram(this));
    consoler.registerProgram('packs', PacksProgram(this));
    consoler.registerProgram('players', PlayersProgram(this));
    consoler.registerProgram('say', SayProgram(this));
    consoler.registerProgram(null, UnknownProgram());
  }

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

  void _onClientEvent(NetworkerPacket<WorldEvent?> packet) async {
    final data = packet.data;
    final process = processClientEvent(
      data,
      packet.channel,
      state,
      assetManager: assetManager,
    );
    if (process == null) return;
    final event = Event(this, process.$1, process.$2, data, packet.channel);
    eventSystem.fire(event);
    if (event.cancelled) return;
    log('Processing event by ${event.source}: ${event.serverEvent}',
        level: LogLevel.verbose);
    switch (packet.data) {
      case MessageRequest data:
        log("Message by ${packet.channel}: ${data.message}",
            level: LogLevel.info);
      default:
    }
    sendEvent(event.serverEvent, event.target);
  }

  void sendEvent(PlayableWorldEvent event, [Channel target = kAnyChannel]) {
    _pipe?.sendMessage(event, target);
    if (target == kAnyChannel || target == kAuthorityChannel) {
      add(event);
    }
  }

  void _onJoin((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    log('${info.address} ($user) joined the game', level: LogLevel.info);
    _onClientEvent(NetworkerPacket(null, event.$1));
  }

  void _onLeave((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    log('${info.address} ($user) left the game', level: LogLevel.info);
  }

  Future<void> save({bool force = false}) async {
    if (!force && autosave) return;
    final bytes = state.save().exportAsBytes();
    await File(defaultWorldFile).writeAsBytes(bytes);
  }

  @override
  Future<void> close() async {
    await super.close();
    log('Closing...', level: LogLevel.info);
    _server?.close();
    consoler.dispose();
  }

  void process(WorldEvent event) {
    _onClientEvent(NetworkerPacket(event, kAuthorityChannel));
  }

  bool kick(int id) {
    final info = _server?.getConnectionInfo(id);
    if (info == null) return false;
    info.close();
    return true;
  }
}
