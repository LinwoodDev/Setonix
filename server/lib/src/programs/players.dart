import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class PlayersProgram extends ConsoleProgram {
  final SetonixServer server;

  PlayersProgram(this.server);

  @override
  String getDescription() => "Show all connected players";

  @override
  void run(String label, List<String> args) {
    print("-----");
    final players = server.userManager.getUsers();
    print("${players.length} player(s) connected.");
    for (final player in players) {
      final connectionInfo = server.players[player.key];
      print(
        "${connectionInfo?.address} | #${player.key}) | @${player.value.name} | ${player.value.roles.join(', ')} | *${player.value.fingerprint ?? 'No Fingerprint'}",
      );
    }
    print("-----");
  }
}
