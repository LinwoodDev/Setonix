import 'package:collection/collection.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:quokka/api/storage.dart';
import 'package:quokka/models/definitions/object.dart';
import 'package:quokka/models/definitions/pack.dart';

class PackService {
  PackData? _corePack;
  final TypedKeyFileSystem<PackData> fileSystem;
  final Map<String, PackData> _loadedPacks = {};

  PackService({
    PackData? corePack,
  })  : _corePack = corePack,
        fileSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'packs',
            getDirectory: (storage) async =>
                '${await getQuokkaDirectory()}/Packs',
            database: 'quokka.db',
            databaseVersion: 1,
            keySuffix: '.qka',
          ),
          onDecode: PackData.fromData,
          onEncode: (data) => data.export(),
        );

  Future<PackData?> fetchCorePack() async =>
      _corePack ?? (_corePack = await PackData.getCorePack());

  Future<void> reloadPacks() async {
    _loadedPacks.clear();
    _loadedPacks.addAll(await getPacks());
  }

  Future<Map<String, PackData>> getPacks({
    bool fetchCore = true,
    bool force = false,
  }) async {
    final corePack = fetchCore ? await fetchCorePack() : null;
    if (!force && _loadedPacks.isNotEmpty) {
      return {
        ..._loadedPacks,
        if (corePack != null) '': corePack,
      };
    }
    await fileSystem.initialize();
    return {
      ...await fileSystem.getFiles(),
      if (corePack != null) '': corePack,
    };
  }

  Future<PackData?> getPack(String packId) =>
      packId.isEmpty ? fetchCorePack() : fileSystem.getFile(packId);

  Set<String> get loadedPacks => _loadedPacks.keys.toSet();

  Future<PackData?> loadPack(String packId, {bool force = false}) async {
    if (_loadedPacks.containsKey(packId) && !force) {
      return _loadedPacks[packId];
    }
    final pack = await getPack(packId);
    if (pack != null) {
      _loadedPacks[packId] = pack;
    }
    return pack;
  }

  Future<void> removePack(String packId) async {
    await fileSystem.deleteFile(packId);
    _loadedPacks.remove(packId);
  }

  Future<List<PackItem<FigureDefinition>>> getFigures({
    Set<String> filter = const {},
    Map<String, PackData>? packs,
  }) async {
    final allPacks = (packs ?? await getPacks())
        .entries
        .where((e) => filter.isEmpty || filter.contains(e.key));
    return allPacks
        .expand((e) => e.value.getFigures().map((f) {
              final item = e.value.getFigure(f);
              if (item == null) return null;
              return PackItem(
                pack: e.value,
                id: f,
                namespace: e.key,
                item: item,
              );
            }).whereNotNull())
        .toList();
  }
}
