import 'package:flutter_modular/flutter_modular.dart';
import 'package:town/pages/settings/home.dart';

import 'appearance.dart';
import 'info.dart';

class SettingsModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => const SettingsPage()),
        ChildRoute("/appearance",
            child: (_, __) => const AppearanceSettingsPage()),
        ChildRoute("/info", child: (_, __) => const InfoSettingsPage())
      ];
}
