import 'dart:io';

import 'package:consoler/consoler.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:path/path.dart' as p;
import 'package:setonix_api/setonix_api.dart';

part 'asset.mapper.dart';

@MappableClass()
final class ServerDataMetadata with ServerDataMetadataMappable {
  final List<String> downloadUrls;

  ServerDataMetadata({required this.downloadUrls});
}

class ServerAssetManager extends AssetManager {
  final Map<String, SetonixData> _packs = {};
  final Map<String, String> _packIds = {};
  final Map<String, ServerDataMetadata> _metadata = {};

  static const _stnxExtension = 'stnx';
  static const _metadataExtension = 'json';

  @override
  Iterable<MapEntry<String, SetonixData>> get packs => _packs.entries;

  Future<void> init({
    required Consoler console,
    bool verbose = false,
    String rootPath = '.',
  }) async {
    _packs.clear();
    _packIds.clear();
    _metadata.clear();
    final metadataByName = <String, ServerDataMetadata>{};
    final directory = Directory(p.join(rootPath, 'packs'));
    if (!await directory.exists()) {
      await directory.create();
      console.print(
        'WARNING: No packs directory found. Please add packs to the server.',
        level: LogLevel.warning,
      );
    }
    await for (final file in directory.list()) {
      if (file is File) {
        final fileName = p.basename(file.path);
        final extension = fileName.split('.').last;
        if (extension != _stnxExtension && extension != _metadataExtension) {
          console.print(
            'WARNING: Invalid pack file extension: $fileName. Skipping.',
            level: LogLevel.warning,
          );
          continue;
        }
        var name = fileName.substring(
          0,
          fileName.length - _stnxExtension.length - 1,
        );
        if (name.isEmpty) name = kCorePackId;
        if (extension == _stnxExtension) {
          final data = SetonixData.fromData(await file.readAsBytes());
          final id = name == kCorePackId ? kCorePackId : data.identifier;
          _packs[id] = data;
          _packIds[name] = id;
        } else {
          final metadata = ServerDataMetadataMapper.fromJson(
            await file.readAsString(),
          );
          metadataByName[name] = metadata;
        }
      }
    }
    for (final entry in metadataByName.entries) {
      _metadata[getPackIdOrDefault(entry.key)] = entry.value;
    }
    final coreIncluded = _packs.containsKey(kCorePackId);
    console.print(
      'Loaded ${_packs.length} pack(s). ${coreIncluded ? '(with core pack)' : '(without core pack)'}',
      level: LogLevel.info,
    );
    if (_packs.isEmpty) {
      console.print('No packs loaded.', level: LogLevel.warning);
    } else {
      console.print(
        'Loaded pack(s): ${_packs.keys.join(', ')}',
        level: LogLevel.verbose,
      );
    }
  }

  @override
  SetonixData? getPack(String key) => _packs[key];

  @override
  bool hasPack(String key) => _packs.containsKey(key);

  @override
  List<String>? getDownloadUrls(String id) => _metadata[id]?.downloadUrls;

  Iterable<String> getPackIds() => _packs.keys;

  String? getPackId(String name) => _packIds[name];

  String getPackIdOrDefault(String name) => getPackId(name) ?? name;
}
