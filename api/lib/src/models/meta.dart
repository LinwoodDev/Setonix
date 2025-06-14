import 'dart:typed_data';

import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:setonix_api/src/helpers/crypto.dart';

part 'meta.mapper.dart';

const kFileVersion = 0;

@MappableEnum()
enum FileType {
  pack,
  game,
  template,
  accounts,
}

@MappableClass()
final class FileMetadata with FileMetadataMappable {
  final FileType type;
  final String name;
  final String description;
  final String author;
  final String version;
  final Set<String> dependencies;
  final int fileVersion;

  const FileMetadata({
    this.type = FileType.pack,
    this.name = '',
    this.description = '',
    this.author = '',
    this.version = '',
    this.dependencies = const {},
    this.fileVersion = kFileVersion,
  });
}

@MappableClass()
final class SignatureMetadata with SignatureMetadataMappable {
  final String id;
  final FileMetadata metadata;
  final List<String> downloadUrls;

  SignatureMetadata({
    required this.id,
    required this.metadata,
    this.downloadUrls = const [],
  });

  bool supports(SignatureMetadata other) {
    return id == other.id;
  }
}

@MappableClass()
final class DataMetadata with DataMetadataMappable {
  final bool manuallyAdded;
  final DateTime addedAt;
  final Map<String, DateTime> serversLastUsed;

  DataMetadata({
    this.manuallyAdded = true,
    required this.addedAt,
    this.serversLastUsed = const {},
  });

  DateTime lastUsed() {
    return serversLastUsed.values.fold(addedAt, (a, b) => a.isAfter(b) ? a : b);
  }
}

final class SetonixAccount {
  final Uint8List privateKey;
  final Uint8List publicKey;
  final String name;

  SetonixAccount({
    required this.privateKey,
    required this.publicKey,
    required this.name,
  });

  KeyPair get keyPair => SimpleKeyPairData(
        privateKey,
        publicKey: SimplePublicKey(publicKey, type: KeyPairType.ed25519),
        type: KeyPairType.ed25519,
      );

  String getFingerprint([bool short = false]) =>
      generateFingerprint(publicKey, short);
}
