import 'package:consoler/consoler.dart';
import 'package:quokka_server/server.dart';

class SaveProgram extends ConsoleProgram {
  final QuokkaServer server;

  SaveProgram(this.server);
  @override
  String getDescription() => "Saves the world manually";

  @override
  Future<void> run(String label, List<String> args) async {
    server.consoler.print('Saving...', level: LogLevel.info);
    await server.save(force: true);
    server.consoler.print('Saved.', level: LogLevel.info);
  }
}
