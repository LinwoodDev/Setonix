import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setonix/pages/game/notes_panel.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

void main() {
  Widget reader(SetonixData data) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: SizedBox(
        width: 320,
        child: GameNotesReader(data: data, onClose: () {}, onManage: () {}),
      ),
    ),
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
    await tester.tap(find.byType(DropdownButtonFormField<String>));
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
}
