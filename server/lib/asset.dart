import 'dart:io';

import 'package:consoler/consoler.dart';
import 'package:path/path.dart' as p;
import 'package:quokka_api/quokka_api.dart';

class ServerAssetManager extends AssetManager {
  final Map<String, QuokkaData> _packs = {};
  static const _qkaExtension = 'qka';
  @override
  Iterable<MapEntry<String, QuokkaData>> get packs => _packs.entries;

  Future<void> init({required Consoler console, bool verbose = false}) async {
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
        final fileName = p.basename(file.path);
        final extension = fileName.split('.').last;
        if (extension != _qkaExtension) {
          console.print(
              'WARNING: Invalid pack file extension: $fileName. Skipping.',
              level: LogLevel.warning);
          continue;
        }
        var name =
            fileName.substring(0, fileName.length - _qkaExtension.length - 1);
        if (name.isEmpty) name = kCorePackId;
        _packs[name] = data;
      }
    }
    final coreIncluded = _packs.containsKey(kCorePackId);
    console.print(
        'Loaded ${_packs.length} pack(s). ${coreIncluded ? '(with core pack)' : '(without core pack)'}',
        level: LogLevel.info);
    if (_packs.isEmpty) {
      console.print('No packs loaded.', level: LogLevel.warning);
    } else {
      console.print('Loaded pack(s): ${_packs.keys.join(', ')}',
          level: LogLevel.verbose);
    }
  }

  @override
  QuokkaData? getPack(String key) => _packs[key];

  @override
  bool hasPack(String key) => _packs.containsKey(key);
}
