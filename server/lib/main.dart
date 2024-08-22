import 'dart:io';

import 'package:networker/networker.dart';
import 'package:networker_socket/server.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka_server/asset.dart';

final class QuokkaServer {
  final ServerAssetManager assetManager;
  bool _verbose = false;
  GameTable _table = const GameTable();

  NetworkerSocketServer? _server;
  NetworkerPipe<dynamic, WorldEvent>? _pipe;

  QuokkaServer() : assetManager = ServerAssetManager();

  Future<void> init({int port = kDefaultPort, bool verbose = false}) async {
    await assetManager.init(verbose: verbose);
    _verbose = verbose;
    final server =
        _server = NetworkerSocketServer(InternetAddress.anyIPv4, port);
    final transformer = _pipe = NetworkerPipeTransformer<String, WorldEvent>(
        WorldEventMapper.fromJson, (e) => e.toJson());
    transformer.read.listen(_onClientEvent);
    server.connect(StringNetworkerPlugin()..connect(transformer));
    _table = const GameTable();
    await _server?.init();
  }

  Future<void> run() async {
    print('Server running on ${_server?.address}');
    await _server?.onClosed.first;
  }

  void _onClientEvent(NetworkerPacket<WorldEvent> event) {
    final data = event.data;
    final process = processEvent(
      data,
      event.channel,
      assetManager: assetManager,
      table: _table,
    );
    if (process == null) return;
    if (_verbose) {
      print('Processing event: $process');
    }
    _pipe?.sendMessage(process.$1, process.$2);
  }
}
