import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class WorldsProgram extends ConsoleProgram {
  final SetonixServer server;
  WorldsProgram(this.server);
  @override
  String getDescription() => 'List loaded worlds.';
  @override
  void run(String label, List<String> args) {
    if (args.isNotEmpty) throw const CommandUsageException();
    final worlds = server.worldNames.toList()..sort();
    server.log("${worlds.length} loaded world(s).");
    server.consoler.table(
      ["World", "Players", "Game mode"],
      [
        for (final name in worlds)
          [
            name,
            server.getWorld(name)!.players.length,
            server.getWorld(name)!.state.info.gameMode?.toString() ?? 'sandbox',
          ],
      ],
    );
  }
}
