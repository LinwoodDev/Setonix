import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/// provides the currently selected theme, saves changed theme preferences to disk
class ThemeController extends ChangeNotifier {
  static const themePrefKey = 'theme';

  String? get currentTheme =>
      Hive.box("settings").get(themePrefKey, defaultValue: "system") as String?;

  set currentTheme(String? value) {
    Hive.box("settings").put(themePrefKey, value);
    notifyListeners();
  }

  set currentThemeMode(ThemeMode? themeMode) => currentTheme = themeMode?.name;

  ThemeMode? get currentThemeMode => ThemeMode.values.byName(currentTheme!);

  /// get the controller from any page of your app
  static ThemeController? of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ThemeControllerProvider>()!;
    return provider.controller;
  }
}

/// provides the theme controller to any page of your app
class ThemeControllerProvider extends InheritedWidget {
  const ThemeControllerProvider(
      {Key? key, this.controller, required Widget child})
      : super(key: key, child: child);

  final ThemeController? controller;

  @override
  bool updateShouldNotify(ThemeControllerProvider oldWidget) =>
      controller != oldWidget.controller;
}

extension ThemeModeIndex on ThemeMode {
  // Overload the [] getter to get the name of the fruit.
  operator [](String key) =>
      ThemeMode.values.firstWhere((e) => e.toString() == 'ThemeMode.$key');
}
