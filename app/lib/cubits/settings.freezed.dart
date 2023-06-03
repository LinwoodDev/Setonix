// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QeckSettings {
  String get localeTag => throw _privateConstructorUsedError;
  ThemeMode get theme => throw _privateConstructorUsedError;
  String get design => throw _privateConstructorUsedError;
  bool get nativeTitleBar => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QeckSettingsCopyWith<QeckSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QeckSettingsCopyWith<$Res> {
  factory $QeckSettingsCopyWith(
          QeckSettings value, $Res Function(QeckSettings) then) =
      _$QeckSettingsCopyWithImpl<$Res, QeckSettings>;
  @useResult
  $Res call(
      {String localeTag, ThemeMode theme, String design, bool nativeTitleBar});
}

/// @nodoc
class _$QeckSettingsCopyWithImpl<$Res, $Val extends QeckSettings>
    implements $QeckSettingsCopyWith<$Res> {
  _$QeckSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localeTag = null,
    Object? theme = null,
    Object? design = null,
    Object? nativeTitleBar = null,
  }) {
    return _then(_value.copyWith(
      localeTag: null == localeTag
          ? _value.localeTag
          : localeTag // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      design: null == design
          ? _value.design
          : design // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTitleBar: null == nativeTitleBar
          ? _value.nativeTitleBar
          : nativeTitleBar // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FlowSettingsCopyWith<$Res>
    implements $QeckSettingsCopyWith<$Res> {
  factory _$$_FlowSettingsCopyWith(
          _$_FlowSettings value, $Res Function(_$_FlowSettings) then) =
      __$$_FlowSettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String localeTag, ThemeMode theme, String design, bool nativeTitleBar});
}

/// @nodoc
class __$$_FlowSettingsCopyWithImpl<$Res>
    extends _$QeckSettingsCopyWithImpl<$Res, _$_FlowSettings>
    implements _$$_FlowSettingsCopyWith<$Res> {
  __$$_FlowSettingsCopyWithImpl(
      _$_FlowSettings _value, $Res Function(_$_FlowSettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localeTag = null,
    Object? theme = null,
    Object? design = null,
    Object? nativeTitleBar = null,
  }) {
    return _then(_$_FlowSettings(
      localeTag: null == localeTag
          ? _value.localeTag
          : localeTag // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      design: null == design
          ? _value.design
          : design // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTitleBar: null == nativeTitleBar
          ? _value.nativeTitleBar
          : nativeTitleBar // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_FlowSettings extends _FlowSettings {
  const _$_FlowSettings(
      {this.localeTag = '',
      this.theme = ThemeMode.system,
      this.design = '',
      this.nativeTitleBar = false})
      : super._();

  @override
  @JsonKey()
  final String localeTag;
  @override
  @JsonKey()
  final ThemeMode theme;
  @override
  @JsonKey()
  final String design;
  @override
  @JsonKey()
  final bool nativeTitleBar;

  @override
  String toString() {
    return 'QeckSettings(localeTag: $localeTag, theme: $theme, design: $design, nativeTitleBar: $nativeTitleBar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FlowSettings &&
            (identical(other.localeTag, localeTag) ||
                other.localeTag == localeTag) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.design, design) || other.design == design) &&
            (identical(other.nativeTitleBar, nativeTitleBar) ||
                other.nativeTitleBar == nativeTitleBar));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, localeTag, theme, design, nativeTitleBar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FlowSettingsCopyWith<_$_FlowSettings> get copyWith =>
      __$$_FlowSettingsCopyWithImpl<_$_FlowSettings>(this, _$identity);
}

abstract class _FlowSettings extends QeckSettings {
  const factory _FlowSettings(
      {final String localeTag,
      final ThemeMode theme,
      final String design,
      final bool nativeTitleBar}) = _$_FlowSettings;
  const _FlowSettings._() : super._();

  @override
  String get localeTag;
  @override
  ThemeMode get theme;
  @override
  String get design;
  @override
  bool get nativeTitleBar;
  @override
  @JsonKey(ignore: true)
  _$$_FlowSettingsCopyWith<_$_FlowSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
