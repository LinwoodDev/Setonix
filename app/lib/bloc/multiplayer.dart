import 'dart:async';
import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:quokka/bloc/board_event.dart';

part 'multiplayer.mapper.dart';

const kDefaultPort = 28006;

@MappableClass()
sealed class MultiplayerState with MultiplayerStateMappable {
  const MultiplayerState();

  bool get isConnected => this is MultiplayerConnectedState;
  bool get isClient => false;
  bool get isServer => false;
}

@MappableClass()
final class MultiplayerDisconnectedState extends MultiplayerState
    with MultiplayerDisconnectedStateMappable {}

@MappableClass()
final class MultiplayerConnectedState extends MultiplayerState
    with MultiplayerConnectedStateMappable {
  final NetworkerBase networker;
  final NetworkerPipeTransformer<String, BoardEvent> transformer;

  MultiplayerConnectedState(this.networker, this.transformer);

  @override
  bool get isClient => networker is NetworkerClient;
  @override
  bool get isServer => networker is NetworkerServer;
}

class MultiplayerCubit extends Cubit<MultiplayerState> {
  final StreamController<BoardEvent> _eventController =
      StreamController.broadcast();

  Stream<BoardEvent> get events => _eventController.stream;

  final StreamController<int> _initController = StreamController.broadcast();

  Stream<int> get inits => _initController.stream;

  MultiplayerCubit() : super(MultiplayerDisconnectedState());

  bool get isConnected => state.isConnected;
  bool get isClient => state.isClient;
  bool get isServer => state.isServer;

  void _addNetworker(NetworkerBase base) {
    final transformer = NetworkerPipeTransformer<String, BoardEvent>(
      BoardEventMapper.fromJson,
      (e) => e.toJson(),
    );
    base.connect(StringNetworkerPlugin()..connect(transformer));
    emit(MultiplayerConnectedState(base, transformer));
    transformer.read.listen((event) {
      if (event.data.isMultiplayer) {
        _eventController.add(event.data.copyWith(isRemoteEvent: true));
      }
    });
    if (base is NetworkerServer) {
      base.connect(EchoPipe(toChannel: kAnyChannel));
      base.clientConnect.pipe(_initController);
    }
  }

  @override
  Future<void> close() {
    disconnect(false);
    return super.close();
  }

  void disconnect([bool emit = true]) {
    final state = this.state;
    if (state is! MultiplayerConnectedState) return;
    state.networker.close();
    if (emit) this.emit(MultiplayerDisconnectedState());
  }

  void connect(String address) async {
    final add = address.split(':');
    final client = NetworkerSocketClient(Uri(
      scheme: 'ws',
      host: add[0],
      port: add.length <= 1 ? kDefaultPort : int.parse(add[1]),
    ));
    _addNetworker(client);
    client.init();
  }

  Future<void> create() async {
    final httpServer =
        await HttpServer.bind(InternetAddress.loopbackIPv4, kDefaultPort);
    final server = NetworkerSocketServer(httpServer);
    _addNetworker(server);
    server.init();
  }

  void send(BoardEvent event, [Channel channel = kAnyChannel]) {
    final state = this.state;
    if (event.isRemoteEvent) return;
    if (state is! MultiplayerConnectedState) return;
    state.transformer.sendMessage(event, channel);
  }
}
