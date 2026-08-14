import 'dart:async';

import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

abstract class AsyncServerProgram extends ConsoleProgram {
  final SetonixServer server;

  AsyncServerProgram(this.server);

  Future<void> runAsync(String label, List<String> args);

  @override
  void run(String label, List<String> args) {
    unawaited(
      runAsync(label, args).catchError((Object error, StackTrace stackTrace) {
        server.log('Command $label failed: $error', level: LogLevel.error);
      }),
    );
  }
}
