import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/programs/async.dart';

class SaveProgram extends AsyncServerProgram {
  SaveProgram(super.server);
  @override
  String getDescription() => "Saves the world manually";

  @override
  String getUsage() => '[<World>]';

  @override
  Future<void> runAsync(String label, List<String> args) async {
    if (args.length > 1) {
      server.log('Wrong usage, use ${getUsage()}', level: LogLevel.error);
      return;
    }
    final worldName = args.firstOrNull;
    final world = worldName == null ? null : server.getWorld(worldName);
    if (worldName != null && world == null) {
      server.log('Unknown world: $worldName', level: LogLevel.error);
      return;
    }
    server.consoler.print('Saving...', level: LogLevel.info);
    if (world == null) {
      await server.saveAll(force: true);
    } else {
      await world.save(force: true);
    }
    server.consoler.print('Saved.', level: LogLevel.info);
  }
}
