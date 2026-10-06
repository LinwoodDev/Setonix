import 'package:setonix_api/setonix_api.dart';
import 'package:test/test.dart';

void main() {
  test(
    'object replacements redact hidden cards without changing server state',
    () {
      final hidden = GameObject(
        ItemLocation('core', 'cards'),
        variation: 'heart-ace',
        hidden: true,
      );
      final visible = GameObject(
        ItemLocation('core', 'cards'),
        variation: 'club-7',
      );
      final event = ObjectsChanged(GlobalVectorDefinition('', 0, 0), [
        hidden,
        visible,
      ]);
      final protected = protectServerEvent(event) as ObjectsChanged;

      expect(protected.objects.first.variation, isNull);
      expect(protected.objects.last.variation, 'club-7');
      expect(event.objects.first.variation, 'heart-ace');
    },
  );

  group('Setonix protocol', () {
    test('adds and replaces the protocol query parameter', () {
      final address = Uri.parse('wss://example.com/game?world=main');

      final result = addSetonixProtocolVersion(address, version: 3);

      expect(result.queryParameters['world'], 'main');
      expect(readSetonixProtocolVersion(result), 3);
    });

    test('selects the highest protocol supported by client and server', () {
      const property = GameProperty(
        protocolVersions: [1, 2, 4],
        protocolCapabilities: kSetonixProtocolCapabilities,
      );

      expect(property.supportsProtocol([1, 2, 3]), isTrue);
      expect(property.requireProtocol([1, 2, 3]), 2);
    });

    test('rejects missing and mismatched protocol metadata', () {
      const missing = GameProperty();
      const mismatched = GameProperty(protocolVersions: [3, 4]);

      expect(
        missing.requireProtocol,
        throwsA(
          isA<IncompatibleProtocolException>().having(
            (error) => error.serverVersions,
            'serverVersions',
            isEmpty,
          ),
        ),
      );
      expect(
        mismatched.requireProtocol,
        throwsA(
          isA<IncompatibleProtocolException>().having(
            (error) => error.serverVersions,
            'serverVersions',
            [3, 4],
          ),
        ),
      );
    });

    test('preserves protocol metadata when serialized', () {
      const property = GameProperty(
        protocolVersions: kSetonixServerProtocolVersions,
        protocolCapabilities: kSetonixProtocolCapabilities,
      );

      final decoded = GamePropertyMapper.fromJson(property.toJson());

      expect(decoded.protocolVersions, kSetonixServerProtocolVersions);
      expect(decoded.protocolCapabilities, kSetonixProtocolCapabilities);
    });
  });
}
