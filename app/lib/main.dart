import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubits/settings.dart';
import 'pages/create/lobby.dart';
import 'pages/home.dart';
import 'pages/intro.dart';
import 'pages/settings/appearance.dart';
import 'pages/settings/home.dart';
import 'pages/settings/info.dart';
import 'setup.dart'
    if (dart.library.html) 'setup_web.dart'
    if (dart.library.io) 'setup_io.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  final prefs = await SharedPreferences.getInstance();
  final settingsCubit = SettingsCubit(prefs);
  await setup(settingsCubit);
  runApp(
    BlocProvider.value(
      value: settingsCubit,
      child: TownApp(),
    ),
  );
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

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return _buildApp(null, null);
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) =>
          _buildApp(lightDynamic, darkDynamic),
    );
  }

  Widget _buildApp(ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    return BlocBuilder<SettingsCubit, TownSettings>(
        buildWhen: (previous, current) =>
            previous.design != current.design ||
            previous.themeMode != current.themeMode ||
            previous.locale != current.locale,
        builder: (context, state) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: _router,
              title: isNightly ? 'Linwood Town Nightly' : 'Linwood Town',
              theme: getThemeData(state.design, false, lightDynamic),
              darkTheme: getThemeData(state.design, true, darkDynamic),
              themeMode: state.themeMode,
              locale: state.locale.isEmpty ? null : Locale(state.locale),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
            ));
  }
}

const flavor = String.fromEnvironment('flavor');
const isNightly =
    flavor == 'nightly' || flavor == 'dev' || flavor == 'development';
