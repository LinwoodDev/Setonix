import 'dart:typed_data';

import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:test/test.dart';

void main() {
  group('authentication protocol', () {
    late SimpleKeyPair keyPair;
    late SetonixAccount account;

    setUp(() async {
      keyPair = await Ed25519().newKeyPair();
      final privateKey = await keyPair.extractPrivateKeyBytes();
      final publicKey = await keyPair.extractPublicKey();
      account = SetonixAccount(
        privateKey: Uint8List.fromList(privateKey),
        publicKey: Uint8List.fromList(publicKey.bytes),
        name: 'test',
      );
    });

    test('signs and verifies the complete challenge transcript', () async {
      final manager = ChallengeManager(serverId: 'server-certificate-hash');
      final challenge = manager.generateNewChallenge(7);
      final request = AuthenticatedRequested(
        challenge: challenge.nonce,
        serverId: challenge.serverId,
        channel: challenge.channel,
        issuedAt: challenge.issuedAt,
        expiresAt: challenge.expiresAt,
      );

      final response = await AuthenticateRequest.build(request, account, 7);

      expect(response.hasValidLengths, isTrue);
      expect(await response.verify(challenge), isTrue);
      expect(
        await response.verify(
          AuthenticationChallenge(
            nonce: challenge.nonce,
            serverId: 'different-server',
            channel: challenge.channel,
            issuedAt: challenge.issuedAt,
            expiresAt: challenge.expiresAt,
          ),
        ),
        isFalse,
      );
    });

    test('rejects expired or wrongly bound challenges on the client', () async {
      final expired = AuthenticatedRequested(
        challenge: generateChallenge(),
        serverId: 'server',
        channel: 7,
        issuedAt: DateTime.now().toUtc().subtract(const Duration(minutes: 2)),
        expiresAt: DateTime.now().toUtc().subtract(const Duration(minutes: 1)),
      );
      await expectLater(
        AuthenticateRequest.build(expired, account, 7),
        throwsFormatException,
      );

      final manager = ChallengeManager(serverId: 'server');
      final challenge = manager.generateNewChallenge(7);
      final wrongChannel = AuthenticatedRequested(
        challenge: challenge.nonce,
        serverId: challenge.serverId,
        channel: challenge.channel,
        issuedAt: challenge.issuedAt,
        expiresAt: challenge.expiresAt,
      );
      await expectLater(
        AuthenticateRequest.build(wrongChannel, account, 8),
        throwsFormatException,
      );
    });

    test('rejects malformed Ed25519 field lengths before verification', () {
      expect(
        AuthenticateRequest(Uint8List(63), Uint8List(32)).hasValidLengths,
        isFalse,
      );
      expect(
        AuthenticateRequest(Uint8List(64), Uint8List(31)).hasValidLengths,
        isFalse,
      );
    });

    test('expires challenges and caps failed attempts', () {
      var now = DateTime.utc(2026, 1, 1);
      final manager = ChallengeManager(
        serverId: 'server',
        ttl: const Duration(seconds: 5),
        maxAttempts: 3,
        now: () => now,
      );

      manager.generateNewChallenge(2);
      expect(manager.registerFailedAttempt(2)?.failedAttempts, 1);
      expect(manager.registerFailedAttempt(2)?.failedAttempts, 2);
      expect(manager.registerFailedAttempt(2), isNull);
      expect(manager.getChallenge(2), isNull);

      manager.generateNewChallenge(3);
      now = now.add(const Duration(seconds: 6));
      expect(manager.getChallenge(3), isNull);
    });

    test('rate limits authentication work per source and resets by window', () {
      var now = DateTime.utc(2026, 1, 1);
      final limiter = AuthenticationRateLimiter(
        maxAttempts: 2,
        window: const Duration(minutes: 1),
        now: () => now,
      );

      expect(limiter.allow('192.0.2.1'), isTrue);
      expect(limiter.allow('192.0.2.1'), isTrue);
      expect(limiter.allow('192.0.2.1'), isFalse);
      expect(limiter.allow('192.0.2.2'), isTrue);
      now = now.add(const Duration(minutes: 2));
      expect(limiter.allow('192.0.2.1'), isTrue);
    });

    test('validates that imported public and private keys match', () async {
      expect(await account.hasValidKeyPair(), isTrue);
      expect(
        await SetonixAccount(
          privateKey: account.privateKey,
          publicKey: Uint8List(32),
          name: 'invalid',
        ).hasValidKeyPair(),
        isFalse,
      );
    });

    test('consumes a successful challenge and rejects replay', () async {
      final challenges = ChallengeManager(serverId: 'server');
      final users = UserManager();
      final state = WorldState(data: SetonixData.empty());
      final initial = await processClientEvent(
        null,
        7,
        state,
        assetManager: _EmptyAssetManager(),
        challengeManager: challenges,
        userManager: users,
      );
      final request =
          (initial as UpdateServerResponse).main!.data
              as AuthenticatedRequested;
      final proof = await AuthenticateRequest.build(request, account, 7);

      final accepted = await processClientEvent(
        proof,
        7,
        state,
        assetManager: _EmptyAssetManager(),
        challengeManager: challenges,
        userManager: users,
      );
      final replayed = await processClientEvent(
        proof,
        7,
        state,
        assetManager: _EmptyAssetManager(),
        challengeManager: challenges,
        userManager: users,
      );

      expect(accepted, isA<UpdateServerResponse>());
      expect(users.getUser(7)?.fingerprint, account.getFingerprint());
      expect(replayed, isA<KickServerResponse>());
      expect(
        (replayed as KickServerResponse).message.reason,
        KickReason.challengeFailed,
      );
    });
  });
}

final class _EmptyAssetManager extends AssetManager {
  @override
  Iterable<MapEntry<String, SetonixData>> get packs => const [];

  @override
  SetonixData? getPack(String key) => null;

  @override
  bool hasPack(String key) => false;
}
