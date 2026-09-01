import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:http/http.dart' as http;
import 'package:idb_shim/idb.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/api/storage.dart';
import 'package:setonix_api/setonix_api.dart';

enum PackDownloadResult {
  success,
  alreadyExists,
  downloadFailed,
  invalidIdentifier,
  invalidUri;

  bool get isSuccess => this == success || this == alreadyExists;
}

const _accountBackupVersion = 1;
const _accountBackupPath = '$kPackAccountsPath/backup.json';
const _accountBackupAad = 'setonix-account-backup';

final _accountBackupKdf = Argon2id(
  parallelism: 2,
  memory: 32 * 1024,
  iterations: 2,
  hashLength: 32,
);

Uint8List _secureRandomBytes(int length) {
  final random = Random.secure();
  return Uint8List.fromList(
    List<int>.generate(length, (_) => random.nextInt(256)),
  );
}

Future<SecretKey> _deriveAccountBackupKey(String passphrase, List<int> salt) {
  if (passphrase.isEmpty) {
    throw ArgumentError.value(passphrase, 'passphrase', 'Cannot be empty.');
  }
  return _accountBackupKdf.deriveKeyFromPassword(
    password: passphrase,
    nonce: salt,
  );
}

Future<Uint8List> encryptAccountBackup(
  Iterable<SetonixAccount> accounts,
  String passphrase,
) async {
  final encodedAccounts = <Map<String, String>>[];
  for (final account in accounts) {
    if (!await account.hasValidKeyPair()) {
      throw FormatException(
        'Account "${account.name}" has a mismatched key pair.',
      );
    }
    encodedAccounts.add({
      'name': account.name,
      'privateKey': base64Encode(account.privateKey),
      'publicKey': base64Encode(account.publicKey),
    });
  }
  final salt = _secureRandomBytes(16);
  final key = await _deriveAccountBackupKey(passphrase, salt);
  final cipher = AesGcm.with256bits();
  final box = await cipher.encrypt(
    utf8.encode(jsonEncode(encodedAccounts)),
    secretKey: key,
    nonce: cipher.newNonce(),
    aad: utf8.encode(_accountBackupAad),
  );
  return Uint8List.fromList(
    utf8.encode(
      jsonEncode({
        'version': _accountBackupVersion,
        'kdf': 'argon2id-32m-2x2',
        'cipher': 'aes-256-gcm',
        'salt': base64Encode(salt),
        'nonce': base64Encode(box.nonce),
        'cipherText': base64Encode(box.cipherText),
        'mac': base64Encode(box.mac.bytes),
      }),
    ),
  );
}

Future<List<SetonixAccount>> decryptAccountBackup(
  Uint8List encodedEnvelope,
  String passphrase,
) async {
  if (encodedEnvelope.length > 12 * 1024 * 1024) {
    throw const FormatException('Account backup is too large.');
  }
  final envelope = jsonDecode(utf8.decode(encodedEnvelope));
  if (envelope is! Map<String, dynamic> ||
      envelope['version'] != _accountBackupVersion ||
      envelope['kdf'] != 'argon2id-32m-2x2' ||
      envelope['cipher'] != 'aes-256-gcm') {
    throw const FormatException('Unsupported account backup format.');
  }
  List<int> decodeField(String name, {int? exactLength}) {
    final value = envelope[name];
    if (value is! String || value.length > 16 * 1024 * 1024) {
      throw FormatException('Invalid account backup field: $name.');
    }
    final decoded = base64Decode(value);
    if (exactLength != null && decoded.length != exactLength) {
      throw FormatException('Invalid account backup field length: $name.');
    }
    return decoded;
  }

  final salt = decodeField('salt', exactLength: 16);
  final nonce = decodeField('nonce', exactLength: 12);
  final mac = decodeField('mac', exactLength: 16);
  final cipherText = decodeField('cipherText');
  final key = await _deriveAccountBackupKey(passphrase, salt);
  final clearText = await AesGcm.with256bits().decrypt(
    SecretBox(cipherText, nonce: nonce, mac: Mac(mac)),
    secretKey: key,
    aad: utf8.encode(_accountBackupAad),
  );
  final decodedAccounts = jsonDecode(utf8.decode(clearText));
  if (decodedAccounts is! List || decodedAccounts.length > 1024) {
    throw const FormatException('Invalid account backup contents.');
  }
  final accounts = <SetonixAccount>[];
  for (final value in decodedAccounts) {
    if (value is! Map<String, dynamic>) {
      throw const FormatException('Invalid account entry.');
    }
    final name = value['name'];
    final privateKey = value['privateKey'];
    final publicKey = value['publicKey'];
    if (name is! String ||
        name.isEmpty ||
        name.length > 256 ||
        privateKey is! String ||
        publicKey is! String) {
      throw const FormatException('Invalid account entry.');
    }
    final account = SetonixAccount(
      name: name,
      privateKey: Uint8List.fromList(base64Decode(privateKey)),
      publicKey: Uint8List.fromList(base64Decode(publicKey)),
    );
    if (!await account.hasValidKeyPair()) {
      throw FormatException('Account "$name" has a mismatched key pair.');
    }
    accounts.add(account);
  }
  return accounts;
}

bool _isSafeDownloadUri(Uri uri) {
  if (uri.isScheme('https')) return true;
  if (!uri.isScheme('http')) return false;
  return uri.host == 'localhost' ||
      uri.host == '127.0.0.1' ||
      uri.host == '::1';
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
      event.database.createObjectStore('editor');
      event.database.createObjectStore('accounts');
    }
  }

  static const kDatabaseVersion = 3;

  SetonixFileSystem({this._corePack})
    : packSystem = TypedKeyFileSystem.build(
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
      ?corePack,
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
      if (!_isSafeDownloadUri(uri)) return PackDownloadResult.invalidUri;
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
    final account = SetonixAccount(
      privateKey: privateKey,
      publicKey: publicKey,
      name: name,
    );
    return await account.hasValidKeyPair() ? account : null;
  }

  Future<void> deleteAccount(String name) async {
    await privateKeySystem.deleteFile(name);
    await publicKeySystem.deleteFile(name);
  }

  Future<void> importAccountsFromData(
    SetonixData data,
    String passphrase,
  ) async {
    final encodedEnvelope = data.getAsset(_accountBackupPath);
    if (encodedEnvelope == null) {
      throw const FormatException(
        'Only encrypted account backups are supported.',
      );
    }
    await importAccounts(
      await decryptAccountBackup(encodedEnvelope, passphrase),
    );
  }

  Future<void> importAccounts(List<SetonixAccount> accounts) async {
    for (final account in accounts) {
      if (!await account.hasValidKeyPair()) {
        throw FormatException(
          'Account "${account.name}" has a mismatched key pair.',
        );
      }
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
    return Future.wait(names.map((name) => getAccount(name)))
        .then((accounts) => accounts.nonNulls.toList());
  }

  Future<SetonixData> exportAccounts(
    String passphrase, [
    List<String>? names,
    List<SetonixAccount>? accounts,
  ]) async {
    var data = SetonixData.empty().setMetadata(
      FileMetadata(type: SetonixFileType.accounts),
    );
    final allAccounts = accounts ?? await getAccounts(names);
    final envelope = await encryptAccountBackup(allAccounts, passphrase);
    return data.setAsset(_accountBackupPath, envelope);
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
