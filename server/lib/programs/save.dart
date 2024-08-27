import 'package:consoler/consoler.dart';
import 'package:quokka_server/main.dart';

class SaveProgram extends ConsoleProgram {
  final QuokkaServer server;

  SaveProgram(this.server);
  @override
  String getDescription() => "Saves the world manually";

  @override
  Future<void> run(List<String> args) async {
    print('Saving...');
    await server.save(force: true);
    print('Saved.');
  }
}
