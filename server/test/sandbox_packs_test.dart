import 'dart:io';

import 'package:networker/networker.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/server.dart';
import 'package:test/test.dart';

void main() {
  test('a new server sandbox activates its loaded packs', () async {
    final directory = await Directory.systemTemp.createTemp('setonix-packs-');
    await Directory('${directory.path}/packs').create();
    await File('../app/assets/pack.stnx')
        .copy('${directory.path}/packs/core.stnx');
    final customBytes = SetonixData.empty()
        .setMetadata(const FileMetadata(name: 'Custom pack'))
        .exportAsBytes();
    final customId = createPackIdentifier(customBytes);
    await File('${directory.path}/packs/custom.stnx').writeAsBytes(customBytes);
    await File('${directory.path}/packs/custom.json')
        .writeAsString('{"downloadUrls":["https://example.com/custom.stnx"]}');
    final server = await SetonixServer.load(
      rootPath: directory.path,
      argsConfig: const SetonixConfig(
        host: '127.0.0.1',
        port: 0,
        accountRequired: false,
      ),
    );
    addTearDown(() async {
      await server.close();
      await directory.delete(recursive: true);
    });
    await server.init();

    expect(server.defaultState.info.packs, unorderedEquals(['core', customId]));
    final core = server.assetManager.getPack('core')!;
    expect(core.getFigures(), isNotEmpty);
    expect(core.getBackgrounds(), isNotEmpty);
    expect(server.assetManager.getPack(customId)!.identifier, customId);
    expect(server.assetManager.hasPack(customId), isTrue);
    expect(server.assetManager.getPackId('custom'), customId);
    expect(server.assetManager.getPack('custom'), isNull);
    expect(server.assetManager.getDownloadUrls(customId), [
      'https://example.com/custom.stnx',
    ]);

    final response = await processClientEvent(
      PacksChangeRequest([customId, 'core']),
      kAuthorityChannel,
      server.defaultState,
      assetManager: server.assetManager,
    ) as UpdateServerResponse;
    final initialized = response.main!.data as WorldInitialized;
    expect(initialized.info!.packs, [customId, 'core']);
    expect(
      initialized.packsSignature!.map((pack) => pack.id),
      unorderedEquals(['core', customId]),
    );
  });
}
