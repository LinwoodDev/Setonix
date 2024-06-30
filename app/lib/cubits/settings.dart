import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

part 'settings.mapper.dart';

@MappableClass()
class QuokkaSettings with QuokkaSettingsMappable implements LeapSettings {
  final String localeTag;
  final ThemeMode theme;
  final String design;
  final String dataDirectory;
  @override
  final bool nativeTitleBar;
  final bool showConnectOfficial, showConnectCustom, showConnectOnlyFavorites;

  const QuokkaSettings({
    this.localeTag = '',
    this.theme = ThemeMode.system,
    this.design = '',
    this.dataDirectory = '',
    this.nativeTitleBar = false,
    this.showConnectOfficial = true,
    this.showConnectCustom = true,
    this.showConnectOnlyFavorites = false,
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
        dataDirectory: prefs.getString('dataDirectory') ?? '',
        nativeTitleBar: prefs.getBool('nativeTitleBar') ?? false,
        localeTag: prefs.getString('locale') ?? '',
        showConnectOfficial: prefs.getBool('showConnectOfficial') ?? true,
        showConnectCustom: prefs.getBool('showConnectCustom') ?? true,
        showConnectOnlyFavorites:
            prefs.getBool('showConnectOnlyFavorites') ?? false,
      );

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme.name);
    await prefs.setString('design', design);
    await prefs.setString('dataDirectory', dataDirectory);
    await prefs.setBool('nativeTitleBar', nativeTitleBar);
    await prefs.setString('locale', localeTag);
    await prefs.setBool('showConnectOfficial', showConnectOfficial);
    await prefs.setBool('showConnectCustom', showConnectCustom);
    await prefs.setBool('showConnectOnlyFavorites', showConnectOnlyFavorites);
  }
}

class SettingsCubit extends Cubit<QuokkaSettings>
    with LeapSettingsBlocBaseMixin<QuokkaSettings> {
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

  Future<void> changeShowConnectOfficial(bool value) {
    emit(state.copyWith(showConnectOfficial: value));
    return save();
  }

  Future<void> changeShowConnectCustom(bool value) {
    emit(state.copyWith(showConnectCustom: value));
    return save();
  }

  Future<void> changeShowConnectOnlyFavorites(bool value) {
    emit(state.copyWith(showConnectOnlyFavorites: value));
    return save();
  }

  Future<void> save() => state.save();
}
