import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class SaveProgram extends ConsoleProgram {
  final SetonixServer server;

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
