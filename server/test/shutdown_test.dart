import 'dart:async';
import 'dart:io';

import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/server.dart';
import 'package:test/test.dart';

void main() {
  test(
    'closing with a connected client does not emit into closed worlds',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'setonix-shutdown-',
      );
      final server = await SetonixServer.load(
        rootPath: directory.path,
        argsConfig: const SetonixConfig(
          host: '127.0.0.1',
          port: 0,
          accountRequired: false,
        ),
      );
      addTearDown(() async {
        await server.close();
        await directory.delete(recursive: true);
      });
      await server.init();
      expect(
        server.consoler.programs.map((entry) => entry.key),
        containsAll(<String>['bans', 'worlds', 'modes']),
      );
      final address = server.address!;
      final socket = await WebSocket.connect(
        addSetonixProtocolVersion(
          Uri(scheme: 'ws', host: address.host, port: address.port),
        ).toString(),
      );
      final disconnected = Completer<void>();
      socket.listen(
        (_) {},
        onDone: disconnected.complete,
        onError: disconnected.completeError,
      );

      await server.close().timeout(const Duration(seconds: 5));
      await disconnected.future.timeout(const Duration(seconds: 5));

      expect(server.isClosing, isTrue);
    },
  );
}
