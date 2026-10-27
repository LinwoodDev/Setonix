import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class StopProgram extends ConsoleProgram {
  final SetonixServer server;
  StopProgram(this.server);
  @override
  String getDescription() => 'Save and stop the server.';
  @override
  Future<void> run(String label, List<String> args) async {
    if (args.isNotEmpty) throw const CommandUsageException();
    await server.close();
  }
}
