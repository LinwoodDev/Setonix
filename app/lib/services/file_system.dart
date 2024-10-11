import 'package:lw_file_system/lw_file_system.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/api/storage.dart';
import 'package:setonix_api/setonix_api.dart';

class SetonixFileSystem {
  SetonixData? _corePack;
  final TypedKeyFileSystem<SetonixData> packSystem, templateSystem, worldSystem;

  static _onDatabaseUpgrade(event) =>
      initStores(event, ['packs', 'templates', 'worlds']);

  SetonixFileSystem({
    SetonixData? corePack,
  })  : _corePack = corePack,
        packSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'packs',
            getDirectory: (storage) async =>
                '${await getSetonixDirectory()}/Packs',
            database: 'setonix.db',
            databaseVersion: 1,
            keySuffix: '.qka',
            onDatabaseUpgrade: _onDatabaseUpgrade,
          ),
          onDecode: SetonixData.fromData,
          onEncode: (data) => data.exportAsBytes(),
        ),
        templateSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'templates',
            getDirectory: (storage) async =>
                '${await getSetonixDirectory()}/Templates',
            database: 'setonix.db',
            databaseVersion: 1,
            keySuffix: '.qka',
            onDatabaseUpgrade: _onDatabaseUpgrade,
          ),
          onDecode: SetonixData.fromData,
          onEncode: (data) => data.exportAsBytes(),
        ),
        worldSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'worlds',
            getDirectory: (storage) async =>
                '${await getSetonixDirectory()}/Worlds',
            database: 'setonix.db',
            databaseVersion: 1,
            keySuffix: '.qka',
            onDatabaseUpgrade: _onDatabaseUpgrade,
          ),
          onDecode: SetonixData.fromData,
          onEncode: (data) => data.exportAsBytes(),
        );

  Future<SetonixData?> fetchCorePack() async =>
      _corePack ?? (_corePack = await getCorePack());

  Future<List<FileSystemFile<SetonixData>>> getPacks({
    bool fetchCore = true,
    bool force = false,
  }) async {
    final corePack = fetchCore ? await fetchCorePack() : null;
    await packSystem.initialize();
    return [
      ...await packSystem.getFiles(),
      if (corePack != null)
        FileSystemFile(const AssetLocation(path: kCorePackId), data: corePack),
    ];
  }

  Future<SetonixData?> getPack(String packId) =>
      packId == kCorePackId ? fetchCorePack() : packSystem.getFile(packId);
}
