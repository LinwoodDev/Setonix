import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class PlayersProgram extends ConsoleProgram {
  final SetonixServer server;

  PlayersProgram(this.server);

  @override
  String getDescription() => "Show all connected players";

  @override
  String getUsage() => '[<World>]';

  @override
  void run(String label, List<String> args) {
    if (args.length > 1) {
      server.log('Wrong usage, use ${getUsage()}', level: LogLevel.error);
      return;
    }
    final worldName = args.firstOrNull;
    if (worldName != null && server.getWorld(worldName) == null) {
      server.log('Unknown world: $worldName', level: LogLevel.error);
      return;
    }
    print("-----");
    final players = server.userManager.getUsers().where(
      (player) =>
          worldName == null || server.getUserWorldName(player.key) == worldName,
    );
    print("${players.length} player(s) connected.");
    for (final player in players) {
      final connectionInfo = server.players[player.key];
      print(
        "${connectionInfo?.address} | #${player.key} | @${player.value.name} | ${player.value.roles.join(', ')} | *${player.value.fingerprint ?? 'No Fingerprint'}",
      );
    }
    print("-----");
  }
}
