import 'package:collection/collection.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:quokka/api/storage.dart';
import 'package:quokka/models/definitions/pack.dart';

class PacksService {
  final PackData? _corePack;
  final TypedKeyFileSystem<PackData> _fileSystem;

  PacksService({
    PackData? corePack,
  })  : _corePack = corePack,
        _fileSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'packs',
            getDirectory: (storage) async =>
                '${await getQuokkaDirectory()}/Packs',
            database: 'quokka.db',
          ),
          onDecode: (data) => PackData.fromData(data),
          onEncode: (data) => data.export(),
        );

  Future<PackData?> fetchCorePack() async =>
      _corePack ?? await PackData.getCorePack();

  Future<Map<String, PackData>> getPacks() async {
    final corePack = await fetchCorePack();
    await _fileSystem.initialize();
    return {
      ...Map.fromEntries((await _fileSystem.getFiles())
          .map((file) => file.data == null
              ? null
              : MapEntry(file.fileNameWithoutExtension, file.data!))
          .whereNotNull()),
      if (corePack != null) 'f': corePack,
    };
  }
}
