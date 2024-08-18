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
  final NetworkerPipeTransformer<String, WorldEvent> transformer;

  MultiplayerConnectedState(this.networker, this.transformer);

  @override
  bool get isClient => networker is NetworkerClient;
  @override
  bool get isServer => networker is NetworkerServer;
}

class MultiplayerCubit extends Cubit<MultiplayerState> {
  final StreamController<WorldEvent> _eventController =
      StreamController.broadcast();

  Stream<WorldEvent> get events => _eventController.stream;

  final StreamController<int> _initController = StreamController.broadcast();

  Stream<int> get inits => _initController.stream;

  MultiplayerCubit() : super(MultiplayerDisabledState());

  bool get isConnected => state.isConnected;
  bool get isClient => state.isClient;
  bool get isServer => state.isServer;

  Future<MultiplayerConnectedState> _addNetworker(NetworkerBase base) async {
    final transformer = NetworkerPipeTransformer<String, WorldEvent>(
      WorldEventMapper.fromJson,
      (e) => e.toJson(),
    );
    base.connect(StringNetworkerPlugin()..connect(transformer));
    transformer.read.listen((event) {
      if (event.data is WorldMultiplayerEvent) {
        _eventController.add(event.data);
      }
    });
    if (base is NetworkerServer) {
      base.connect(RawJsonNetworkerPlugin()
        ..connect(AdvancedNetworkerPipeTransformer<dynamic, WorldEvent>(
            (data, channel) => (WorldEventMapper.fromJson(data), channel),
            (data, channel) {
          if (data is UserBasedEvent) {
            data = data.copyWith(user: channel);
          }
          return (data.toJson(), channel);
        })
          ..connect(EchoPipe(toChannel: kAnyChannel))));
      base.clientConnect.listen(_initController.add);
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
    if (emit) {
      if (state.isClient) {
        this.emit(MultiplayerDisconnectedState());
      } else {
        this.emit(MultiplayerDisabledState());
      }
    }
  }

  Future<void> connect(String address) async {
    try {
      emit(MultiplayerConnectingState());
      final add = address.split(':');
      final client = NetworkerSocketClient(Uri(
        scheme: 'ws',
        host: add[0],
        port: add.length <= 1 ? kDefaultPort : int.parse(add[1]),
      ));
      final state = await _addNetworker(client);
      client.onClosed.listen((_) => emit(MultiplayerDisconnectedState()),
          onError: (e) => emit(MultiplayerDisconnectedState(e)));
      await client.init();
      emit(state);
    } catch (e) {
      emit(MultiplayerDisconnectedState(e));
    }
  }

  Future<void> create() async {
    try {
      final server =
          NetworkerSocketServer(InternetAddress.loopbackIPv4, kDefaultPort);
      final state = await _addNetworker(server);
      await server.init();
      emit(state);
    } catch (e) {
      emit(MultiplayerDisconnectedState(e));
    }
  }

  void send(WorldMultiplayerEvent event, [Channel channel = kAnyChannel]) {
    final state = this.state;
    if (state is! MultiplayerConnectedState) return;
    state.transformer.sendMessage(event, channel);
  }
}
