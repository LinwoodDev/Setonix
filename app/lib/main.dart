import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:town/models/server.dart';
import 'package:town/services/localization.dart';

import 'colors.dart';
import 'pages/create/lobby.dart';
import 'pages/home.dart';
import 'pages/intro.dart';
import 'pages/settings/appearance.dart';
import 'pages/settings/home.dart';
import 'pages/settings/info.dart';

Future<void> main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('pref');
  Hive.registerAdapter(ServerAdapter());

  // GetIt.I.registerSingleton<Game>(GameModeManager());

  runApp(TownApp());
}

class TownApp extends StatelessWidget {
  TownApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(routes: <GoRoute>[
    GoRoute(path: '/', builder: (_, __) => const HomePage(), routes: [
      GoRoute(
        path: 'intro',
        builder: (_, __) => const IntroPage(),
      ),
      GoRoute(
          path: 'settings',
          builder: (_, __) => const SettingsPage(),
          routes: [
            GoRoute(
              path: "appearance",
              builder: (_, __) => const AppearanceSettingsPage(),
            ),
            GoRoute(
              path: "info",
              builder: (_, __) => const InfoSettingsPage(),
            )
          ]),
      GoRoute(
        path: 'create',
        builder: (_, __) => const CreateLobbyPage(),
      ),
    ]),
  ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en"), // English
          Locale('de') // Deutsch
          // ... other locales the app supports
        ],
        title: 'Linwood Town',
        theme: ThemeData(
            useMaterial3: true,
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: PaletteColors.primaryPalette));
  }
}
