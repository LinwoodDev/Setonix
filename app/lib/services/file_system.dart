import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:file_selector/file_selector.dart' as fs;
import 'package:http/http.dart' as http;
import 'package:idb_shim/idb.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/api/storage.dart';
import 'package:setonix_api/setonix_api.dart';

const imageTypeGroup = fs.XTypeGroup(
  label: 'Images',
  extensions: <String>['png', 'jpg', 'jpeg', 'gif'],
  mimeTypes: <String>['image/png', 'image/jpeg', 'image/gif'],
  uniformTypeIdentifiers: <String>['public.png', 'public.jpeg'],
);

enum PackDownloadResult {
  success,
  alreadyExists,
  downloadFailed,
  invalidIdentifier,
  invalidUri;

  bool get isSuccess => this == success || this == alreadyExists;
}

class SetonixFileSystem {
  SetonixFile? _corePack;
  final TypedKeyFileSystem<SetonixFile> packSystem;
  final TypedKeyFileSystem<SetonixData> templateSystem,
      worldSystem,
      editorSystem;
  final TypedKeyFileSystem<DataMetadata> dataInfoSystem;
  final KeyFileSystem privateKeySystem, publicKeySystem;

  static Future<void> _onDatabaseUpgrade(VersionChangeEvent event) async {
    await initStores(event, ['packs', 'templates', 'worlds']);
    if (event.oldVersion < 2) {
      event.database.createObjectStore('packs-data');
    }
    if (event.oldVersion < 3) {
      event.database.createObjectStore('accounts');
    }
  }

  static const kDatabaseVersion = 2;

  SetonixFileSystem({SetonixFile? corePack})
    : _corePack = corePack,
      packSystem = TypedKeyFileSystem.build(
        FileSystemConfig(
          passwordStorage: SecureStoragePasswordStorage(),
          storeName: 'packs',
          getDirectory: (storage) async =>
              '${await getSetonixDirectory()}/Packs',
          database: 'setonix.db',
          databaseVersion: kDatabaseVersion,
          keySuffix: '.stnx',
          onDatabaseUpgrade: _onDatabaseUpgrade,
        ),
        onDecode: SetonixFile.new,
        onEncode: (data) => data.data,
      ),
      dataInfoSystem = TypedKeyFileSystem.build(
        FileSystemConfig(
          passwordStorage: SecureStoragePasswordStorage(),
          storeName: 'packs',
          getDirectory: (storage) async =>
              '${await getSetonixDirectory()}/Packs',
          database: 'setonix.db',
          databaseVersion: kDatabaseVersion,
          keySuffix: '.json',
          onDatabaseUpgrade: _onDatabaseUpgrade,
        ),
        onEncode: (data) => utf8.encode(data.toJson()),
        onDecode: (data) => DataMetadataMapper.fromJson(utf8.decode(data)),
      ),
      templateSystem = TypedKeyFileSystem.build(
        FileSystemConfig(
          passwordStorage: SecureStoragePasswordStorage(),
          storeName: 'templates',
          getDirectory: (storage) async =>
              '${await getSetonixDirectory()}/Templates',
          database: 'setonix.db',
          databaseVersion: kDatabaseVersion,
          keySuffix: '.stnx',
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
          databaseVersion: kDatabaseVersion,
          keySuffix: '.stnx',
          onDatabaseUpgrade: _onDatabaseUpgrade,
        ),
        onDecode: SetonixData.fromData,
        onEncode: (data) => data.exportAsBytes(),
      ),
      editorSystem = TypedKeyFileSystem.build(
        FileSystemConfig(
          passwordStorage: SecureStoragePasswordStorage(),
          storeName: 'editor',
          getDirectory: (storage) async =>
              '${await getSetonixDirectory()}/Editor',
          database: 'setonix.db',
          databaseVersion: kDatabaseVersion,
          keySuffix: '.stnx',
          onDatabaseUpgrade: _onDatabaseUpgrade,
        ),
        onDecode: SetonixData.fromData,
        onEncode: (data) => data.exportAsBytes(),
      ),
      privateKeySystem = KeyFileSystem.fromPlatform(
        FileSystemConfig(
          passwordStorage: SecureStoragePasswordStorage(),
          storeName: 'accounts',
          getDirectory: (storage) async =>
              '${await getSetonixDirectory()}/Accounts',
          database: 'setonix.db',
          databaseVersion: kDatabaseVersion,
          keySuffix: '.key',
          onDatabaseUpgrade: _onDatabaseUpgrade,
        ),
      ),
      publicKeySystem = KeyFileSystem.fromPlatform(
        FileSystemConfig(
          passwordStorage: SecureStoragePasswordStorage(),
          storeName: 'accounts',
          getDirectory: (storage) async =>
              '${await getSetonixDirectory()}/Accounts',
          database: 'setonix.db',
          databaseVersion: kDatabaseVersion,
          keySuffix: '.pub',
          onDatabaseUpgrade: _onDatabaseUpgrade,
        ),
      );

  Future<SetonixFile> fetchCorePack() async =>
      _corePack ?? (_corePack = await getCorePack());

  Future<Iterable<SetonixFile>> getPacks({
    bool fetchCore = true,
    bool force = false,
  }) async {
    final corePack = fetchCore ? await fetchCorePack() : null;
    await packSystem.initialize();
    return HashSet<SetonixFile>(
      equals: (a, b) => a.identifier == b.identifier,
      hashCode: (a) => a.identifier.hashCode,
    )..addAll([
      ...(await packSystem.getFiles()).map((e) => e.data!),
      if (corePack != null) corePack,
    ]);
  }

  Future<SetonixFile?> getPack(String packId) =>
      packId == kCorePackId ? fetchCorePack() : packSystem.getFile(packId);

  Future<bool> addPack(Uint8List data, {bool force = false}) async {
    final pack = SetonixFile(data);
    final identifier = pack.identifier;
    if (!force && await packSystem.hasKey(identifier)) return false;
    await packSystem.updateFile(identifier, pack);
    await dataInfoSystem.updateFile(
      identifier,
      DataMetadata(addedAt: DateTime.now(), manuallyAdded: true),
    );
    return true;
  }

  Future<PackDownloadResult> downloadPack(
    String url,
    String expectedIdentifier, {
    bool force = false,
  }) async {
    try {
      final uri = Uri.tryParse(url);
      if (uri == null) return PackDownloadResult.invalidUri;
      if (!uri.isScheme('http') && !uri.isScheme('https')) {
        return PackDownloadResult.invalidUri;
      }
      if (!force && await packSystem.hasKey(expectedIdentifier)) {
        return PackDownloadResult.alreadyExists;
      }
      final response = await http.get(uri);
      if (response.statusCode != 200) return PackDownloadResult.downloadFailed;
      final identifier = createPackIdentifier(response.bodyBytes);
      if (identifier != expectedIdentifier) {
        return PackDownloadResult.invalidIdentifier;
      }
      await packSystem.updateFile(
        expectedIdentifier,
        SetonixFile(response.bodyBytes),
      );
      await dataInfoSystem.updateFile(
        expectedIdentifier,
        DataMetadata(addedAt: DateTime.now(), manuallyAdded: false),
      );
      return PackDownloadResult.success;
    } catch (e) {
      return PackDownloadResult.downloadFailed;
    }
  }

  Future<void> updateServerLastUsed(String packId, String serverAddress) async {
    final data =
        await dataInfoSystem.getFile(packId) ??
        DataMetadata(addedAt: DateTime(0));
    data.serversLastUsed[serverAddress] = DateTime.now();
    await dataInfoSystem.updateFile(packId, data);
  }

  Future<void> updateMultipleServerLastUsed(
    Iterable<String> packIds,
    String serverAddress,
  ) async {
    for (final pack in packIds) {
      await updateServerLastUsed(pack, serverAddress);
    }
  }

  Future<void> generateKey(String name) async {
    final generator = Ed25519();
    final keyPair = await generator.newKeyPair();
    final privateKey = await keyPair.extractPrivateKeyBytes();
    final publicKey = await keyPair.extractPublicKey();
    await privateKeySystem.createFileWithName(
      Uint8List.fromList(privateKey),
      name: name,
    );
    await publicKeySystem.createFileWithName(
      Uint8List.fromList(publicKey.bytes),
      name: name,
    );
  }

  Future<SetonixAccount?> getAccount(String name) async {
    final privateKey = await privateKeySystem.getFile(name);
    if (privateKey == null) return null;
    final publicKey = await publicKeySystem.getFile(name);
    if (publicKey == null) return null;
    return SetonixAccount(
      privateKey: privateKey,
      publicKey: publicKey,
      name: name,
    );
  }

  Future<void> deleteAccount(String name) async {
    await privateKeySystem.deleteFile(name);
    await publicKeySystem.deleteFile(name);
  }

  Future<void> importAccountsFromData(SetonixData data) =>
      importAccounts(data.getAccounts().toList());

  Future<void> importAccounts(List<SetonixAccount> accounts) async {
    for (final account in accounts) {
      final name = await privateKeySystem.createFileWithName(
        account.privateKey,
        name: account.name,
      );
      await publicKeySystem.updateFile(name, account.publicKey);
    }
  }

  Future<List<SetonixAccount>> getAccounts([List<String>? names]) async {
    await privateKeySystem.initialize();
    names ??= await privateKeySystem.getKeys();
    return Future.wait(
      names.map((name) => getAccount(name)),
    ).then((accounts) => accounts.nonNulls.toList());
  }

  Future<SetonixData> exportAccounts([
    List<String>? names,
    List<SetonixAccount>? accounts,
  ]) async {
    var data = SetonixData.empty().setMetadata(
      FileMetadata(type: FileType.accounts),
    );
    final allAccounts = accounts ?? await getAccounts(names);
    for (final account in allAccounts) {
      final privateKey = account.privateKey;
      final publicKey = account.publicKey;
      if (privateKey.isEmpty || publicKey.isEmpty) continue;
      data = data.addAccount(
        SetonixAccount(
          privateKey: privateKey,
          publicKey: publicKey,
          name: account.name,
        ),
      );
    }
    return data;
  }

  Future<String> getFingerprint(
    String key, {
    bool short = false,
    bool pretty = false,
  }) async {
    final publicKey = await publicKeySystem.getFile(key);
    if (publicKey == null) {
      return '';
    }
    return generateFingerprint(publicKey, short: short, pretty: pretty);
  }
}
