import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class PlayersProgram extends ConsoleProgram {
  final SetonixServer server;
  PlayersProgram(this.server);
  @override
  String getDescription() => 'List connected players.';
  @override
  String getUsage() => '[World]';
  @override
  void run(String label, List<String> args) {
    if (args.length > 1) throw const CommandUsageException();
    final world = args.firstOrNull;
    if (world != null && server.getWorld(world) == null) {
      throw CommandFailure("Unknown world: $world");
    }
    final players = server.userManager
        .getUsers()
        .where(
          (player) =>
              world == null || server.getUserWorldName(player.key) == world,
        )
        .toList();
    server.log("${players.length} connected player(s).");
    server.consoler.table(
      ["ID", "Name", "World", "Roles", "Address", "Fingerprint"],
      [
        for (final player in players)
          [
            '#${player.key}',
            '@${player.value.name}',
            server.getUserWorldName(player.key),
            player.value.roles.join(', '),
            server.players[player.key]?.address,
            player.value.fingerprint ?? "guest",
          ],
      ],
    );
  }
}
