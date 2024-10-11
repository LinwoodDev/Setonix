// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings.dart';

class SetonixSettingsMapper extends ClassMapperBase<SetonixSettings> {
  SetonixSettingsMapper._();

  static SetonixSettingsMapper? _instance;
  static SetonixSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SetonixSettingsMapper._());
      GamePropertyMapper.ensureInitialized();
      ListGameServerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SetonixSettings';

  static String _$localeTag(SetonixSettings v) => v.localeTag;
  static const Field<SetonixSettings, String> _f$localeTag =
      Field('localeTag', _$localeTag, opt: true, def: '');
  static ThemeMode _$theme(SetonixSettings v) => v.theme;
  static const Field<SetonixSettings, ThemeMode> _f$theme =
      Field('theme', _$theme, opt: true, def: ThemeMode.system);
  static String _$design(SetonixSettings v) => v.design;
  static const Field<SetonixSettings, String> _f$design =
      Field('design', _$design, opt: true, def: '');
  static String _$dataDirectory(SetonixSettings v) => v.dataDirectory;
  static const Field<SetonixSettings, String> _f$dataDirectory =
      Field('dataDirectory', _$dataDirectory, opt: true, def: '');
  static bool _$nativeTitleBar(SetonixSettings v) => v.nativeTitleBar;
  static const Field<SetonixSettings, bool> _f$nativeTitleBar =
      Field('nativeTitleBar', _$nativeTitleBar, opt: true, def: false);
  static bool _$showConnectYour(SetonixSettings v) => v.showConnectYour;
  static const Field<SetonixSettings, bool> _f$showConnectYour =
      Field('showConnectYour', _$showConnectYour, opt: true, def: true);
  static bool _$showConnectNetwork(SetonixSettings v) => v.showConnectNetwork;
  static const Field<SetonixSettings, bool> _f$showConnectNetwork =
      Field('showConnectNetwork', _$showConnectNetwork, opt: true, def: true);
  static String? _$lastVersion(SetonixSettings v) => v.lastVersion;
  static const Field<SetonixSettings, String> _f$lastVersion =
      Field('lastVersion', _$lastVersion, opt: true);
  static GameProperty _$gameProperty(SetonixSettings v) => v.gameProperty;
  static const Field<SetonixSettings, GameProperty> _f$gameProperty = Field(
      'gameProperty', _$gameProperty,
      opt: true, def: const GameProperty());
  static List<ListGameServer> _$servers(SetonixSettings v) => v.servers;
  static const Field<SetonixSettings, List<ListGameServer>> _f$servers =
      Field('servers', _$servers, opt: true, def: const []);
  static bool _$highContrast(SetonixSettings v) => v.highContrast;
  static const Field<SetonixSettings, bool> _f$highContrast =
      Field('highContrast', _$highContrast, opt: true, def: false);
  static double _$zoom(SetonixSettings v) => v.zoom;
  static const Field<SetonixSettings, double> _f$zoom =
      Field('zoom', _$zoom, opt: true, def: 1);

  @override
  final MappableFields<SetonixSettings> fields = const {
    #localeTag: _f$localeTag,
    #theme: _f$theme,
    #design: _f$design,
    #dataDirectory: _f$dataDirectory,
    #nativeTitleBar: _f$nativeTitleBar,
    #showConnectYour: _f$showConnectYour,
    #showConnectNetwork: _f$showConnectNetwork,
    #lastVersion: _f$lastVersion,
    #gameProperty: _f$gameProperty,
    #servers: _f$servers,
    #highContrast: _f$highContrast,
    #zoom: _f$zoom,
  };

  static SetonixSettings _instantiate(DecodingData data) {
    return SetonixSettings(
        localeTag: data.dec(_f$localeTag),
        theme: data.dec(_f$theme),
        design: data.dec(_f$design),
        dataDirectory: data.dec(_f$dataDirectory),
        nativeTitleBar: data.dec(_f$nativeTitleBar),
        showConnectYour: data.dec(_f$showConnectYour),
        showConnectNetwork: data.dec(_f$showConnectNetwork),
        lastVersion: data.dec(_f$lastVersion),
        gameProperty: data.dec(_f$gameProperty),
        servers: data.dec(_f$servers),
        highContrast: data.dec(_f$highContrast),
        zoom: data.dec(_f$zoom));
  }

  @override
  final Function instantiate = _instantiate;

  static SetonixSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SetonixSettings>(map);
  }

  static SetonixSettings fromJson(String json) {
    return ensureInitialized().decodeJson<SetonixSettings>(json);
  }
}

mixin SetonixSettingsMappable {
  String toJson() {
    return SetonixSettingsMapper.ensureInitialized()
        .encodeJson<SetonixSettings>(this as SetonixSettings);
  }

  Map<String, dynamic> toMap() {
    return SetonixSettingsMapper.ensureInitialized()
        .encodeMap<SetonixSettings>(this as SetonixSettings);
  }

  SetonixSettingsCopyWith<SetonixSettings, SetonixSettings, SetonixSettings>
      get copyWith => _SetonixSettingsCopyWithImpl(
          this as SetonixSettings, $identity, $identity);
  @override
  String toString() {
    return SetonixSettingsMapper.ensureInitialized()
        .stringifyValue(this as SetonixSettings);
  }

  @override
  bool operator ==(Object other) {
    return SetonixSettingsMapper.ensureInitialized()
        .equalsValue(this as SetonixSettings, other);
  }

  @override
  int get hashCode {
    return SetonixSettingsMapper.ensureInitialized()
        .hashValue(this as SetonixSettings);
  }
}

extension SetonixSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SetonixSettings, $Out> {
  SetonixSettingsCopyWith<$R, SetonixSettings, $Out> get $asSetonixSettings =>
      $base.as((v, t, t2) => _SetonixSettingsCopyWithImpl(v, t, t2));
}

abstract class SetonixSettingsCopyWith<$R, $In extends SetonixSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  GamePropertyCopyWith<$R, GameProperty, GameProperty> get gameProperty;
  ListCopyWith<$R, ListGameServer,
      ListGameServerCopyWith<$R, ListGameServer, ListGameServer>> get servers;
  $R call(
      {String? localeTag,
      ThemeMode? theme,
      String? design,
      String? dataDirectory,
      bool? nativeTitleBar,
      bool? showConnectYour,
      bool? showConnectNetwork,
      String? lastVersion,
      GameProperty? gameProperty,
      List<ListGameServer>? servers,
      bool? highContrast,
      double? zoom});
  SetonixSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SetonixSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SetonixSettings, $Out>
    implements SetonixSettingsCopyWith<$R, SetonixSettings, $Out> {
  _SetonixSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SetonixSettings> $mapper =
      SetonixSettingsMapper.ensureInitialized();
  @override
  GamePropertyCopyWith<$R, GameProperty, GameProperty> get gameProperty =>
      $value.gameProperty.copyWith.$chain((v) => call(gameProperty: v));
  @override
  ListCopyWith<$R, ListGameServer,
          ListGameServerCopyWith<$R, ListGameServer, ListGameServer>>
      get servers => ListCopyWith($value.servers,
          (v, t) => v.copyWith.$chain(t), (v) => call(servers: v));
  @override
  $R call(
          {String? localeTag,
          ThemeMode? theme,
          String? design,
          String? dataDirectory,
          bool? nativeTitleBar,
          bool? showConnectYour,
          bool? showConnectNetwork,
          Object? lastVersion = $none,
          GameProperty? gameProperty,
          List<ListGameServer>? servers,
          bool? highContrast,
          double? zoom}) =>
      $apply(FieldCopyWithData({
        if (localeTag != null) #localeTag: localeTag,
        if (theme != null) #theme: theme,
        if (design != null) #design: design,
        if (dataDirectory != null) #dataDirectory: dataDirectory,
        if (nativeTitleBar != null) #nativeTitleBar: nativeTitleBar,
        if (showConnectYour != null) #showConnectYour: showConnectYour,
        if (showConnectNetwork != null) #showConnectNetwork: showConnectNetwork,
        if (lastVersion != $none) #lastVersion: lastVersion,
        if (gameProperty != null) #gameProperty: gameProperty,
        if (servers != null) #servers: servers,
        if (highContrast != null) #highContrast: highContrast,
        if (zoom != null) #zoom: zoom
      }));
  @override
  SetonixSettings $make(CopyWithData data) => SetonixSettings(
      localeTag: data.get(#localeTag, or: $value.localeTag),
      theme: data.get(#theme, or: $value.theme),
      design: data.get(#design, or: $value.design),
      dataDirectory: data.get(#dataDirectory, or: $value.dataDirectory),
      nativeTitleBar: data.get(#nativeTitleBar, or: $value.nativeTitleBar),
      showConnectYour: data.get(#showConnectYour, or: $value.showConnectYour),
      showConnectNetwork:
          data.get(#showConnectNetwork, or: $value.showConnectNetwork),
      lastVersion: data.get(#lastVersion, or: $value.lastVersion),
      gameProperty: data.get(#gameProperty, or: $value.gameProperty),
      servers: data.get(#servers, or: $value.servers),
      highContrast: data.get(#highContrast, or: $value.highContrast),
      zoom: data.get(#zoom, or: $value.zoom));

  @override
  SetonixSettingsCopyWith<$R2, SetonixSettings, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SetonixSettingsCopyWithImpl($value, $cast, t);
}
