import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/server.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka_server/asset.dart';

final class QuokkaServer extends Bloc<ServerWorldEvent, WorldState> {
  final ServerAssetManager assetManager;
  bool _verbose = false;
  GameTable _table = const GameTable();

  NetworkerSocketServer? _server;
  NetworkerPipe<dynamic, WorldEvent>? _pipe;

  QuokkaServer()
      : assetManager = ServerAssetManager(),
        super(WorldState(data: QuokkaData.empty())) {
    on<ServerWorldEvent>((event, emit) {
      final newState = processServerEvent(event, state);
      if (newState == null) return null;
      emit(newState);
    });
  }

  Future<void> init({int port = kDefaultPort, bool verbose = false}) async {
    await assetManager.init(verbose: verbose);
    _verbose = verbose;
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
  }

  Future<void> run() async {
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

  void _onJoin(Channel user) {
    final info = _server?.getConnectionInfo(user);
    if (info == null) return;
    print('${info.address} ($user) joined the game');
    _pipe?.sendMessage(
        WorldInitialized(
          table: state.table,
          id: state.id,
          teamMembers: state.teamMembers,
        ),
        user);
  }

  void _onLeave(Channel user) {
    final info = _server?.getConnectionInfo(user);
    print('${info?.address} ($user) left the game');
  }
}
