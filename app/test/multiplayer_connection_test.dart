import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix_api/setonix_api.dart';

class _Network extends Fake implements NetworkService {
  Future<GameProperty> Function(Uri) fetch;

  _Network(this.fetch);

  @override
  Future<GameProperty> fetchRequiredInfo(Uri address) => fetch(address);

  @override
  void cancelServerInfo() {}
}

void main() {
  final address = Uri.parse('ws://localhost:28006/');

  test('retries the original address after a failed info request', () async {
    var attempts = 0;
    final failure = StateError('Server unavailable');
    final network = _Network((uri) async {
      expect(uri, address);
      attempts++;
      throw failure;
    });
    final cubit = MultiplayerCubit(network);
    addTearDown(cubit.close);
    await cubit.connectSocket(address);
    expect((cubit.state as MultiplayerDisconnectedState).error, failure);
    await cubit.reconnect();
    expect(attempts, 2);
    expect((cubit.state as MultiplayerDisconnectedState).error, failure);
  });

  test('times out server discovery and ignores its late result', () async {
    final pending = Completer<GameProperty>();
    final cubit = MultiplayerCubit(
      _Network((_) => pending.future),
      connectionTimeout: const Duration(milliseconds: 20),
    );
    addTearDown(cubit.close);
    await cubit.connectSocket(address);
    expect(
      (cubit.state as MultiplayerDisconnectedState).error,
      isA<TimeoutException>(),
    );
    final disconnected = cubit.state;
    pending.complete(const GameProperty(protocolVersions: [1]));
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state, same(disconnected));
  });

  test('closing during discovery cannot start a late connection', () async {
    final pending = Completer<GameProperty>();
    final started = Completer<void>();
    final cubit = MultiplayerCubit(
      _Network((_) {
        started.complete();
        return pending.future;
      }),
    );
    final connecting = cubit.connectSocket(address);
    await started.future;
    await cubit.close();
    pending.complete(const GameProperty(protocolVersions: [1]));
    await connecting;
    expect(cubit.isClosed, isTrue);
  });

  test(
    'reconnects with a fresh socket and negotiates the protocol again',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final sockets = <WebSocket>[];
      final requests = <Uri>[];
      final subscription = server.listen((request) async {
        requests.add(request.uri);
        final socket = await WebSocketTransformer.upgrade(request);
        sockets.add(socket);
        socket.add(WorldInitialized(info: const GameInfo()).toJson());
      });
      var discoveries = 0;
      final cubit = MultiplayerCubit(
        _Network((_) async {
          discoveries++;
          return const GameProperty(protocolVersions: [1]);
        }),
      );
      addTearDown(() async {
        await cubit.close();
        for (final socket in sockets) {
          await socket.close();
        }
        await server.close(force: true);
        await subscription.cancel();
      });
      final uri = Uri.parse('ws://127.0.0.1:${server.port}/game?world=main');
      final initialized = cubit.events.firstWhere((e) => e is WorldInitialized);
      await cubit.connectSocket(uri);
      expect(cubit.state, isA<MultiplayerConnectedState>());
      await initialized;
      final first = (cubit.state as MultiplayerConnectedState).networker;
      final disconnected = cubit.stream.firstWhere(
        (state) => state is MultiplayerDisconnectedState,
      );
      await sockets.single.close(WebSocketStatus.goingAway);
      await disconnected;
      await cubit.reconnect();
      expect(cubit.state, isA<MultiplayerConnectedState>());
      expect(
        (cubit.state as MultiplayerConnectedState).networker,
        isNot(same(first)),
      );
      expect(discoveries, 2);
      expect(sockets, hasLength(2));
      for (final request in requests) {
        expect(request.path, '/game');
        expect(request.queryParameters['world'], 'main');
        expect(readSetonixProtocolVersion(request), 1);
      }
    },
  );
}
