import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:setonix/pages/game/page.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';

void main() {
  testWidgets(
    'an invalid address shows a retryable error instead of loading forever',
    (tester) async {
      final router = GoRouter(
        initialLocation: '/connect',
        routes: [
          GoRoute(path: '/', builder: (_, _) => const Text('Home screen')),
          GoRoute(
            path: '/connect',
            builder: (_, _) => const GamePage(address: ''),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(
        find.textContaining('A server address must include a host.'),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await tester.tap(find.text('Reconnect'));
      await tester.pump();
      await tester.pump();
      expect(
        find.textContaining('A server address must include a host.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Home screen'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
}
