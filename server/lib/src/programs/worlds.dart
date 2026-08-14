import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class WorldsProgram extends ConsoleProgram {
  final SetonixServer server;

  WorldsProgram(this.server);

  @override
  String getDescription() => 'List loaded worlds.';

  @override
  void run(String label, List<String> args) {
    if (args.isNotEmpty) {
      server.log('Wrong usage, use worlds', level: LogLevel.error);
      return;
    }
    final names = server.worldNames.toList(growable: false);
    server.log('${names.length} loaded world(s):', level: LogLevel.info);
    for (final name in names) {
      final world = server.getWorld(name)!;
      final mode = world.state.info.gameMode?.toString() ?? 'sandbox';
      server.log(
        '$name | ${world.players.length} player(s) | $mode',
        level: LogLevel.info,
      );
    }
  }
}
