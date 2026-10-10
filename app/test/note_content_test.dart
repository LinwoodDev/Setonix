import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setonix/pages/game/note_content.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

void main() {
  testWidgets(
    'note buttons follow advertised action permissions across updates',
    (tester) async {
      final requests = <String>[];
      Widget content(bool enabled) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: GameNoteContent(
              content: '[Hit](action:hit) [Stand](action:stand) [Unknown](action:unknown)\n\n`[Code](action:hit)`',
              actions: [
                ToolbarAction(id: 'hit', label: 'Hit', enabled: enabled),
                const ToolbarAction(
                  id: 'stand',
                  label: 'Stand',
                  enabled: false,
                  showInToolbar: false,
                ),
              ],
              onAction: requests.add,
            ),
          ),
        ),
      );
      await tester.pumpWidget(content(true));
      await tester.pumpAndSettle();
      final hit = find.widgetWithText(FilledButton, 'Hit');
      final stand = find.widgetWithText(FilledButton, 'Stand');
      final unknown = find.widgetWithText(FilledButton, 'Unknown');
      expect(tester.widget<FilledButton>(hit).onPressed, isNotNull);
      expect(tester.widget<FilledButton>(stand).onPressed, isNull);
      expect(tester.widget<FilledButton>(unknown).onPressed, isNull);
      expect(find.byType(FilledButton), findsNWidgets(3));
      await tester.tap(hit);
      expect(requests, ['hit']);
      await tester.pumpWidget(content(false));
      await tester.pumpAndSettle();
      expect(tester.widget<FilledButton>(hit).onPressed, isNull);
      expect(tester.takeException(), isNull);
    },
  );
}
