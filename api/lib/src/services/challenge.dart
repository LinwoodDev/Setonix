import 'dart:math';
import 'dart:typed_data';

import 'package:networker/networker.dart';

const kAuthenticationProtocolVersion = 1;
const kAuthenticationChallengeLength = 32;
const kEd25519PublicKeyLength = 32;
const kEd25519SignatureLength = 64;
const kDefaultAuthenticationChallengeTtl = Duration(seconds: 45);
const kDefaultAuthenticationMaxAttempts = 3;
const kDefaultAuthenticationRateLimit = 12;
const kDefaultAuthenticationRateWindow = Duration(minutes: 1);

final class AuthenticationChallenge {
  final Uint8List nonce;
  final String serverId;
  final Channel channel;
  final DateTime issuedAt;
  final DateTime expiresAt;
  final int failedAttempts;

  const AuthenticationChallenge({
    required this.nonce,
    required this.serverId,
    required this.channel,
    required this.issuedAt,
    required this.expiresAt,
    this.failedAttempts = 0,
  });

  bool isExpired(DateTime now) => !expiresAt.isAfter(now);
}

final class AuthenticationRateLimiter {
  final int maxAttempts;
  final Duration window;
  final int maxTrackedSources;
  final DateTime Function() _now;
  final Map<String, List<DateTime>> _attempts = {};

  AuthenticationRateLimiter({
    this.maxAttempts = kDefaultAuthenticationRateLimit,
    this.window = kDefaultAuthenticationRateWindow,
    this.maxTrackedSources = 4096,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  bool allow(String source) {
    final now = _now();
    final cutoff = now.subtract(window);
    _attempts.removeWhere((_, attempts) {
      attempts.removeWhere((attempt) => !attempt.isAfter(cutoff));
      return attempts.isEmpty;
    });
    if (!_attempts.containsKey(source) &&
        _attempts.length >= maxTrackedSources) {
      return false;
    }
    final attempts = _attempts.putIfAbsent(source, () => []);
    if (attempts.length >= maxAttempts) return false;
    attempts.add(now);
    return true;
  }

  void clear() => _attempts.clear();
}

class ChallengeManager {
  final Map<Channel, AuthenticationChallenge> _challenges = {};
  final Duration ttl;
  final int maxAttempts;
  final DateTime Function() _now;
  String serverId;

  ChallengeManager({
    required this.serverId,
    this.ttl = kDefaultAuthenticationChallengeTtl,
    this.maxAttempts = kDefaultAuthenticationMaxAttempts,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  AuthenticationChallenge? getChallenge(Channel channel) {
    final challenge = _challenges[channel];
    if (challenge == null) return null;
    if (challenge.isExpired(_now())) {
      _challenges.remove(channel);
      return null;
    }
    return challenge;
  }

  AuthenticationChallenge generateNewChallenge(
    Channel channel, {
    int failedAttempts = 0,
  }) {
    final issuedAt = _now().toUtc();
    final challenge = AuthenticationChallenge(
      nonce: generateChallenge(),
      serverId: serverId,
      channel: channel,
      issuedAt: issuedAt,
      expiresAt: issuedAt.add(ttl),
      failedAttempts: failedAttempts,
    );
    _challenges[channel] = challenge;
    return challenge;
  }

  AuthenticationChallenge? registerFailedAttempt(Channel channel) {
    final current = getChallenge(channel);
    if (current == null) return null;
    final failedAttempts = current.failedAttempts + 1;
    if (failedAttempts >= maxAttempts) {
      _challenges.remove(channel);
      return null;
    }
    return generateNewChallenge(channel, failedAttempts: failedAttempts);
  }

  void removeChallenge(Channel channel) {
    _challenges.remove(channel);
  }
}

Uint8List generateChallenge() {
  final random = Random.secure();
  final bytes = Uint8List(kAuthenticationChallengeLength);
  for (var i = 0; i < bytes.length; i++) {
    bytes[i] = random.nextInt(256);
  }
  return bytes;
}
