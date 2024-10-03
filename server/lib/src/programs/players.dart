import 'package:consoler/consoler.dart';
import 'package:quokka_server/src/server.dart';

class PlayersProgram extends ConsoleProgram {
  final QuokkaServer server;

  PlayersProgram(this.server);

  @override
  String getDescription() => "Show all connected players";

  @override
  void run(String label, List<String> args) {
    print("-----");
    final players = server.players;
    print("${players.length} player(s) connected.");
    for (final player in players.entries) {
      print("${player.value.address} (${player.key})");
    }
    print("-----");
  }
}
