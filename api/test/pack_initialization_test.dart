import 'package:networker/networker.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:test/test.dart';

class _Assets extends AssetManager {
  final _packs = {
    kCorePackId: SetonixData.empty().setMetadata(
      const FileMetadata(name: 'Core pack'),
    ),
  };

  @override
  Iterable<MapEntry<String, SetonixData>> get packs => _packs.entries;
  @override
  SetonixData? getPack(String key) => _packs[key];
  @override
  bool hasPack(String key) => _packs.containsKey(key);
}

void main() {
  final assets = _Assets();
  final signature = assets.createSignature().values.toList();

  WorldState world(SetonixData data) => WorldState(
    data: data,
    table: data.getTableOrDefault(),
    info: data.getInfoOrDefault(),
  );

  test('creating a sandbox preserves all selected packs', () {
    final data = SetonixData.fromMode(null, packs: {'core', 'custom'});
    final reloaded = SetonixData.fromData(data.exportAsBytes());

    expect(reloaded.getInfoOrDefault().packs, ['core', 'custom']);
    expect(reloaded.getInfoOrDefault().gameMode, isNull);
  });

  test('sandbox join requires the core pack on the client', () async {
    final state = world(SetonixData.fromMode(null, packs: {'core'}));
    final response = await processClientEvent(
      null,
      2,
      state,
      assetManager: assets,
    ) as UpdateServerResponse;
    final event = response.main!.data as WorldInitialized;

    expect(event.info!.packs, ['core']);
    expect(event.packsSignature!.map((pack) => pack.id), ['core']);
    expect(
      () => processServerEvent(event, state, signature: []),
      throwsA(isA<InvalidPacksError>()),
    );
    expect(processServerEvent(event, state, signature: signature).state!.id, 2);
  });

  test(
    'pack changes include signatures and apply to existing empty worlds',
    () async {
      final state = world(SetonixData.empty());
      final response = await processClientEvent(
        PacksChangeRequest(['core', 'core', 'missing']),
        kAuthorityChannel,
        state,
        assetManager: assets,
      ) as UpdateServerResponse;
      final event = response.main!.data as WorldInitialized;

      expect(event.info!.packs, ['core']);
      expect(event.packsSignature!.map((pack) => pack.id), ['core']);
      expect(
        processServerEvent(
          event,
          state,
          signature: signature,
        ).state!.info.packs,
        ['core'],
      );
      expect(
        () => processServerEvent(event, state, signature: []),
        throwsA(isA<InvalidPacksError>()),
      );
    },
  );

  test('sandbox resets include signatures and keep active packs', () async {
    final state = world(SetonixData.fromMode(null, packs: {'core'}));
    final response = await processClientEvent(
      ModeChangeRequest.plain(),
      kAuthorityChannel,
      state,
      assetManager: assets,
    ) as UpdateServerResponse;
    final event = response.main!.data as WorldInitialized;

    expect(event.packsSignature!.map((pack) => pack.id), ['core']);
    expect(
      processServerEvent(event, state, signature: signature).state!.info.packs,
      ['core'],
    );
  });

  test('incomplete pack declarations fail visibly', () {
    final state = world(SetonixData.empty());
    expect(
      () => processServerEvent(
        WorldInitialized(info: const GameInfo(packs: ['core'])),
        state,
        signature: signature,
      ),
      throwsA(isA<InvalidPacksError>()),
    );
    expect(
      processServerEvent(
        WorldInitialized(table: const GameTable()),
        state,
        signature: signature,
      ).state,
      isNotNull,
    );
  });
}
