import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

/// Compatibility base; Consoler awaits handlers and reports their failures.
abstract class AsyncServerProgram extends ConsoleProgram {
  final SetonixServer server;
  AsyncServerProgram(this.server);
  Future<void> runAsync(String label, List<String> args);
  @override
  Future<void> run(String label, List<String> args) => runAsync(label, args);
}
