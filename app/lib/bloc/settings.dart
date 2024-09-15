import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

part 'settings.mapper.dart';

@MappableClass()
class QuokkaSettings with QuokkaSettingsMappable implements LeapSettings {
  final String localeTag;
  final ThemeMode theme;
  final String design;
  final String dataDirectory;
  final String? lastVersion;
  @override
  final bool nativeTitleBar;
  final bool showConnectYour, showConnectNetwork;
  final GameProperty gameProperty;
  final List<ListGameServer> servers;
  final bool highContrast;

  const QuokkaSettings({
    this.localeTag = '',
    this.theme = ThemeMode.system,
    this.design = '',
    this.dataDirectory = '',
    this.nativeTitleBar = false,
    this.showConnectYour = true,
    this.showConnectNetwork = true,
    this.lastVersion,
    this.gameProperty = const GameProperty(),
    this.servers = const [],
    this.highContrast = false,
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
        showConnectYour: prefs.getBool('showConnectYour') ?? true,
        showConnectNetwork: prefs.getBool('showConnectNetwork') ?? true,
        lastVersion: prefs.getString('lastVersion'),
        gameProperty: prefs.containsKey('gameProperty')
            ? GamePropertyMapper.fromJson(prefs.getString('gameProperty')!)
            : GameProperty.defaultProperty,
        servers: prefs
                .getStringList('servers')
                ?.map((e) => ListGameServerMapper.fromJson(e))
                .toList() ??
            [],
        highContrast: prefs.getBool('highContrast') ?? false,
      );

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme.name);
    await prefs.setString('design', design);
    await prefs.setString('dataDirectory', dataDirectory);
    await prefs.setBool('nativeTitleBar', nativeTitleBar);
    await prefs.setString('locale', localeTag);
    await prefs.setBool('showConnectYour', showConnectYour);
    await prefs.setBool('showConnectNetwork', showConnectNetwork);
    if (lastVersion == null) {
      if (prefs.containsKey('last_version')) {
        await prefs.remove('last_version');
      }
    } else {
      await prefs.setString('last_version', lastVersion!);
    }
    await prefs.setString('gameProperty', gameProperty.toJson());
    await prefs.setStringList(
        'servers', servers.map((e) => e.toJson()).toList());
    await prefs.setBool('highContrast', highContrast);
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

  Future<void> changeShowConnectNetwork(bool value) {
    emit(state.copyWith(showConnectNetwork: value));
    return save();
  }

  Future<void> changeShowConnectYour(bool value) {
    emit(state.copyWith(showConnectYour: value));
    return save();
  }

  Future<void> updateLastVersion() async {
    final info = await PackageInfo.fromPlatform();

    emit(state.copyWith(lastVersion: info.version));
    return save();
  }

  Future<void> save() => state.save();

  Future<bool> hasNewerVersion() async {
    final info = await PackageInfo.fromPlatform();
    return state.lastVersion != info.version;
  }

  Future<void> changeDataDirectory(String newPath) {
    emit(state.copyWith(dataDirectory: newPath));
    return save();
  }

  Future<void> changeGameProperty(GameProperty property) {
    emit(state.copyWith(gameProperty: property));
    return save();
  }

  Future<void> addServer(ListGameServer server) {
    emit(state.copyWith.servers.add(server));
    return save();
  }

  Future<void> updateServer(int index, ListGameServer server) {
    emit(state.copyWith.servers.replace(index, server));
    return save();
  }

  Future<void> removeServer(int index) {
    emit(state.copyWith.servers.removeAt(index));
    return save();
  }

  Future<void> changeHighContrast(bool value) {
    emit(state.copyWith(highContrast: value));
    return save();
  }
}
