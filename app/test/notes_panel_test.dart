import 'dart:ui' show PointerDeviceKind;

import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setonix/pages/game/notes_panel.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

void main() {
  Widget reader(SetonixData data, {VoidCallback? onManage, String? homeNote}) =>
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SizedBox(
            width: 320,
            child: GameNotesReader(
              data: data,
              homeNote: homeNote,
              onClose: () {},
              onManage: onManage ?? () {},
            ),
          ),
        ),
      );

  testWidgets(
    'note links navigate to encoded names and missing links stay in the reader',
    (tester) async {
      final data = SetonixData.empty()
          .setNote(
            'Home',
            '[Read rules](note:Turn%20rules)\n\n[Missing](note:Deleted)',
          )
          .setNote('Turn rules', '[Back home](note:Home)');
      await tester.pumpWidget(reader(data, homeNote: 'Home'));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Missing', findRichText: true).last);
      await tester.pumpAndSettle();
      expect(find.text('Note ‘Deleted’ was not found.'), findsOneWidget);
      await tester.tap(
        find.textContaining('Read rules', findRichText: true).last,
      );
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Back home', findRichText: true),
        findsWidgets,
      );
      await tester.tap(
        find.textContaining('Back home', findRichText: true).last,
      );
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Read rules', findRichText: true),
        findsWidgets,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('follows score changes while keeping the selected note', (
    tester,
  ) async {
    var data = SetonixData.empty()
        .setNote('Blackjack', '# Round 1\n\nPlayer 1 is playing.')
        .setNote('Rules', '# Rules\n\nAces count as 1 or 11.');
    await tester.pumpWidget(reader(data));
    await tester.pumpAndSettle();
    expect(find.textContaining('Player 1 is playing.'), findsOneWidget);
    data = data.setNote('Blackjack', '# Round 1\n\nPlayer 2 is playing.');
    await tester.pumpWidget(reader(data));
    await tester.pumpAndSettle();
    expect(find.textContaining('Player 2 is playing.'), findsOneWidget);
    expect(find.textContaining('Player 1 is playing.'), findsNothing);
    await tester.tap(find.byType(DropdownMenu<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rules').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Aces count as 1 or 11.'), findsOneWidget);
    await tester.pumpWidget(reader(data.setNote('Blackjack', '# Round 2')));
    await tester.pumpAndSettle();
    expect(find.textContaining('Aces count as 1 or 11.'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets(
    'home page opens by default and remains accessible after selecting another note',
    (tester) async {
      var data = SetonixData.empty()
          .setNote('Alpha', 'Another note')
          .setNote('Welcome', 'Home content');
      await tester.pumpWidget(reader(data, homeNote: 'Welcome'));
      await tester.pumpAndSettle();
      expect(find.text('Home content'), findsOneWidget);
      await tester.tap(find.byType(DropdownMenu<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Alpha').last);
      await tester.pumpAndSettle();
      expect(find.text('Another note'), findsOneWidget);
      data = data.setNote('Welcome', 'Updated home content');
      await tester.pumpWidget(reader(data, homeNote: 'Welcome'));
      await tester.pumpAndSettle();
      expect(find.text('Another note'), findsOneWidget);
      await tester.tap(find.byTooltip('Home page'));
      await tester.pumpAndSettle();
      expect(find.text('Updated home content'), findsOneWidget);
      await tester.pumpWidget(
        reader(data.removeNote('Welcome'), homeNote: 'Welcome'),
      );
      await tester.pumpAndSettle();
      expect(find.text('Another note'), findsOneWidget);
      expect(find.byTooltip('Home page'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'selected note survives switching between sidebar and mobile sheet',
    (tester) async {
      tester.view.physicalSize = const Size(1100, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final readerKey = GlobalKey();
      final data = SetonixData.empty()
          .setNote('Alpha', 'Another note')
          .setNote('Welcome', 'Home content');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 900) {
                  return Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        width: 320,
                        child: GameNotesReader(
                          key: readerKey,
                          data: data,
                          homeNote: 'Welcome',
                          onClose: () {},
                          onManage: () {},
                        ),
                      ),
                    ],
                  );
                }
                return Stack(
                  children: [
                    Positioned.fill(
                      child: GameNotesSheet(
                        readerKey: readerKey,
                        data: data,
                        homeNote: 'Welcome',
                        onClose: () {},
                        onManage: () {},
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownMenu<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Alpha').last);
      await tester.pumpAndSettle();
      expect(find.text('Another note').hitTestable(), findsOneWidget);
      tester.view.physicalSize = const Size(390, 844);
      await tester.pumpAndSettle();
      final panel = find.byType(GameNotesReader);
      await tester.tapAt(tester.getTopLeft(panel) + const Offset(195, 12));
      await tester.pumpAndSettle();
      expect(find.text('Another note').hitTestable(), findsOneWidget);
      tester.view.physicalSize = const Size(1100, 800);
      await tester.pumpAndSettle();
      expect(find.text('Another note').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'notes management stays available after the last note is removed',
    (tester) async {
      var manageRequests = 0;
      final data = SetonixData.empty().setNote('Rules', 'Follow the round.');
      await tester.pumpWidget(reader(data, onManage: () => manageRequests++));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Manage notes'));
      expect(manageRequests, 1);
      await tester.pumpWidget(
        reader(SetonixData.empty(), onManage: () => manageRequests++),
      );
      await tester.pumpAndSettle();
      expect(find.byTooltip('Manage notes').hitTestable(), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, 'Manage notes'));
      expect(manageRequests, 2);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'mobile notes stay available after swiping down and can be disabled',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var enabled = true;
      var boardTaps = 0;
      var data = SetonixData.empty().setNote('Round', 'Player 1 is playing.');
      Widget mobile() => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: StatefulBuilder(
          builder: (context, setState) => Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                  key: const ValueKey('toggle-notes'),
                  onPressed: () => setState(() => enabled = !enabled),
                  child: const Text('Toggle notes'),
                ),
              ],
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    key: const ValueKey('board'),
                    onPressed: () => boardTaps++,
                    child: const Text('Board'),
                  ),
                ),
                if (enabled)
                  Positioned.fill(
                    child: GameNotesSheet(
                      data: data,
                      onClose: () => setState(() => enabled = false),
                      onManage: () {},
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
      final panel = find.byType(GameNotesReader);
      await tester.pumpWidget(mobile());
      await tester.pumpAndSettle();
      final collapsedHeight = tester.getSize(panel).height;
      expect(collapsedHeight, closeTo(GameNotesSheet.collapsedHeight, 1));
      await tester.tap(find.byKey(const ValueKey('board')));
      expect(boardTaps, 1);
      await tester.dragFrom(
        tester.getTopLeft(panel) + const Offset(60, 52),
        const Offset(0, -350),
      );
      await tester.pumpAndSettle();
      final expandedHeight = tester.getSize(panel).height;
      expect(expandedHeight, greaterThan(collapsedHeight + 150));
      expect(
        find.textContaining('Player 1 is playing.').hitTestable(),
        findsOneWidget,
      );
      data = data.setNote('Round', 'Player 2 is playing.');
      await tester.pumpWidget(mobile());
      await tester.pumpAndSettle();
      expect(tester.getSize(panel).height, expandedHeight);
      expect(
        find.textContaining('Player 2 is playing.').hitTestable(),
        findsOneWidget,
      );
      await tester.dragFrom(
        tester.getTopLeft(panel) + const Offset(195, 12),
        const Offset(0, 700),
      );
      await tester.pumpAndSettle();
      expect(tester.getSize(panel).height, closeTo(collapsedHeight, 1));
      await tester.tap(find.byTooltip('Close'));
      await tester.pumpAndSettle();
      expect(find.byType(GameNotesSheet), findsNothing);
      await tester.tap(find.byKey(const ValueKey('toggle-notes')));
      await tester.pumpAndSettle();
      expect(tester.getSize(panel).height, closeTo(collapsedHeight, 1));
      await tester.tap(find.byKey(const ValueKey('toggle-notes')));
      await tester.pumpAndSettle();
      expect(find.byType(GameNotesSheet), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('expanded mobile notes scroll through long content', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final data = SetonixData.empty().setNote(
      'Rules',
      List.generate(
        60,
        (index) => 'Rule $index: Follow the round.',
      ).join('\n\n'),
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: GameNotesSheet(
                  data: data,
                  onClose: () {},
                  onManage: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final panel = find.byType(GameNotesReader);
    await tester.dragFrom(
      tester.getTopLeft(panel) + const Offset(195, 12),
      const Offset(0, -700),
    );
    await tester.pumpAndSettle();
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -4000));
    await tester.pumpAndSettle();
    expect(find.textContaining('Rule 59:').hitTestable(), findsOneWidget);
    expect(find.byTooltip('Manage notes').hitTestable(), findsOneWidget);
    expect(find.byTooltip('Close').hitTestable(), findsOneWidget);
    await tester.tapAt(tester.getTopLeft(panel) + const Offset(195, 12));
    await tester.pumpAndSettle();
    expect(
      tester.getSize(panel).height,
      closeTo(GameNotesSheet.collapsedHeight, 1),
    );
    expect(find.byTooltip('Manage notes').hitTestable(), findsOneWidget);
    expect(find.byTooltip('Close').hitTestable(), findsOneWidget);

    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('empty mobile notes can expand with a bottom safe area', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(640, 320);
    tester.view.devicePixelRatio = 1;
    tester.view.padding = FakeViewPadding(bottom: 24);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPadding);
    var manageRequests = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: GameNotesSheet(
                  data: SetonixData.empty(),
                  onClose: () {},
                  onManage: () => manageRequests++,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final panel = find.byType(GameNotesReader);
    expect(
      tester.getSize(panel).height,
      closeTo(GameNotesSheet.collapsedHeight, 1),
    );
    await tester.tap(find.byTooltip('Manage notes'));
    expect(manageRequests, 1);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(
      location: tester.getTopLeft(panel) + const Offset(320, 12),
    );
    await mouse.down(tester.getTopLeft(panel) + const Offset(320, 12));
    await mouse.moveBy(const Offset(0, -50));
    await tester.pump(const Duration(milliseconds: 100));
    await mouse.moveBy(const Offset(0, -100));
    await mouse.up();
    await mouse.removePointer();
    await tester.pumpAndSettle();
    expect(
      tester.getSize(panel).height,
      greaterThan(GameNotesSheet.collapsedHeight),
    );
    await tester.tapAt(tester.getTopLeft(panel) + const Offset(320, 12));
    await tester.pumpAndSettle();
    expect(
      tester.getSize(panel).height,
      closeTo(GameNotesSheet.collapsedHeight, 1),
    );
    await tester.dragFrom(
      tester.getTopLeft(panel) + const Offset(320, 12),
      const Offset(0, -200),
    );
    await tester.pumpAndSettle();
    expect(
      tester.getSize(panel).height,
      greaterThan(GameNotesSheet.collapsedHeight),
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Manage notes'));
    expect(manageRequests, 2);
    expect(tester.takeException(), isNull);
  });
}
