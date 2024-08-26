import 'package:quokka_server/console.dart';
import 'package:quokka_server/main.dart';

class PacksProgram extends ConsoleProgram {
  final QuokkaServer server;

  PacksProgram(this.server);

  @override
  String getDescription() => "Show all loaded packs";

  @override
  void run(List<String> args) {
    print("-----");
    final packs = server.assetManager.packs.toList();
    print("Loaded ${packs.length} packs.");
    for (final pack in packs) {
      final checksum = pack.value.getChecksum();
      if (pack.key.isEmpty) {
        print("| Core pack ($checksum)");
      }
      print("> ${pack.key} ($checksum)");
    }
    print("-----");
  }
}
