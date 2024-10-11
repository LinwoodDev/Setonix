import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class StopProgram extends ConsoleProgram {
  final SetonixServer server;

  StopProgram(this.server);
  @override
  String getDescription() => "Stops the server";

  @override
  void run(String label, List<String> args) {
    server.close();
  }
}
