// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings.dart';

class QeckSettingsMapper extends ClassMapperBase<QeckSettings> {
  QeckSettingsMapper._();

  static QeckSettingsMapper? _instance;
  static QeckSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QeckSettingsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'QeckSettings';

  static String _$localeTag(QeckSettings v) => v.localeTag;
  static const Field<QeckSettings, String> _f$localeTag =
      Field('localeTag', _$localeTag, opt: true, def: '');
  static ThemeMode _$theme(QeckSettings v) => v.theme;
  static const Field<QeckSettings, ThemeMode> _f$theme =
      Field('theme', _$theme, opt: true, def: ThemeMode.system);
  static String _$design(QeckSettings v) => v.design;
  static const Field<QeckSettings, String> _f$design =
      Field('design', _$design, opt: true, def: '');
  static bool _$nativeTitleBar(QeckSettings v) => v.nativeTitleBar;
  static const Field<QeckSettings, bool> _f$nativeTitleBar =
      Field('nativeTitleBar', _$nativeTitleBar, opt: true, def: false);

  @override
  final MappableFields<QeckSettings> fields = const {
    #localeTag: _f$localeTag,
    #theme: _f$theme,
    #design: _f$design,
    #nativeTitleBar: _f$nativeTitleBar,
  };

  static QeckSettings _instantiate(DecodingData data) {
    return QeckSettings(
        localeTag: data.dec(_f$localeTag),
        theme: data.dec(_f$theme),
        design: data.dec(_f$design),
        nativeTitleBar: data.dec(_f$nativeTitleBar));
  }

  @override
  final Function instantiate = _instantiate;

  static QeckSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<QeckSettings>(map);
  }

  static QeckSettings fromJson(String json) {
    return ensureInitialized().decodeJson<QeckSettings>(json);
  }
}

mixin QeckSettingsMappable {
  String toJson() {
    return QeckSettingsMapper.ensureInitialized()
        .encodeJson<QeckSettings>(this as QeckSettings);
  }

  Map<String, dynamic> toMap() {
    return QeckSettingsMapper.ensureInitialized()
        .encodeMap<QeckSettings>(this as QeckSettings);
  }

  QeckSettingsCopyWith<QeckSettings, QeckSettings, QeckSettings> get copyWith =>
      _QeckSettingsCopyWithImpl(this as QeckSettings, $identity, $identity);
  @override
  String toString() {
    return QeckSettingsMapper.ensureInitialized()
        .stringifyValue(this as QeckSettings);
  }

  @override
  bool operator ==(Object other) {
    return QeckSettingsMapper.ensureInitialized()
        .equalsValue(this as QeckSettings, other);
  }

  @override
  int get hashCode {
    return QeckSettingsMapper.ensureInitialized()
        .hashValue(this as QeckSettings);
  }
}

extension QeckSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, QeckSettings, $Out> {
  QeckSettingsCopyWith<$R, QeckSettings, $Out> get $asQeckSettings =>
      $base.as((v, t, t2) => _QeckSettingsCopyWithImpl(v, t, t2));
}

abstract class QeckSettingsCopyWith<$R, $In extends QeckSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? localeTag,
      ThemeMode? theme,
      String? design,
      bool? nativeTitleBar});
  QeckSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _QeckSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, QeckSettings, $Out>
    implements QeckSettingsCopyWith<$R, QeckSettings, $Out> {
  _QeckSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<QeckSettings> $mapper =
      QeckSettingsMapper.ensureInitialized();
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
  QeckSettings $make(CopyWithData data) => QeckSettings(
      localeTag: data.get(#localeTag, or: $value.localeTag),
      theme: data.get(#theme, or: $value.theme),
      design: data.get(#design, or: $value.design),
      nativeTitleBar: data.get(#nativeTitleBar, or: $value.nativeTitleBar));

  @override
  QeckSettingsCopyWith<$R2, QeckSettings, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _QeckSettingsCopyWithImpl($value, $cast, t);
}
