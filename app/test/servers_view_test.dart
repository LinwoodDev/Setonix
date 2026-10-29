import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/pages/home/connect.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Network extends NetworkService {
  final List<GameServer> discovered;

  _Network(super.settingsCubit, this.discovered);

  @override
  Stream<Map<GameServer, GameProperty?>> fetchServersWithProperties({
    bool browsable = true,
    bool local = true,
  }) async* {
    Map<GameServer, GameProperty?> servers() => {
      for (final server in [...discovered, ...settingsCubit.state.servers])
        server: const GameProperty(),
    };
    yield servers();
    yield* settingsCubit.stream.map((_) => servers());
  }
}

void main() {
  late SettingsCubit settings;
  final alpha = ListGameServer(name: 'Alpha', address: 'alpha.example.com');
  final beta = ListGameServer(name: 'Beta', address: 'beta.example.com');

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'servers': [alpha.toJson(), beta.toJson()],
    });
    settings = SettingsCubit(await SharedPreferences.getInstance());
  });
  tearDown(() => settings.close());

  Future<void> openServers(
    WidgetTester tester, {
    List<GameServer> discovered = const [],
    bool mobile = false,
  }) async {
    tester.view.physicalSize = Size(mobile ? 600 : 1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      BlocProvider.value(
        value: settings,
        child: RepositoryProvider<NetworkService>.value(
          value: _Network(settings, discovered),
          child: MaterialApp(
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              LeapLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(body: ServersView()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('editing a search result updates the correct saved server', (
    tester,
  ) async {
    await openServers(tester);
    await tester.enterText(find.byType(TextField), 'Beta');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Beta'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Edit'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'Renamed Beta');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();
    expect(settings.state.servers[0], alpha);
    expect(settings.state.servers[1].name, 'Renamed Beta');
    expect(settings.state.servers[1].address, beta.address);
    expect(find.text('Renamed Beta'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('deleting a search result removes only that saved server', (
    tester,
  ) async {
    await openServers(tester);
    await tester.enterText(find.byType(TextField), 'Beta');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Beta'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Delete'));
    await tester.pumpAndSettle();
    expect(settings.state.servers, [alpha]);
    expect(find.widgetWithText(ListTile, 'Beta'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('public servers have no saved-server actions on mobile', (
    tester,
  ) async {
    final server = BrowsedGameServer(
      name: 'Public server',
      address: 'public.example.com',
    );
    await openServers(tester, discovered: [server], mobile: true);
    await tester.tap(find.text(server.display));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Edit'), findsNothing);
    expect(find.byTooltip('Delete'), findsNothing);
    expect(settings.state.servers, [alpha, beta]);
    expect(find.text('Play'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
  });
}
