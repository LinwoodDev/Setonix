import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/server.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka_server/asset.dart';
import 'package:quokka_server/console.dart';
import 'package:quokka_server/programs/help.dart';
import 'package:quokka_server/programs/packs.dart';
import 'package:quokka_server/programs/save.dart';
import 'package:quokka_server/programs/stop.dart';
import 'package:quokka_server/programs/unknown.dart';

final class QuokkaServer extends Bloc<ServerWorldEvent, WorldState> {
  final ConsoleManager consoleManager = ConsoleManager();
  final ServerAssetManager assetManager;
  final String? worldFile;
  bool _temp = false;

  NetworkerSocketServer? _server;
  NetworkerPipe<dynamic, WorldEvent>? _pipe;

  QuokkaServer._(this.worldFile, QuokkaData data)
      : assetManager = ServerAssetManager(),
        super(WorldState(
          data: data,
          table: data.getTableOrDefault(),
          metadata: data.getMetadataOrDefault(),
        )) {
    on<ServerWorldEvent>((event, emit) {
      final newState = processServerEvent(event, state);
      if (newState == null) return null;
      emit(newState);
      return save();
    });
  }

  QuokkaServer.empty() : this._(null, QuokkaData.empty());

  static Future<QuokkaServer> load({String? worldFile}) async {
    worldFile ??= defaultWorldFile;
    final file = File(worldFile);
    QuokkaData? data;
    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      data = QuokkaData.fromData(bytes);
    }
    data ??= QuokkaData.empty();
    return QuokkaServer._(worldFile, data);
  }

  void log(Object? message, {LogLevel? level}) =>
      consoleManager.print(message, level: level);

  static String get defaultWorldFile => 'world.qka';

  Future<void> init(
      {int port = kDefaultPort,
      bool verbose = false,
      bool autosave = false}) async {
    await _runLogZone(() async {
      await assetManager.init(console: consoleManager, verbose: verbose);
    });
    if (verbose) {
      consoleManager.minLogLevel = LogLevel.verbose;
    }
    _temp = autosave;
    final server =
        _server = NetworkerSocketServer(InternetAddress.anyIPv4, port);
    final transformer = _pipe = NetworkerPipeTransformer<String, WorldEvent>(
        WorldEventMapper.fromJson, (e) => e.toJson());
    transformer.read.listen(_onClientEvent);
    server
      ..clientConnect.listen(_onJoin)
      ..clientDisconnect.listen(_onLeave)
      ..connect(StringNetworkerPlugin()..connect(transformer));
    await _server?.init();

    consoleManager.registerProgram('stop', StopProgram(this));
    consoleManager.registerProgram('help', HelpProgram(consoleManager));
    consoleManager.registerProgram('save', SaveProgram(this));
    consoleManager.registerProgram('packs', PacksProgram(this));
    consoleManager.registerProgram(null, UnknownProgram());
  }

  R _runLogZone<R>(R Function() body) =>
      runZoned(body, zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, message) {
          log(message);
        },
      ));

  Future<void> run() async {
    _runLogZone(() {
      consoleManager.run();
    });
    log('Server running on ${_server?.address}', level: LogLevel.info);
    log('Verbose logging activated', level: LogLevel.verbose);
    await _server?.onClosed.first;
  }

  void _onClientEvent(NetworkerPacket<WorldEvent> event) {
    final data = event.data;
    final process = processClientEvent(
      data,
      event.channel,
      state,
      assetManager: assetManager,
    );
    if (process == null) return;
    log('Processing event by ${event.channel}: $process',
        level: LogLevel.verbose);
    _pipe?.sendMessage(process.$1, process.$2);
    if (process.$2 == kAnyChannel || process.$2 == kAuthorityChannel) {
      add(process.$1);
    }
  }

  void _onJoin((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    log('${info.address} ($user) joined the game', level: LogLevel.info);
    _pipe?.sendMessage(
        WorldInitialized(
          table: state.table,
          id: state.id,
          teamMembers: state.teamMembers,
        ),
        user);
  }

  void _onLeave((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    log('${info.address} ($user) left the game', level: LogLevel.info);
  }

  Future<void> save({bool force = false}) async {
    if (!force && _temp) return;
    final bytes = state.save().exportAsBytes();
    await File(defaultWorldFile).writeAsBytes(bytes);
  }

  @override
  Future<void> close() async {
    await super.close();
    log('Closing...', level: LogLevel.info);
    _server?.close();
    consoleManager.dispose();
  }
}
