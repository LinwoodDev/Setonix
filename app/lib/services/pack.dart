import 'package:lw_file_system/lw_file_system.dart';
import 'package:quokka/api/storage.dart';
import 'package:quokka/models/definitions/pack.dart';

class PackService {
  final PackData? _corePack;
  final TypedKeyFileSystem<PackData> fileSystem;

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
      _corePack ?? await PackData.getCorePack();

  Future<Map<String, PackData>> getPacks({
    bool fetchExternal = true,
    bool fetchCore = true,
  }) async {
    final corePack = fetchCore ? await fetchCorePack() : null;
    if (fetchExternal) await fileSystem.initialize();
    return {
      if (fetchExternal) ...await fileSystem.getFiles(),
      if (corePack != null) '': corePack,
    };
  }

  Future<PackData?> getPack(String packId) =>
      packId.isEmpty ? fetchCorePack() : fileSystem.getFile(packId);
}
