import 'package:flutter_modular/flutter_modular.dart';
import 'package:bits/pages/create/lobby.dart';
import 'package:bits/pages/home.dart';
import 'package:bits/pages/intro.dart';
import 'package:bits/pages/settings/module.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [];

  // Provide all the routes for your module
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => const HomePage()),
        ChildRoute("/intro", child: (_, __) => const IntroPage()),
        ModuleRoute("/settings", module: SettingsModule()),
        ChildRoute("/create", child: (_, __) => const CreateLobbyPage())
      ];
}
