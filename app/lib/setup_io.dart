import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:setonix/main.dart';
import 'package:window_manager/window_manager.dart';

import 'bloc/settings.dart';
import 'setup.dart' as general_setup;

Future<void> setup(SettingsCubit settingsCubit) async {
  setupFullScreen();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    final windowOptions = WindowOptions(
      minimumSize: const Size(420, 300),
      titleBarStyle: settingsCubit.state.nativeTitleBar
          ? TitleBarStyle.normal
          : TitleBarStyle.hidden,
      title: applicationName,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    await general_setup.setup(settingsCubit);
  }
}
