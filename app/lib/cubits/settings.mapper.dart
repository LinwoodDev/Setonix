// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings.dart';

class QuokkaSettingsMapper extends ClassMapperBase<QuokkaSettings> {
  QuokkaSettingsMapper._();

  static QuokkaSettingsMapper? _instance;
  static QuokkaSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QuokkaSettingsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'QuokkaSettings';

  static String _$localeTag(QuokkaSettings v) => v.localeTag;
  static const Field<QuokkaSettings, String> _f$localeTag =
      Field('localeTag', _$localeTag, opt: true, def: '');
  static ThemeMode _$theme(QuokkaSettings v) => v.theme;
  static const Field<QuokkaSettings, ThemeMode> _f$theme =
      Field('theme', _$theme, opt: true, def: ThemeMode.system);
  static String _$design(QuokkaSettings v) => v.design;
  static const Field<QuokkaSettings, String> _f$design =
      Field('design', _$design, opt: true, def: '');
  static bool _$nativeTitleBar(QuokkaSettings v) => v.nativeTitleBar;
  static const Field<QuokkaSettings, bool> _f$nativeTitleBar =
      Field('nativeTitleBar', _$nativeTitleBar, opt: true, def: false);

  @override
  final MappableFields<QuokkaSettings> fields = const {
    #localeTag: _f$localeTag,
    #theme: _f$theme,
    #design: _f$design,
    #nativeTitleBar: _f$nativeTitleBar,
  };

  static QuokkaSettings _instantiate(DecodingData data) {
    return QuokkaSettings(
        localeTag: data.dec(_f$localeTag),
        theme: data.dec(_f$theme),
        design: data.dec(_f$design),
        nativeTitleBar: data.dec(_f$nativeTitleBar));
  }

  @override
  final Function instantiate = _instantiate;

  static QuokkaSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<QuokkaSettings>(map);
  }

  static QuokkaSettings fromJson(String json) {
    return ensureInitialized().decodeJson<QuokkaSettings>(json);
  }
}

mixin QuokkaSettingsMappable {
  String toJson() {
    return QuokkaSettingsMapper.ensureInitialized()
        .encodeJson<QuokkaSettings>(this as QuokkaSettings);
  }

  Map<String, dynamic> toMap() {
    return QuokkaSettingsMapper.ensureInitialized()
        .encodeMap<QuokkaSettings>(this as QuokkaSettings);
  }

  QuokkaSettingsCopyWith<QuokkaSettings, QuokkaSettings, QuokkaSettings>
      get copyWith => _QuokkaSettingsCopyWithImpl(
          this as QuokkaSettings, $identity, $identity);
  @override
  String toString() {
    return QuokkaSettingsMapper.ensureInitialized()
        .stringifyValue(this as QuokkaSettings);
  }

  @override
  bool operator ==(Object other) {
    return QuokkaSettingsMapper.ensureInitialized()
        .equalsValue(this as QuokkaSettings, other);
  }

  @override
  int get hashCode {
    return QuokkaSettingsMapper.ensureInitialized()
        .hashValue(this as QuokkaSettings);
  }
}

extension QuokkaSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, QuokkaSettings, $Out> {
  QuokkaSettingsCopyWith<$R, QuokkaSettings, $Out> get $asQuokkaSettings =>
      $base.as((v, t, t2) => _QuokkaSettingsCopyWithImpl(v, t, t2));
}

abstract class QuokkaSettingsCopyWith<$R, $In extends QuokkaSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? localeTag,
      ThemeMode? theme,
      String? design,
      bool? nativeTitleBar});
  QuokkaSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _QuokkaSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, QuokkaSettings, $Out>
    implements QuokkaSettingsCopyWith<$R, QuokkaSettings, $Out> {
  _QuokkaSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<QuokkaSettings> $mapper =
      QuokkaSettingsMapper.ensureInitialized();
  @override
  $R call(
          {String? localeTag,
          ThemeMode? theme,
          String? design,
          bool? nativeTitleBar}) =>
      $apply(FieldCopyWithData({
        if (localeTag != null) #localeTag: localeTag,
        if (theme != null) #theme: theme,
        if (design != null) #design: design,
        if (nativeTitleBar != null) #nativeTitleBar: nativeTitleBar
      }));
  @override
  QuokkaSettings $make(CopyWithData data) => QuokkaSettings(
      localeTag: data.get(#localeTag, or: $value.localeTag),
      theme: data.get(#theme, or: $value.theme),
      design: data.get(#design, or: $value.design),
      nativeTitleBar: data.get(#nativeTitleBar, or: $value.nativeTitleBar));

  @override
  QuokkaSettingsCopyWith<$R2, QuokkaSettings, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _QuokkaSettingsCopyWithImpl($value, $cast, t);
}
