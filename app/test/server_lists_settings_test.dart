import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/pages/settings/servers.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SettingsCubit settings;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    settings = SettingsCubit(prefs);
  });
  tearDown(() => settings.close());

  Future<void> openAddDialog(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider.value(
        value: settings,
        child: MaterialApp(
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            LeapLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ServersSettingsPage(inView: true),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
  }

  testWidgets('asks for a URL and persists the normalized HTTPS address', (
    tester,
  ) async {
    await openAddDialog(tester);
    expect(find.text('Server lists'), findsOneWidget);
    expect(find.text('Add server list'), findsOneWidget);
    expect(find.text('Enter a name'), findsNothing);
    expect(find.text('https://example.com/servers.json'), findsOneWidget);
    await tester.enterText(
      find.byType(TextFormField),
      '  example.com/servers.json?lang=en  ',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
    await tester.pumpAndSettle();
    const address = 'https://example.com/servers.json?lang=en';
    expect(settings.state.serverList, [address]);
    expect(prefs.getStringList('serverList'), [address]);
    expect(find.text(address), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('invalid URLs show an error without closing or saving', (
    tester,
  ) async {
    await openAddDialog(tester);
    for (final value in [
      '',
      'ftp://example.com/servers.json',
      'https://',
      'not a url',
    ]) {
      await tester.enterText(find.byType(TextFormField), value);
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsOneWidget, reason: value);
      expect(
        find.text('Enter a valid HTTP or HTTPS URL.'),
        findsOneWidget,
        reason: value,
      );
      expect(settings.state.serverList, isEmpty, reason: value);
    }
    await tester.enterText(
      find.byType(TextFormField),
      'http://localhost:8080/servers.json',
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(settings.state.serverList, ['http://localhost:8080/servers.json']);
    expect(tester.takeException(), isNull);
  });
}
