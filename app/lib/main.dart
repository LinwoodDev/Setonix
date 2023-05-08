import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qeck/pages/game/page.dart';
import 'package:qeck/services/connection.dart';
import 'package:window_manager/window_manager.dart';

import 'cubits/settings.dart';
import 'logic/connection/client.dart';
import 'pages/home/page.dart';
import 'pages/settings/page.dart';
import 'setup.dart'
    if (dart.library.html) 'setup_web.dart'
    if (dart.library.io) 'setup_io.dart';
import 'theme.dart';

String? dataPath;

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  final prefs = await SharedPreferences.getInstance();
  final settingsCubit = SettingsCubit(prefs);

  await setup(settingsCubit);
  runApp(
    BlocProvider.value(
      value: settingsCubit,
      child: RepositoryProvider(
        create: (context) => ConnectionService(settingsCubit),
        child: FlowApp(),
      ),
    ),
  );
}

Page<void> Function(BuildContext, GoRouterState) _fadeTransitionBuilder(
    Widget Function(BuildContext, GoRouterState) child) {
  return (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: child(context, state),
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        ),
      );
}

class FlowApp extends StatelessWidget {
  FlowApp({super.key});

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
    return BlocBuilder<SettingsCubit, QeckSettings>(
        buildWhen: (previous, current) =>
            previous.design != current.design ||
            previous.themeMode != current.themeMode ||
            previous.locale != current.locale,
        builder: (context, state) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: _router,
              title: applicationName,
              theme: getThemeData(state.design, false, lightDynamic),
              darkTheme: getThemeData(state.design, true, darkDynamic),
              themeMode: state.themeMode,
              locale: state.locale.isEmpty ? null : Locale(state.locale),
              localizationsDelegates: const [
                ...AppLocalizations.localizationsDelegates,
                LeapLocalizations.delegate,
                LocaleNamesLocalizationsDelegate(),
              ],
              builder: virtualWindowFrameBuilder,
              supportedLocales: AppLocalizations.supportedLocales,
            ));
  }

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder:
            _fadeTransitionBuilder((context, state) => const HomePage()),
        routes: [
          GoRoute(
            path: 'game',
            pageBuilder: _fadeTransitionBuilder(
              (context, state) {
                if (state.extra is! ClientGameConnection) {
                  context.go('/');
                  return const SizedBox.shrink();
                }
                return GamePage(
                  connection: state.extra as ClientGameConnection,
                );
              },
            ),
          ),
          GoRoute(
            path: 'settings',
            pageBuilder: _fadeTransitionBuilder(
              (context, state) => const SettingsPage(),
            ),
          ),
        ],
      ),
    ],
  );
}

const flavor = String.fromEnvironment('flavor');
const isNightly =
    flavor == 'nightly' || flavor == 'dev' || flavor == 'development';
const shortApplicationName = isNightly ? 'Qeck Nightly' : 'Qeck';
const applicationName = 'Linwood $shortApplicationName';
