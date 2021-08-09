import 'package:flutter_modular/flutter_modular.dart';
import 'package:linwood_city/pages/create/lobby.dart';
import 'package:linwood_city/pages/home.dart';
import 'package:linwood_city/pages/intro.dart';
import 'package:linwood_city/pages/settings/module.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [];

  // Provide all the routes for your module
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => HomePage()),
        ChildRoute("/intro", child: (_, __) => IntroPage()),
        ModuleRoute("/settings", module: SettingsModule()),
        ChildRoute("/create", child: (_, __) => CreateLobbyPage())
      ];
}
