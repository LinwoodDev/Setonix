import 'dart:async';

import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class StopProgram extends ConsoleProgram {
  final SetonixServer server;

  StopProgram(this.server);
  @override
  String getDescription() => "Stops the server";

  @override
  void run(String label, List<String> args) {
    if (args.isNotEmpty) {
      server.log('Wrong usage, use stop', level: LogLevel.error);
      return;
    }
    unawaited(
      server.close().catchError((Object error, StackTrace stackTrace) {
        server.log('Failed to stop server: $error', level: LogLevel.error);
      }),
    );
  }
}
