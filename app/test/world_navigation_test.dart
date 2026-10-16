import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/pages/home/create.dart';
import 'package:setonix/pages/home/header.dart';
import 'package:setonix/pages/home/play.dart';
import 'package:setonix/pages/home/recent.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix/widgets/game_mode.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _DataSystem extends Fake implements TypedKeyFileSystem<SetonixData> {
  final files = <FileSystemFile<SetonixData>>[];
  final savedPath = Completer<String>();
  SetonixData? savedData;

  @override
  Future<void> initialize({bool force = false}) async {}

  @override
  Future<List<FileSystemFile<SetonixData>>> getFiles() async => files;

  @override
  Stream<List<FileSystemFile<SetonixData>>> fetchFiles() => Stream.value(files);

  @override
  Future<String> createFile(String key, SetonixData data) {
    savedData = data;
    return savedPath.future;
  }
}

class _FileSystem extends Fake implements SetonixFileSystem {
  @override
  final _DataSystem worldSystem = _DataSystem();

  @override
  final _DataSystem templateSystem = _DataSystem();

  @override
  Future<Iterable<SetonixFile>> getPacks({
    bool fetchCore = true,
    bool force = false,
  }) async => [];
}

void main() {
  Widget app(GoRouter router, _FileSystem fileSystem) =>
      RepositoryProvider<SetonixFileSystem>.value(
        value: fileSystem,
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            LeapLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

  for (final customOnly in [false, true]) {
    testWidgets('creation opens the saved path (customOnly: $customOnly)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final fileSystem = _FileSystem();
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: TextButton(
                onPressed: () => showDialog<bool>(
                  context: context,
                  builder: (context) => CreateDialog(customOnly: customOnly),
                ),
                child: const Text('New world'),
              ),
            ),
          ),
          GoRoute(
            name: 'game',
            path: '/game/:name',
            builder: (context, state) =>
                Scaffold(body: Text('Opened: ${state.pathParameters['name']}')),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(app(router, fileSystem));
      await tester.tap(find.text('New world'));
      await tester.pumpAndSettle();

      expect(find.byType(CreateDialog), findsOneWidget);
      final create = find.descendant(
        of: find.byWidgetPredicate((widget) => widget is FilledButton),
        matching: find.text('Create'),
      );
      await tester.tap(create);
      await tester.pumpAndSettle();
      expect(fileSystem.worldSystem.savedData, isNull);

      await tester.enterText(find.byType(TextFormField).first, 'New world');
      await tester.tap(create);
      await tester.pump();
      expect(
        fileSystem.worldSystem.savedData?.getMetadata()?.name,
        'New world',
      );
      expect(router.routeInformationProvider.value.uri.path, '/');

      // Storage may choose a different key when the name already exists.
      fileSystem.worldSystem.savedPath.complete('New world (1)');
      await tester.pumpAndSettle();
      expect(find.text('Opened: New world (1)'), findsOneWidget);
      expect(find.byType(CreateDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  for (final width in [390.0, 1200.0]) {
    testWidgets('saved games are reachable from home at width $width', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      SharedPreferences.setMockInitialValues({});
      final settings = SettingsCubit(await SharedPreferences.getInstance());
      addTearDown(settings.close);
      final fileSystem = _FileSystem();
      fileSystem.worldSystem.files.add(
        FileSystemFile(
          const AssetLocation(path: 'My table'),
          data: SetonixData.empty().setMetadata(
            const FileMetadata(name: 'My table'),
          ),
        ),
      );
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: SingleChildScrollView(
                child: Column(children: [HeaderHomeView(), RecentHomeView()]),
              ),
            ),
          ),
          GoRoute(
            path: '/games',
            builder: (context, state) => const Scaffold(body: PlayView()),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        BlocProvider.value(value: settings, child: app(router, fileSystem)),
      );
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byType(HeaderHomeView),
          matching: find.byWidgetPredicate(
            (widget) => widget is ButtonStyleButton,
          ),
        ),
        findsNothing,
      );
      await tester.ensureVisible(find.byTooltip('Games'));
      await tester.tap(find.byTooltip('Games'));
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, '/games');
      await tester.tap(find.byType(GameModeTile));
      await tester.pumpAndSettle();
      expect(find.text('My table'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  }
}
