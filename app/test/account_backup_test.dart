import 'dart:typed_data';

import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix_api/setonix_api.dart';

void main() {
  test(
    'account backups are encrypted and round-trip valid key pairs',
    () async {
      final keyPair = await Ed25519().newKeyPair();
      final privateKey = await keyPair.extractPrivateKeyBytes();
      final publicKey = await keyPair.extractPublicKey();
      final account = SetonixAccount(
        privateKey: Uint8List.fromList(privateKey),
        publicKey: Uint8List.fromList(publicKey.bytes),
        name: 'Alice',
      );

      final encrypted = await encryptAccountBackup([account], 'correct horse');
      final restored = await decryptAccountBackup(encrypted, 'correct horse');

      expect(encrypted, isNot(containsAllInOrder(account.privateKey)));
      expect(restored, hasLength(1));
      expect(restored.single.name, 'Alice');
      expect(restored.single.privateKey, account.privateKey);
      expect(restored.single.publicKey, account.publicKey);
      await expectLater(
        decryptAccountBackup(encrypted, 'wrong passphrase'),
        throwsA(isA<SecretBoxAuthenticationError>()),
      );
    },
  );

  test('account backup encryption rejects mismatched key pairs', () async {
    final invalid = SetonixAccount(
      privateKey: Uint8List(32),
      publicKey: Uint8List(32),
      name: 'invalid',
    );

    await expectLater(
      encryptAccountBackup([invalid], 'passphrase'),
      throwsA(isA<FormatException>()),
    );
  });
}
