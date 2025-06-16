import 'dart:math';
import 'dart:typed_data';

import 'package:networker/networker.dart';

class ChallengeManager {
  final Map<Channel, Uint8List> _challenges = {};

  Uint8List getChallenge(Channel channel) {
    return _challenges[channel] ??= generateChallenge();
  }

  void removeChallenge(Channel channel) {
    _challenges.remove(channel);
  }
}

Uint8List generateChallenge() {
  final random = Random.secure();
  final bytes = Uint8List(32);
  for (var i = 0; i < bytes.length; i++) {
    bytes[i] = random.nextInt(256);
  }
  return bytes;
}
