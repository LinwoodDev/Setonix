import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/material_leap.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/pages/game/notes.dart';
import 'package:setonix/pages/game/note.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

class _FileSystem implements SetonixFileSystem {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Network implements NetworkService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _World extends WorldBloc {
  final requests = <WorldEvent>[];

  _World(MultiplayerCubit multiplayer, SetonixData data)
    : super(
        multiplayer: multiplayer,
        data: data,
        colorScheme: ThemeData().colorScheme,
        fileSystem: _FileSystem(),
      );

  void setEditable(bool editable) => emit(
    state.copyWith(
      world: state.world.copyWith(toolbar: GameToolbar(editable: editable)),
    ),
  );

  @override
  Future<void> process(WorldEvent event) async {
    requests.add(event);
    if (event is ServerWorldEvent) {
      final result = processServerEvent(
        event,
        state.world,
        signature: const [],
      );
      if (result.state != null) emit(state.copyWith(world: result.state));
    }
  }

  @override
  Future<void> save({bool collectScriptState = true}) async {}
}

void main() {
  late MultiplayerCubit multiplayer;
  late _World world;
  setUp(() {
    multiplayer = MultiplayerCubit(_Network());
    world = _World(multiplayer, SetonixData.empty());
  });
  tearDown(() async {
    await world.close();
    await multiplayer.close();
  });

  Widget app(Widget child) => BlocProvider<WorldBloc>.value(
    value: world,
    child: MaterialApp(
      localizationsDelegates: [
        ...AppLocalizations.localizationsDelegates,
        LeapLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );

  testWidgets(
    'empty manager creates a home page, edits it with an M3 menu and deletes it',
    (tester) async {
      await tester.pumpWidget(app(const GameNotesDialog()));
      await tester.pumpAndSettle();
      expect(find.text('No notes yet'), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, 'Create note'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, 'Welcome');
      await tester.enterText(find.byType(TextFormField).last, 'First draft');
      await tester.tap(find.byType(CheckboxListTile));
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();
      expect(world.state.data.getNote('Welcome'), 'First draft');
      expect(world.state.info.homeNote, 'Welcome');
      expect(find.text('Home page'), findsOneWidget);
      expect(find.byType(MenuAnchor), findsOneWidget);
      expect(find.byType(PopupMenuButton), findsNothing);
      await tester.tap(find.byTooltip('Manage notes'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(MenuItemButton, 'Edit'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'Updated draft');
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();
      expect(world.state.data.getNote('Welcome'), 'Updated draft');
      await tester.tap(find.byTooltip('Manage notes'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(MenuItemButton, 'Delete'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await tester.pumpAndSettle();
      expect(world.state.data.getNotes(), isEmpty);
      expect(world.state.info.homeNote, isNull);
      expect(find.text('No notes yet'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'read-only modes allow reading and links but disable note mutations',
    (tester) async {
      await world.process(NoteChanged('Blackjack', '[Read rules](note:Rules)'));
      await world.process(NoteChanged('Rules', 'Rules content'));
      world.requests.clear();
      world.setEditable(false);
      await tester.pumpWidget(app(const GameNotesDialog()));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Create note'),
            )
            .onPressed,
        isNull,
      );
      expect(find.byType(MenuAnchor), findsNothing);
      await tester.tap(find.text('Blackjack'));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNothing);
      expect(find.text('Save'), findsNothing);
      await tester.tap(
        find.textContaining('Read rules', findRichText: true).last,
      );
      await tester.pumpAndSettle();
      expect(find.text('Rules content'), findsOneWidget);
      expect(world.requests, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'locking the game while an editor is open removes editing controls',
    (tester) async {
      await world.process(NoteChanged('Rules', 'Original'));
      world.requests.clear();
      await tester.pumpWidget(
        app(const GameNoteDialog(note: 'Rules', edit: true)),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'Unsaved');
      world.setEditable(false);
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNothing);
      expect(find.text('Save'), findsNothing);
      expect(world.state.data.getNote('Rules'), 'Original');
      expect(world.requests, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );
}
