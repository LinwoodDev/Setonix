import 'package:consoler/consoler.dart';
import 'package:setonix_server/setonix_server.dart';

class ScriptsProgram extends ConsoleProgram {
  final SetonixServer server;

  ScriptsProgram(this.server);

  @override
  String getDescription() => "Show all loaded scripts";

  @override
  String getUsage() => "[world]";

  @override
  void run(String label, List<String> args) {
    String world = defaultWorldName;
    if (args.length > 1) return print("Usage: $label [world]");
    if (args.length == 1) world = args[0];
    final loadedWorld = server.getWorld(world);
    if (loadedWorld == null) {
      server.log('Unknown world: $world', level: LogLevel.error);
      return;
    }
    print("-----");
    final scripts = loadedWorld.pluginSystem.plugins.toList();
    print("Loaded ${scripts.length} script(s).");
    for (final script in scripts) {
      print("> $script");
    }
    print("-----");
  }
}
