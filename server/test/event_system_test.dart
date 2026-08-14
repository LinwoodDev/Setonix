import 'dart:typed_data';

import 'package:networker/networker.dart';
import 'package:setonix_plugin/events.dart';
import 'package:test/test.dart';

void main() {
  test('late leave callbacks are ignored after event system disposal', () {
    final system = EventSystem();
    final info = _TestConnectionInfo();

    system.dispose();

    expect(() => system.runLeaveCallback(2, info), returnsNormally);
    expect(system.dispose, returnsNormally);
  });
}

final class _TestConnectionInfo extends ConnectionInfo {
  @override
  Uri get address => Uri.parse('ws://localhost');

  @override
  bool get isClosed => false;

  @override
  void close() {}

  @override
  void sendMessage(Uint8List data) {}
}
