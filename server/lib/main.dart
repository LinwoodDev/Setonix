import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/server.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka_server/asset.dart';
import 'package:quokka_server/console.dart';
import 'package:quokka_server/programs/help.dart';
import 'package:quokka_server/programs/stop.dart';
import 'package:quokka_server/programs/unknown.dart';

final class QuokkaServer extends Bloc<ServerWorldEvent, WorldState> {
  final ConsoleManager consoleManager = ConsoleManager();
  final ServerAssetManager assetManager;
  final String? worldFile;
  bool _verbose = false;
  bool _temp = false;
  GameTable _table = const GameTable();

  NetworkerSocketServer? _server;
  NetworkerPipe<dynamic, WorldEvent>? _pipe;

  QuokkaServer._(this.worldFile, QuokkaData data)
      : assetManager = ServerAssetManager(),
        super(WorldState(data: data, table: data.getTableOrDefault())) {
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

  static String get defaultWorldFile => 'world.qka';

  Future<void> init(
      {int port = kDefaultPort,
      bool verbose = false,
      bool autosave = false}) async {
    await assetManager.init(verbose: verbose);
    _verbose = verbose;
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
    _table = const GameTable();
    await _server?.init();

    consoleManager.registerProgram('stop', StopProgram(this));
    consoleManager.registerProgram('help', HelpProgram(consoleManager));
    consoleManager.registerProgram(null, UnknownProgram());
  }

  Future<void> run() async {
    consoleManager.run();
    print('Server running on ${_server?.address}');
    if (_verbose) {
      print('Verbose logging activated');
    }
    await _server?.onClosed.first;
  }

  void _onClientEvent(NetworkerPacket<WorldEvent> event) {
    final data = event.data;
    final process = processClientEvent(
      data,
      event.channel,
      assetManager: assetManager,
      table: _table,
    );
    if (process == null) return;
    if (_verbose) {
      print('Processing event by ${event.channel}: $process');
    }
    _pipe?.sendMessage(process.$1, process.$2);
    if (process.$2 == kAnyChannel || process.$2 == kAuthorityChannel) {
      add(process.$1);
    }
  }

  void _onJoin((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    print('${info.address} ($user) joined the game');
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
    print('${info.address} ($user) left the game');
  }

  Future<void> save() async {
    if (_temp) return;
    final bytes = state.save().exportAsBytes();
    await File(defaultWorldFile).writeAsBytes(bytes);
  }

  @override
  Future<void> close() async {
    await super.close();
    print('Closing...');
    _server?.close();
  }
}
