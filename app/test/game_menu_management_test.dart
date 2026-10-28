import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:networker/networker.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/game.dart';
import 'package:setonix/helpers/asset.dart';
import 'package:setonix/pages/game/drawer.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

class _Network extends Fake implements NetworkService {}

class _Client extends Fake implements NetworkerClient {
  @override
  Uri get address => Uri.parse('wss://example.com');
}

class _Pipe extends Fake implements SimpleNetworkerPipe<WorldEvent> {}

class _Multiplayer extends MultiplayerCubit {
  _Multiplayer() : super(_Network());

  void connectRemote() => emit(MultiplayerConnectedState(_Client(), _Pipe()));
}

class _Game extends Fake implements BoardGame {}

class _Assets extends GameAssetManager {
  final pack = SetonixData.fromData(File('assets/pack.stnx').readAsBytesSync());

  _Assets() : super(fileSystem: SetonixFileSystem());

  @override
  Iterable<MapEntry<String, SetonixData>> get packs => [MapEntry('core', pack)];

  @override
  TranslationsStore getTranslations(String key) =>
      pack.getTranslationsStore(getLocale: () => 'en');
}

class _World extends Bloc<PlayableWorldEvent, ClientWorldState>
    implements WorldBloc {
  final requests = <WorldEvent>[];

  _World(MultiplayerCubit multiplayer)
    : super(
        ClientWorldState(
          multiplayer: multiplayer,
          assetManager: _Assets(),
          colorScheme: ThemeData().colorScheme,
          world: WorldState(
            data: SetonixData.empty(),
            info: const GameInfo(packs: ['core']),
          ),
        ),
      );

  void setRole(String role) => emit(
    state.copyWith.world(
      serverState: ServerState(
        permissions: kDefaultServerRoles[role]!.permissions,
      ),
    ),
  );

  @override
  Future<void> process(WorldEvent event) async {
    requests.add(event);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _Multiplayer multiplayer;
  late _World world;

  setUp(() {
    multiplayer = _Multiplayer();
    world = _World(multiplayer);
  });

  tearDown(() async {
    await world.close();
    await multiplayer.close();
  });

  Widget app() => MultiBlocProvider(
    providers: [
      BlocProvider<MultiplayerCubit>.value(value: multiplayer),
      BlocProvider<WorldBloc>.value(value: world),
    ],
    child: MaterialApp(
      localizationsDelegates: [
        ...AppLocalizations.localizationsDelegates,
        LeapLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: GameMenuDialog(game: _Game(), onHome: () async {}),
      ),
    ),
  );

  for (final role in ['player', 'moderator', 'owner']) {
    testWidgets('remote $role sees world tools according to permissions', (
      tester,
    ) async {
      multiplayer.connectRemote();
      world.setRole(role);
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      expect(
        find.text('Advanced options'),
        role == 'player' ? findsNothing : findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('role updates reveal tools and owner can change backgrounds', (
    tester,
  ) async {
    multiplayer.connectRemote();
    world.setRole('player');
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(find.text('Advanced options'), findsNothing);

    world.setRole('owner');
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Advanced options'));
    await tester.tap(find.text('Advanced options'));
    await tester.pumpAndSettle();
    expect(find.text('Packs'), findsOneWidget);
    await tester.tap(find.text('Background'));
    await tester.pumpAndSettle();

    final assets = world.state.assetManager as _Assets;
    final background = assets.pack.getBackgroundItems('core').first;
    final title = assets.pack
        .getTranslationsStore(getLocale: () => 'en')
        .getBackgroundTranslation(background.id)
        .name;
    await tester.tap(find.text(title));
    await tester.pumpAndSettle();
    expect(world.requests.single, isA<BackgroundChanged>());
    expect(
      (world.requests.single as BackgroundChanged).background,
      background.location,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('local worlds retain their world tools', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(find.text('Advanced options'), findsOneWidget);
  });
}
