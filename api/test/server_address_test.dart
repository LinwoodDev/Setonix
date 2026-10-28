import 'package:setonix_api/setonix_api.dart';
import 'package:test/test.dart';

void main() {
  group('server addresses', () {
    test('parses host:port while preserving the path and query', () {
      final result = buildServerAddress(
        Uri.parse('localhost:28006/game?world=main'),
        false,
      );
      expect(result, Uri.parse('ws://localhost:28006/game?world=main'));
    });

    test('rejects missing hosts', () {
      for (final address in ['', '/', 'wss:///']) {
        expect(
          () => buildServerAddress(Uri.parse(address), true),
          throwsFormatException,
        );
      }
    });
  });
}
