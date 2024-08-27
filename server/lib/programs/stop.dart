import 'package:consoler/consoler.dart';
import 'package:quokka_server/main.dart';

class StopProgram extends ConsoleProgram {
  final QuokkaServer server;

  StopProgram(this.server);
  @override
  String getDescription() => "Stops the server";

  @override
  void run(String label, List<String> args) {
    server.close();
  }
}
