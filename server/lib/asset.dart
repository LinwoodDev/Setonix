import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka_server/console.dart';

class ServerAssetManager extends AssetManager {
  final Map<String, QuokkaData> _packs = {};

  Future<void> init(
      {required ConsoleManager console, bool verbose = false}) async {
    _packs.clear();
    final directory = Directory('packs');
    if (!await directory.exists()) {
      await directory.create();
      print(
          'WARNING: No packs directory found. Please add packs to the server.');
    }
    await for (final file in directory.list()) {
      if (file is File) {
        final data = QuokkaData.fromData(await file.readAsBytes());
        final fileName = p.basenameWithoutExtension(file.path);
        _packs[fileName] = data;
      }
    }
    console.print('Loaded ${_packs.length} packs.', level: LogLevel.info);
    if (_packs.isEmpty) {
      console.print('No packs loaded.', level: LogLevel.warning);
    }
    if (verbose) {
      print('Loaded packs: ${_packs.keys.join(', ')}');
    }
  }

  @override
  QuokkaData? getPack(String key) => _packs[key];
}
