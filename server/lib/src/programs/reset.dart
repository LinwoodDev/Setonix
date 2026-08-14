import 'package:consoler/consoler.dart';
import 'package:setonix_server/setonix_server.dart';
import 'package:setonix_server/src/programs/async.dart';

class ResetProgram extends AsyncServerProgram {
  ResetProgram(super.server);

  @override
  String getDescription() =>
      "Reset the world. Specify a game mode to allow playing games.";

  @override
  String getUsage() => '[<World>] [<Game mode>|sandbox]';

  @override
  Future<void> runAsync(String label, List<String> args) async {
    if (args.length > 2) {
      server.log("Wrong usage, use ${getUsage()}", level: LogLevel.error);
      return;
    }
    final worldName = args.elementAtOrNull(0) ?? defaultWorldName;
    final world = server.getWorld(worldName);
    if (world == null) {
      server.log('Unknown world: $worldName', level: LogLevel.error);
      return;
    }
    final modeName = args.elementAtOrNull(1);
    ItemLocation? mode;
    if (modeName != null && modeName != 'sandbox') {
      mode = ItemLocation.fromString(modeName);
      if (server.assetManager.getModeItem(mode) == null) {
        server.log('Unknown game mode: $modeName', level: LogLevel.error);
        return;
      }
    }
    server.log('Resetting world $worldName...', level: LogLevel.info);
    await world.resetWorld(mode);
    server.log('World $worldName reset successfully.', level: LogLevel.info);
  }
}
