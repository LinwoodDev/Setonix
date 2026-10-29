import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Network extends NetworkService {
  _Network(super.settingsCubit);

  @override
  Future<GameProperty?> fetchInfo(Uri address) async => const GameProperty();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('local settings changes preserve public server listings', () async {
    final original = ListGameServer(address: 'original.example.com');
    final added = ListGameServer(address: 'added.example.com');
    final public = BrowsedGameServer(address: 'public.example.com');
    SharedPreferences.setMockInitialValues({
      'servers': [original.toJson()],
      'serverList': ['https://lists.example.com/servers.json'],
    });
    final settings = SettingsCubit(await SharedPreferences.getInstance());
    final network = _Network(settings);
    StreamSubscription<Map<GameServer, GameProperty?>>? subscription;
    addTearDown(() async {
      network.dispose();
      await subscription?.cancel();
      await settings.close();
    });

    await http.runWithClient(
      () async {
        await network.init();
        final publicLoaded = Completer<void>();
        final localAdded = Completer<Map<GameServer, GameProperty?>>();
        final localRemoved = Completer<Map<GameServer, GameProperty?>>();
        subscription = network.fetchServersWithProperties().listen((servers) {
          final snapshot = Map<GameServer, GameProperty?>.of(servers);
          if (snapshot.containsKey(public) && !publicLoaded.isCompleted) {
            publicLoaded.complete();
          }
          if (snapshot.containsKey(added) && !localAdded.isCompleted) {
            localAdded.complete(snapshot);
          }
          if (localAdded.isCompleted &&
              !snapshot.containsKey(original) &&
              !localRemoved.isCompleted) {
            localRemoved.complete(snapshot);
          }
        });
        await publicLoaded.future.timeout(const Duration(seconds: 5));
        await settings.addServer(added);
        final afterAdd = await localAdded.future.timeout(
          const Duration(seconds: 5),
        );
        expect(afterAdd.keys, containsAll([original, added, public]));
        await settings.removeServer(0);
        final afterRemove = await localRemoved.future.timeout(
          const Duration(seconds: 5),
        );
        expect(afterRemove.keys, containsAll([added, public]));
        expect(afterRemove.keys, isNot(contains(original)));
      },
      () => MockClient((request) async {
        expect(request.url.host, 'lists.example.com');
        return http.Response(
          jsonEncode({
            'servers': [public.toMap()],
          }),
          200,
        );
      }),
    );
  });
}
