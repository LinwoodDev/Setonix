import 'package:lw_file_system/lw_file_system.dart';
import 'package:quokka/api/storage.dart';
import 'package:quokka/models/data.dart';

class QuokkaFileSystem {
  QuokkaData? _corePack;
  final TypedKeyFileSystem<QuokkaData> packSystem, templateSystem, worldSystem;

  static _onDatabaseUpgrade(event) =>
      initStores(event, ['packs', 'templates', 'worlds']);

  QuokkaFileSystem({
    QuokkaData? corePack,
  })  : _corePack = corePack,
        packSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'packs',
            getDirectory: (storage) async =>
                '${await getQuokkaDirectory()}/Packs',
            database: 'quokka.db',
            databaseVersion: 1,
            keySuffix: '.qka',
            onDatabaseUpgrade: _onDatabaseUpgrade,
          ),
          onDecode: QuokkaData.fromData,
          onEncode: (data) => data.exportAsBytes(),
        ),
        templateSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'templates',
            getDirectory: (storage) async =>
                '${await getQuokkaDirectory()}/Templates',
            database: 'quokka.db',
            databaseVersion: 1,
            keySuffix: '.qka',
            onDatabaseUpgrade: _onDatabaseUpgrade,
          ),
          onDecode: QuokkaData.fromData,
          onEncode: (data) => data.exportAsBytes(),
        ),
        worldSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'worlds',
            getDirectory: (storage) async =>
                '${await getQuokkaDirectory()}/Worlds',
            database: 'quokka.db',
            databaseVersion: 1,
            keySuffix: '.qka',
            onDatabaseUpgrade: _onDatabaseUpgrade,
          ),
          onDecode: QuokkaData.fromData,
          onEncode: (data) => data.exportAsBytes(),
        );

  Future<QuokkaData?> fetchCorePack() async =>
      _corePack ?? (_corePack = await QuokkaData.getCorePack());

  Future<Map<String, QuokkaData>> getPacks({
    bool fetchCore = true,
    bool force = false,
  }) async {
    final corePack = fetchCore ? await fetchCorePack() : null;
    await packSystem.initialize();
    return {
      ...await packSystem.getFiles(),
      if (corePack != null) '': corePack,
    };
  }

  Future<QuokkaData?> getPack(String packId) =>
      packId.isEmpty ? fetchCorePack() : packSystem.getFile(packId);
}
