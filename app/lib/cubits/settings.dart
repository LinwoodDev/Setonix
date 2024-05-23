import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/widgets/window.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

part 'settings.mapper.dart';

@MappableClass()
class QuokkaSettings with QuokkaSettingsMappable {
  final String localeTag;
  final ThemeMode theme;
  final String design;
  final bool nativeTitleBar;

  const QuokkaSettings({
    this.localeTag = '',
    this.theme = ThemeMode.system,
    this.design = '',
    this.nativeTitleBar = false,
  });

  Locale? get locale {
    if (localeTag.isEmpty) {
      return null;
    }
    if (localeTag.contains('-')) {
      return Locale(localeTag.split('-')[0], localeTag.split('-')[1]);
    }
    return Locale(localeTag);
  }

  factory QuokkaSettings.fromPrefs(SharedPreferences prefs) => QuokkaSettings(
        theme: ThemeMode.values.byName(prefs.getString('theme') ?? 'system'),
        design: prefs.getString('design') ?? '',
        nativeTitleBar: prefs.getBool('nativeTitleBar') ?? false,
        localeTag: prefs.getString('locale') ?? '',
      );

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme.name);
    prefs.setString('design', design);
    prefs.setBool('nativeTitleBar', nativeTitleBar);
    prefs.setString('locale', localeTag);
  }
}

class SettingsCubit extends Cubit<QuokkaSettings> {
  SettingsCubit(SharedPreferences prefs)
      : super(QuokkaSettings.fromPrefs(prefs));

  Future<void> changeTheme(ThemeMode theme) {
    emit(state.copyWith(theme: theme));
    return save();
  }

  Future<void> changeDesign(String design) {
    emit(state.copyWith(design: design));
    return save();
  }

  void setNativeTitleBar([bool? value]) {
    if (kIsWeb || !isWindow) return;
    windowManager.setTitleBarStyle(
        (value ?? state.nativeTitleBar)
            ? TitleBarStyle.normal
            : TitleBarStyle.hidden,
        windowButtonVisibility: state.nativeTitleBar);
  }

  Future<void> changeNativeTitleBar(bool value, [bool modify = true]) {
    if (modify) setNativeTitleBar(value);
    emit(state.copyWith(nativeTitleBar: value));
    return save();
  }

  Future<void> changeLocale(Locale? locale) {
    emit(state.copyWith(localeTag: locale?.toLanguageTag() ?? ''));
    return save();
  }

  Future<void> save() => state.save();
}
