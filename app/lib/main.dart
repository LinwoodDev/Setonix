import 'package:args/args.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:quokka/pages/board/page.dart';
import 'package:quokka/pages/home/page.dart';
import 'package:quokka/pages/settings/general.dart';
import 'package:quokka/pages/settings/personalization.dart';
import 'package:quokka/services/network.dart';
import 'package:quokka/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:window_manager/window_manager.dart';

import 'cubits/settings.dart';
import 'pages/settings/page.dart';

import 'setup.dart'
    if (dart.library.html) 'setup_web.dart'
    if (dart.library.io) 'setup_io.dart';

String? dataPath;

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  final argParser = ArgParser();
  argParser.addOption('path', abbr: 'p');
  final result = argParser.parse(args);
  dataPath = result['path'];

  final prefs = await SharedPreferences.getInstance();
  final settingsCubit = SettingsCubit(prefs);

  await setup(settingsCubit);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: settingsCubit),
        BlocProvider.value(
            value: WindowCubit(fullScreen: await isFullScreen())),
      ],
      child: RepositoryProvider(
        create: (context) => NetworkingService(settingsCubit),
        child: QuokkaApp(),
      ),
    ),
  );
}

const kUnsupportedLanguages = [];

List<Locale> getLocales() =>
    List<Locale>.from(AppLocalizations.supportedLocales)
        .where((l) => !kUnsupportedLanguages.contains(l.toString()))
        .toList();

class QuokkaApp extends StatelessWidget {
  QuokkaApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return _buildApp(null, null);
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) =>
          _buildApp(lightDynamic, darkDynamic),
    );
  }

  Widget _buildApp(ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    return BlocBuilder<SettingsCubit, QuokkaSettings>(
        buildWhen: (previous, current) =>
            previous.design != current.design ||
            previous.theme != current.theme ||
            previous.locale != current.locale,
        builder: (context, state) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: _router,
              title: applicationName,
              theme: getThemeData(state.design, false, lightDynamic),
              darkTheme: getThemeData(state.design, true, darkDynamic),
              themeMode: state.theme,
              locale: state.localeTag.isEmpty ? null : Locale(state.localeTag),
              localizationsDelegates: const [
                ...AppLocalizations.localizationsDelegates,
                LeapLocalizations.delegate,
                LocaleNamesLocalizationsDelegate(),
              ],
              builder: (context, child) {
                if (!state.nativeTitleBar) {
                  child = virtualWindowFrameBuilder(context, child);
                }
                return child ?? Container();
              },
              supportedLocales: AppLocalizations.supportedLocales,
            ));
  }

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'board',
            builder: (context, state) => BoardPage(),
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsPage(),
            routes: [
              GoRoute(
                path: 'general',
                builder: (context, state) => const GeneralSettingsPage(),
              ),
              GoRoute(
                path: 'personalization',
                builder: (context, state) =>
                    const PersonalizationSettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

const flavor = String.fromEnvironment('flavor');
const isNightly =
    flavor == 'nightly' || flavor == 'dev' || flavor == 'development';
const shortApplicationName = isNightly ? 'Quokka Nightly' : 'Quokka';
const applicationName = 'Linwood $shortApplicationName';
const applicationMinorVersion = '1.0';
