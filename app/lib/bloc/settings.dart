import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

part 'settings.mapper.dart';

@MappableEnum()
enum ThemeDensity {
  system,
  maximize,
  desktop,
  compact,
  comfortable,
  standard;

  VisualDensity toFlutter() => switch (this) {
    ThemeDensity.maximize => const VisualDensity(horizontal: -4, vertical: -4),
    ThemeDensity.desktop => const VisualDensity(horizontal: -3, vertical: -3),
    ThemeDensity.compact => VisualDensity.compact,
    ThemeDensity.comfortable => VisualDensity.comfortable,
    ThemeDensity.standard => VisualDensity.standard,
    ThemeDensity.system => VisualDensity.adaptivePlatformDensity,
  };
}

List<String> getDefaultServerList() {
  const env = String.fromEnvironment('server_list', defaultValue: '');
  if (env.isNotEmpty) {
    return env.split(',').map((e) => e.trim()).toList();
  }
  return ['https://servers.setonix.linwood.dev/data.json'];
}

final class ThemeModeMapper extends SimpleMapper<ThemeMode> {
  const ThemeModeMapper();

  @override
  ThemeMode decode(Object value) {
    return ThemeMode.values.byName(value.toString());
  }

  @override
  String encode(ThemeMode value) {
    return value.name;
  }
}

final class UriMapper extends SimpleMapper<Uri> {
  const UriMapper();

  @override
  Uri decode(Object value) {
    return Uri.parse(value.toString());
  }

  @override
  String encode(Uri value) {
    return value.toString();
  }
}

@MappableClass(includeCustomMappers: [UriMapper()])
final class RecentGameEntry with RecentGameEntryMappable {
  final String name;
  final Uri location;
  final DateTime? lastPlayed;

  const RecentGameEntry({
    required this.name,
    required this.location,
    required this.lastPlayed,
  });

  bool get isMultiplayer => location.hasScheme && !location.isScheme('file');
}

const kRecentHistorySize = 10;

@MappableClass(includeCustomMappers: [ThemeModeMapper()])
class SetonixSettings with SetonixSettingsMappable implements LeapSettings {
  final String localeTag;
  final ThemeMode theme;
  final String design;
  final String dataDirectory;
  final String? lastVersion;
  @override
  final bool nativeTitleBar;
  final bool stackedCards;
  final bool showConnectYour, showConnectBrowse;
  final GameProperty gameProperty;
  final List<ListGameServer> servers;
  final double zoom;
  final bool highContrast;
  final List<String> swamps;
  final double scrollSensitivity;
  final ThemeDensity density;
  final List<String> serverList;
  final bool showIntro;
  final List<RecentGameEntry> recentGames;

  const SetonixSettings({
    this.localeTag = '',
    this.theme = ThemeMode.system,
    this.design = '',
    this.dataDirectory = '',
    this.nativeTitleBar = false,
    this.showConnectYour = true,
    this.showConnectBrowse = false,
    this.lastVersion,
    this.gameProperty = const GameProperty(),
    this.servers = const [],
    this.stackedCards = true,
    this.highContrast = false,
    this.zoom = 1,
    this.swamps = const [],
    this.density = ThemeDensity.system,
    this.scrollSensitivity = 1,
    this.serverList = const [],
    this.showIntro = true,
    this.recentGames = const [],
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

  factory SetonixSettings.fromPrefs(SharedPreferences prefs) => SetonixSettings(
    theme: ThemeMode.values.byName(prefs.getString('theme') ?? 'system'),
    design: prefs.getString('design') ?? '',
    dataDirectory: prefs.getString('dataDirectory') ?? '',
    nativeTitleBar: prefs.getBool('nativeTitleBar') ?? false,
    localeTag: prefs.getString('locale') ?? '',
    showConnectYour: prefs.getBool('showConnectYour') ?? true,
    showConnectBrowse: prefs.getBool('showConnectBrowse') ?? false,
    lastVersion: prefs.getString('lastVersion'),
    gameProperty: prefs.containsKey('gameProperty')
        ? GamePropertyMapper.fromJson(prefs.getString('gameProperty')!)
        : GameProperty.defaultProperty,
    servers:
        prefs
            .getStringList('servers')
            ?.map((e) => ListGameServerMapper.fromJson(e))
            .toList() ??
        [],
    highContrast: prefs.getBool('highContrast') ?? false,
    zoom: prefs.getDouble('zoom') ?? 1,
    swamps: prefs.getStringList('swamps') ?? [],
    scrollSensitivity: prefs.getDouble('scrollSensitivity') ?? 1,
    stackedCards: prefs.getBool('stackedCards') ?? true,
    density: ThemeDensity.values.byName(
      prefs.getString('density') ?? ThemeDensity.system.name,
    ),
    serverList: prefs.getStringList('serverList') ?? [],
    showIntro: prefs.getBool('showIntro') ?? true,
    recentGames:
        prefs
            .getStringList('recentGames')
            ?.map((e) => RecentGameEntryMapper.fromJson(e))
            .toList() ??
        [],
  );

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme.name);
    await prefs.setString('design', design);
    await prefs.setString('dataDirectory', dataDirectory);
    await prefs.setBool('nativeTitleBar', nativeTitleBar);
    await prefs.setString('locale', localeTag);
    await prefs.setBool('showConnectYour', showConnectYour);
    await prefs.setBool('showConnectBrowse', showConnectBrowse);
    if (lastVersion == null) {
      if (prefs.containsKey('last_version')) {
        await prefs.remove('last_version');
      }
    } else {
      await prefs.setString('last_version', lastVersion!);
    }
    await prefs.setBool('stackedCards', stackedCards);
    await prefs.setString('gameProperty', gameProperty.toJson());
    await prefs.setStringList(
      'servers',
      servers.map((e) => e.toJson()).toList(),
    );
    await prefs.setBool('highContrast', highContrast);
    await prefs.setDouble('zoom', zoom);
    await prefs.setStringList('swamps', swamps);
    await prefs.setDouble('scrollSensitivity', scrollSensitivity);
    await prefs.setString('density', density.name);
    await prefs.setStringList('serverList', serverList);
    await prefs.setBool('showIntro', showIntro);
    await prefs.setStringList(
      'recentGames',
      recentGames.map((e) => e.toJson()).toList(),
    );
  }
}

class SettingsCubit extends Cubit<SetonixSettings>
    with LeapSettingsBlocBaseMixin<SetonixSettings> {
  SettingsCubit(SharedPreferences prefs)
    : super(SetonixSettings.fromPrefs(prefs));

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
      windowButtonVisibility: state.nativeTitleBar,
    );
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

  Future<void> changeShowConnectBrowse(bool value) {
    emit(state.copyWith(showConnectBrowse: value));
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

  Future<void> zoomIn([double value = 0.1]) {
    emit(state.copyWith(zoom: (state.zoom + value).clamp(0.4, 2)));
    return save();
  }

  Future<void> zoomOut([double value = 0.1]) => zoomIn(-value);

  Future<void> resetZoom([double value = 1]) {
    emit(state.copyWith(zoom: value.clamp(0.4, 2)));
    return save();
  }

  Future<void> changeSwamp(String swamp) {
    emit(state.copyWith(swamps: [swamp]));
    return save();
  }

  Future<void> changeScrollSensitivity(double value) {
    emit(state.copyWith(scrollSensitivity: value));
    return save();
  }

  Future<void> changeDensity(ThemeDensity value) {
    emit(state.copyWith(density: value));
    return save();
  }

  Future<void> changeStackedCards(bool value) {
    emit(state.copyWith(stackedCards: value));
    return save();
  }

  Future<void> addServersToList(List<String> server, [bool reset = false]) {
    final newList = {if (!reset) ...state.serverList, ...server}.toList();
    emit(state.copyWith(serverList: newList));
    return save();
  }

  Future<void> addServerToList(String server) => addServersToList([server]);

  Future<void> removeServerFromList(String server) {
    final newList = state.serverList.where((s) => s != server).toList();
    emit(state.copyWith(serverList: newList));
    return save();
  }

  Future<void> changeShowIntro(bool value) {
    emit(state.copyWith(showIntro: value));
    return save();
  }

  Future<void> importSettings(String data) {
    final settings = SetonixSettingsMapper.fromJson(data);
    emit(settings);
    return state.save();
  }

  Future<String> exportSettings() async {
    return state.toJson();
  }

  Future<void> addRecentGame(String name, Uri uri) async {
    final newList = List<RecentGameEntry>.from(state.recentGames);
    newList.removeWhere((e) => e.location == uri);
    newList.insert(
      0,
      RecentGameEntry(name: name, location: uri, lastPlayed: DateTime.now()),
    );
    if (newList.length > kRecentHistorySize) {
      newList.removeLast();
    }
    emit(state.copyWith(recentGames: newList));
    return save();
  }
}
