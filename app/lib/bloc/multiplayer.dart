import 'dart:async';
import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:quokka/bloc/world_event.dart';

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
final class MultiplayerDisabledState extends MultiplayerState
    with MultiplayerDisabledStateMappable {}

@MappableClass()
final class MultiplayerConnectingState extends MultiplayerState
    with MultiplayerConnectingStateMappable {}

@MappableClass()
final class MultiplayerDisconnectedState extends MultiplayerState
    with MultiplayerDisconnectedStateMappable {
  final Object? error;

  MultiplayerDisconnectedState([this.error]);
}

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

  MultiplayerCubit() : super(MultiplayerDisabledState());

  bool get isConnected => state.isConnected;
  bool get isClient => state.isClient;
  bool get isServer => state.isServer;

  MultiplayerConnectedState _addNetworker(NetworkerBase base) {
    final transformer = NetworkerPipeTransformer<String, BoardEvent>(
      BoardEventMapper.fromJson,
      (e) => e.toJson(),
    );
    base.connect(StringNetworkerPlugin()..connect(transformer));
    transformer.read.listen((event) {
      if (event.data.isMultiplayer) {
        _eventController.add(event.data.copyWith(isRemoteEvent: true));
      }
    });
    if (base is NetworkerServer) {
      base.connect(EchoPipe(toChannel: kAnyChannel));
      base.clientConnect.pipe(_initController);
    }
    return MultiplayerConnectedState(base, transformer);
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

  Future<void> connect(String address) async {
    try {
      final add = address.split(':');
      final client = NetworkerSocketClient(Uri(
        scheme: 'ws',
        host: add[0],
        port: add.length <= 1 ? kDefaultPort : int.parse(add[1]),
      ));
      final state = _addNetworker(client);
      client.webSocketChannel.stream.listen((_) {},
          onDone: () => emit(MultiplayerDisconnectedState()),
          onError: (e) => emit(MultiplayerDisconnectedState(e)),
          cancelOnError: true);
      emit(state);
      await client.webSocketChannel.ready;
      final error = client.webSocketChannel.closeReason;
      if (error != null) {
        emit(MultiplayerDisconnectedState(error));
      }
    } catch (e) {
      emit(MultiplayerDisconnectedState(e));
    }
  }

  Future<void> create() async {
    try {
      final httpServer =
          await HttpServer.bind(InternetAddress.loopbackIPv4, kDefaultPort);
      final server = NetworkerSocketServer(httpServer);
      _addNetworker(server);
      await server.init();
    } catch (e) {
      emit(MultiplayerDisconnectedState(e));
    }
  }

  void send(BoardEvent event, [Channel channel = kAnyChannel]) {
    final state = this.state;
    if (event.isRemoteEvent) return;
    if (state is! MultiplayerConnectedState) return;
    state.transformer.sendMessage(event, channel);
  }
}
