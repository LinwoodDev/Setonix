import 'package:flutter_modular/flutter_modular.dart';
import 'package:linwood_city/pages/settings/home.dart';

import 'appearance.dart';
import 'info.dart';

class SettingsModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => SettingsPage()),
        ChildRoute("/appearance", child: (_, __) => AppearanceSettingsPage()),
        ChildRoute("/info", child: (_, __) => InfoSettingsPage())
      ];
}
