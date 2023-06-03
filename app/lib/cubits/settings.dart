import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.freezed.dart';

@freezed
class QeckSettings with _$QeckSettings {
  const QeckSettings._();

  const factory QeckSettings({
    @Default('') String localeTag,
    @Default(ThemeMode.system) ThemeMode theme,
    @Default('') String design,
    @Default(false) bool nativeTitleBar,
  }) = _FlowSettings;

  Locale? get locale {
    if (localeTag.isEmpty) {
      return null;
    }
    if (localeTag.contains('-')) {
      return Locale(localeTag.split('-')[0], localeTag.split('-')[1]);
    }
    return Locale(localeTag);
  }

  factory QeckSettings.fromPrefs(SharedPreferences prefs) => QeckSettings(
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

class SettingsCubit extends Cubit<QeckSettings> {
  SettingsCubit(SharedPreferences prefs) : super(QeckSettings.fromPrefs(prefs));

  Future<void> changeTheme(ThemeMode theme) {
    emit(state.copyWith(theme: theme));
    return save();
  }

  Future<void> changeDesign(String design) {
    emit(state.copyWith(design: design));
    return save();
  }

  Future<void> changeNativeTitleBar(bool nativeTitleBar) {
    emit(state.copyWith(nativeTitleBar: nativeTitleBar));
    return save();
  }

  Future<void> changeLocale(Locale? locale) {
    emit(state.copyWith(localeTag: locale?.toLanguageTag() ?? ''));
    return save();
  }

  Future<void> save() => state.save();
}
