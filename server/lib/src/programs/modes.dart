import 'package:consoler/consoler.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/server.dart';

class ModesProgram extends ConsoleProgram {
  final SetonixServer server;

  ModesProgram(this.server);

  @override
  String getDescription() => 'List available game modes.';

  @override
  void run(String label, List<String> args) {
    if (args.isNotEmpty) {
      server.log('Wrong usage, use modes', level: LogLevel.error);
      return;
    }
    final modes = server.assetManager.packs
        .expand(
          (pack) =>
              pack.value.getModes().map((mode) => ItemLocation(pack.key, mode)),
        )
        .toList(growable: false);
    server.log('${modes.length} available game mode(s):', level: LogLevel.info);
    for (final mode in modes) {
      server.log(mode, level: LogLevel.info);
    }
  }
}
