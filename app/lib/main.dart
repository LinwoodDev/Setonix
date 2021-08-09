import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linwood_city/models/server.dart';

import 'app_module.dart';
import 'app_widget.dart';

Future<void> main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('pref');
  Hive.registerAdapter(ServerAdapter());

  // GetIt.I.registerSingleton<Game>(GameModeManager());

  runApp(ModularApp(module: AppModule(), child: const CityApp()));
}
