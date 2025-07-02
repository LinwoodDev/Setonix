// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings.dart';

class ThemeDensityMapper extends EnumMapper<ThemeDensity> {
  ThemeDensityMapper._();

  static ThemeDensityMapper? _instance;
  static ThemeDensityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ThemeDensityMapper._());
    }
    return _instance!;
  }

  static ThemeDensity fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ThemeDensity decode(dynamic value) {
    switch (value) {
      case r'system':
        return ThemeDensity.system;
      case r'maximize':
        return ThemeDensity.maximize;
      case r'desktop':
        return ThemeDensity.desktop;
      case r'compact':
        return ThemeDensity.compact;
      case r'comfortable':
        return ThemeDensity.comfortable;
      case r'standard':
        return ThemeDensity.standard;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ThemeDensity self) {
    switch (self) {
      case ThemeDensity.system:
        return r'system';
      case ThemeDensity.maximize:
        return r'maximize';
      case ThemeDensity.desktop:
        return r'desktop';
      case ThemeDensity.compact:
        return r'compact';
      case ThemeDensity.comfortable:
        return r'comfortable';
      case ThemeDensity.standard:
        return r'standard';
    }
  }
}

extension ThemeDensityMapperExtension on ThemeDensity {
  String toValue() {
    ThemeDensityMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ThemeDensity>(this) as String;
  }
}

class SetonixSettingsMapper extends ClassMapperBase<SetonixSettings> {
  SetonixSettingsMapper._();

  static SetonixSettingsMapper? _instance;
  static SetonixSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SetonixSettingsMapper._());
      MapperContainer.globals.useAll([ThemeModeMapper()]);
      GamePropertyMapper.ensureInitialized();
      ListGameServerMapper.ensureInitialized();
      ThemeDensityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SetonixSettings';

  static String _$localeTag(SetonixSettings v) => v.localeTag;
  static const Field<SetonixSettings, String> _f$localeTag = Field(
    'localeTag',
    _$localeTag,
    opt: true,
    def: '',
  );
  static ThemeMode _$theme(SetonixSettings v) => v.theme;
  static const Field<SetonixSettings, ThemeMode> _f$theme = Field(
    'theme',
    _$theme,
    opt: true,
    def: ThemeMode.system,
  );
  static String _$design(SetonixSettings v) => v.design;
  static const Field<SetonixSettings, String> _f$design = Field(
    'design',
    _$design,
    opt: true,
    def: '',
  );
  static String _$dataDirectory(SetonixSettings v) => v.dataDirectory;
  static const Field<SetonixSettings, String> _f$dataDirectory = Field(
    'dataDirectory',
    _$dataDirectory,
    opt: true,
    def: '',
  );
  static bool _$nativeTitleBar(SetonixSettings v) => v.nativeTitleBar;
  static const Field<SetonixSettings, bool> _f$nativeTitleBar = Field(
    'nativeTitleBar',
    _$nativeTitleBar,
    opt: true,
    def: false,
  );
  static bool _$showConnectYour(SetonixSettings v) => v.showConnectYour;
  static const Field<SetonixSettings, bool> _f$showConnectYour = Field(
    'showConnectYour',
    _$showConnectYour,
    opt: true,
    def: true,
  );
  static bool _$showConnectBrowse(SetonixSettings v) => v.showConnectBrowse;
  static const Field<SetonixSettings, bool> _f$showConnectBrowse = Field(
    'showConnectBrowse',
    _$showConnectBrowse,
    opt: true,
    def: false,
  );
  static String? _$lastVersion(SetonixSettings v) => v.lastVersion;
  static const Field<SetonixSettings, String> _f$lastVersion = Field(
    'lastVersion',
    _$lastVersion,
    opt: true,
  );
  static GameProperty _$gameProperty(SetonixSettings v) => v.gameProperty;
  static const Field<SetonixSettings, GameProperty> _f$gameProperty = Field(
    'gameProperty',
    _$gameProperty,
    opt: true,
    def: const GameProperty(),
  );
  static List<ListGameServer> _$servers(SetonixSettings v) => v.servers;
  static const Field<SetonixSettings, List<ListGameServer>> _f$servers = Field(
    'servers',
    _$servers,
    opt: true,
    def: const [],
  );
  static bool _$stackedCards(SetonixSettings v) => v.stackedCards;
  static const Field<SetonixSettings, bool> _f$stackedCards = Field(
    'stackedCards',
    _$stackedCards,
    opt: true,
    def: true,
  );
  static bool _$highContrast(SetonixSettings v) => v.highContrast;
  static const Field<SetonixSettings, bool> _f$highContrast = Field(
    'highContrast',
    _$highContrast,
    opt: true,
    def: false,
  );
  static double _$zoom(SetonixSettings v) => v.zoom;
  static const Field<SetonixSettings, double> _f$zoom = Field(
    'zoom',
    _$zoom,
    opt: true,
    def: 1,
  );
  static List<String> _$swamps(SetonixSettings v) => v.swamps;
  static const Field<SetonixSettings, List<String>> _f$swamps = Field(
    'swamps',
    _$swamps,
    opt: true,
    def: const [],
  );
  static ThemeDensity _$density(SetonixSettings v) => v.density;
  static const Field<SetonixSettings, ThemeDensity> _f$density = Field(
    'density',
    _$density,
    opt: true,
    def: ThemeDensity.system,
  );
  static double _$scrollSensitivity(SetonixSettings v) => v.scrollSensitivity;
  static const Field<SetonixSettings, double> _f$scrollSensitivity = Field(
    'scrollSensitivity',
    _$scrollSensitivity,
    opt: true,
    def: 1,
  );
  static List<String> _$serverList(SetonixSettings v) => v.serverList;
  static const Field<SetonixSettings, List<String>> _f$serverList = Field(
    'serverList',
    _$serverList,
    opt: true,
    def: const [],
  );
  static bool _$showIntro(SetonixSettings v) => v.showIntro;
  static const Field<SetonixSettings, bool> _f$showIntro = Field(
    'showIntro',
    _$showIntro,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<SetonixSettings> fields = const {
    #localeTag: _f$localeTag,
    #theme: _f$theme,
    #design: _f$design,
    #dataDirectory: _f$dataDirectory,
    #nativeTitleBar: _f$nativeTitleBar,
    #showConnectYour: _f$showConnectYour,
    #showConnectBrowse: _f$showConnectBrowse,
    #lastVersion: _f$lastVersion,
    #gameProperty: _f$gameProperty,
    #servers: _f$servers,
    #stackedCards: _f$stackedCards,
    #highContrast: _f$highContrast,
    #zoom: _f$zoom,
    #swamps: _f$swamps,
    #density: _f$density,
    #scrollSensitivity: _f$scrollSensitivity,
    #serverList: _f$serverList,
    #showIntro: _f$showIntro,
  };

  static SetonixSettings _instantiate(DecodingData data) {
    return SetonixSettings(
      localeTag: data.dec(_f$localeTag),
      theme: data.dec(_f$theme),
      design: data.dec(_f$design),
      dataDirectory: data.dec(_f$dataDirectory),
      nativeTitleBar: data.dec(_f$nativeTitleBar),
      showConnectYour: data.dec(_f$showConnectYour),
      showConnectBrowse: data.dec(_f$showConnectBrowse),
      lastVersion: data.dec(_f$lastVersion),
      gameProperty: data.dec(_f$gameProperty),
      servers: data.dec(_f$servers),
      stackedCards: data.dec(_f$stackedCards),
      highContrast: data.dec(_f$highContrast),
      zoom: data.dec(_f$zoom),
      swamps: data.dec(_f$swamps),
      density: data.dec(_f$density),
      scrollSensitivity: data.dec(_f$scrollSensitivity),
      serverList: data.dec(_f$serverList),
      showIntro: data.dec(_f$showIntro),
    );
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
    return SetonixSettingsMapper.ensureInitialized().encodeMap<SetonixSettings>(
      this as SetonixSettings,
    );
  }

  SetonixSettingsCopyWith<SetonixSettings, SetonixSettings, SetonixSettings>
  get copyWith =>
      _SetonixSettingsCopyWithImpl<SetonixSettings, SetonixSettings>(
        this as SetonixSettings,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SetonixSettingsMapper.ensureInitialized().stringifyValue(
      this as SetonixSettings,
    );
  }

  @override
  bool operator ==(Object other) {
    return SetonixSettingsMapper.ensureInitialized().equalsValue(
      this as SetonixSettings,
      other,
    );
  }

  @override
  int get hashCode {
    return SetonixSettingsMapper.ensureInitialized().hashValue(
      this as SetonixSettings,
    );
  }
}

extension SetonixSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SetonixSettings, $Out> {
  SetonixSettingsCopyWith<$R, SetonixSettings, $Out> get $asSetonixSettings =>
      $base.as((v, t, t2) => _SetonixSettingsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SetonixSettingsCopyWith<$R, $In extends SetonixSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  GamePropertyCopyWith<$R, GameProperty, GameProperty> get gameProperty;
  ListCopyWith<
    $R,
    ListGameServer,
    ListGameServerCopyWith<$R, ListGameServer, ListGameServer>
  >
  get servers;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get swamps;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get serverList;
  $R call({
    String? localeTag,
    ThemeMode? theme,
    String? design,
    String? dataDirectory,
    bool? nativeTitleBar,
    bool? showConnectYour,
    bool? showConnectBrowse,
    String? lastVersion,
    GameProperty? gameProperty,
    List<ListGameServer>? servers,
    bool? stackedCards,
    bool? highContrast,
    double? zoom,
    List<String>? swamps,
    ThemeDensity? density,
    double? scrollSensitivity,
    List<String>? serverList,
    bool? showIntro,
  });
  SetonixSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
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
  ListCopyWith<
    $R,
    ListGameServer,
    ListGameServerCopyWith<$R, ListGameServer, ListGameServer>
  >
  get servers => ListCopyWith(
    $value.servers,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(servers: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get swamps =>
      ListCopyWith(
        $value.swamps,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(swamps: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get serverList =>
      ListCopyWith(
        $value.serverList,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(serverList: v),
      );
  @override
  $R call({
    String? localeTag,
    ThemeMode? theme,
    String? design,
    String? dataDirectory,
    bool? nativeTitleBar,
    bool? showConnectYour,
    bool? showConnectBrowse,
    Object? lastVersion = $none,
    GameProperty? gameProperty,
    List<ListGameServer>? servers,
    bool? stackedCards,
    bool? highContrast,
    double? zoom,
    List<String>? swamps,
    ThemeDensity? density,
    double? scrollSensitivity,
    List<String>? serverList,
    bool? showIntro,
  }) => $apply(
    FieldCopyWithData({
      if (localeTag != null) #localeTag: localeTag,
      if (theme != null) #theme: theme,
      if (design != null) #design: design,
      if (dataDirectory != null) #dataDirectory: dataDirectory,
      if (nativeTitleBar != null) #nativeTitleBar: nativeTitleBar,
      if (showConnectYour != null) #showConnectYour: showConnectYour,
      if (showConnectBrowse != null) #showConnectBrowse: showConnectBrowse,
      if (lastVersion != $none) #lastVersion: lastVersion,
      if (gameProperty != null) #gameProperty: gameProperty,
      if (servers != null) #servers: servers,
      if (stackedCards != null) #stackedCards: stackedCards,
      if (highContrast != null) #highContrast: highContrast,
      if (zoom != null) #zoom: zoom,
      if (swamps != null) #swamps: swamps,
      if (density != null) #density: density,
      if (scrollSensitivity != null) #scrollSensitivity: scrollSensitivity,
      if (serverList != null) #serverList: serverList,
      if (showIntro != null) #showIntro: showIntro,
    }),
  );
  @override
  SetonixSettings $make(CopyWithData data) => SetonixSettings(
    localeTag: data.get(#localeTag, or: $value.localeTag),
    theme: data.get(#theme, or: $value.theme),
    design: data.get(#design, or: $value.design),
    dataDirectory: data.get(#dataDirectory, or: $value.dataDirectory),
    nativeTitleBar: data.get(#nativeTitleBar, or: $value.nativeTitleBar),
    showConnectYour: data.get(#showConnectYour, or: $value.showConnectYour),
    showConnectBrowse: data.get(
      #showConnectBrowse,
      or: $value.showConnectBrowse,
    ),
    lastVersion: data.get(#lastVersion, or: $value.lastVersion),
    gameProperty: data.get(#gameProperty, or: $value.gameProperty),
    servers: data.get(#servers, or: $value.servers),
    stackedCards: data.get(#stackedCards, or: $value.stackedCards),
    highContrast: data.get(#highContrast, or: $value.highContrast),
    zoom: data.get(#zoom, or: $value.zoom),
    swamps: data.get(#swamps, or: $value.swamps),
    density: data.get(#density, or: $value.density),
    scrollSensitivity: data.get(
      #scrollSensitivity,
      or: $value.scrollSensitivity,
    ),
    serverList: data.get(#serverList, or: $value.serverList),
    showIntro: data.get(#showIntro, or: $value.showIntro),
  );

  @override
  SetonixSettingsCopyWith<$R2, SetonixSettings, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SetonixSettingsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
