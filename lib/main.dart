import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minigamesparty/colors.dart';
import 'package:minigamesparty/pages.dart';
import 'package:minigamesparty/pages/create.dart';
import 'package:minigamesparty/pages/home.dart';
import 'package:minigamesparty/pages/info.dart';
import 'package:minigamesparty/pages/intro.dart';
import 'package:minigamesparty/services/localization.dart';

Future<void> main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('pref');

  // GetIt.I.registerSingleton<Game>(GameModeManager());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en"), // English
          const Locale('de') // Deutsch
          // ... other locales the app supports
        ],
        title: 'Minigames Party',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            bottomAppBarColor: PaletteColors.colorCustom,
            primarySwatch: PaletteColors.colorCustom),
        routes: {
          RoutePages.home: (_) => HomePage(),
          RoutePages.create: (_) => CreatePage(),
          RoutePages.info: (_) => InfoPage(),
          RoutePages.intro: (_) => IntroPage()
        });
  }
}
