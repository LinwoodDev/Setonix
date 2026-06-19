// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'equality.dart';

/// @nodoc
class IgnoreEqualityBoxMapper extends ClassMapperBase<IgnoreEqualityBox> {
  IgnoreEqualityBoxMapper._();

  static IgnoreEqualityBoxMapper? _instance;
  static IgnoreEqualityBoxMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IgnoreEqualityBoxMapper._());
      MapperContainer.globals.useAll([IgnoreForEquality()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IgnoreEqualityBox';
  @override
  Function get typeFactory =>
      <T>(f) => f<IgnoreEqualityBox<T>>();

  static dynamic _$content(IgnoreEqualityBox v) => v.content;
  static dynamic _arg$content<T>(f) => f<T>();
  static const Field<IgnoreEqualityBox, dynamic> _f$content = Field(
    'content',
    _$content,
    arg: _arg$content,
  );

  @override
  final MappableFields<IgnoreEqualityBox> fields = const {#content: _f$content};

  static IgnoreEqualityBox<T> _instantiate<T>(DecodingData data) {
    return IgnoreEqualityBox(data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static IgnoreEqualityBox<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IgnoreEqualityBox<T>>(map);
  }

  static IgnoreEqualityBox<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<IgnoreEqualityBox<T>>(json);
  }
}

/// @nodoc
mixin IgnoreEqualityBoxMappable<T> {
  String toJson() {
    return IgnoreEqualityBoxMapper.ensureInitialized()
        .encodeJson<IgnoreEqualityBox<T>>(this as IgnoreEqualityBox<T>);
  }

  Map<String, dynamic> toMap() {
    return IgnoreEqualityBoxMapper.ensureInitialized()
        .encodeMap<IgnoreEqualityBox<T>>(this as IgnoreEqualityBox<T>);
  }

  IgnoreEqualityBoxCopyWith<
    IgnoreEqualityBox<T>,
    IgnoreEqualityBox<T>,
    IgnoreEqualityBox<T>,
    T
  >
  get copyWith =>
      _IgnoreEqualityBoxCopyWithImpl<
        IgnoreEqualityBox<T>,
        IgnoreEqualityBox<T>,
        T
      >(this as IgnoreEqualityBox<T>, $identity, $identity);
}

/// @nodoc
extension IgnoreEqualityBoxValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, IgnoreEqualityBox<T>, $Out> {
  IgnoreEqualityBoxCopyWith<$R, IgnoreEqualityBox<T>, $Out, T>
  get $asIgnoreEqualityBox => $base.as(
    (v, t, t2) => _IgnoreEqualityBoxCopyWithImpl<$R, $Out, T>(v, t, t2),
  );
}

/// @nodoc
abstract class IgnoreEqualityBoxCopyWith<
  $R,
  $In extends IgnoreEqualityBox<T>,
  $Out,
  T
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({T? content});
  IgnoreEqualityBoxCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _IgnoreEqualityBoxCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, IgnoreEqualityBox<T>, $Out>
    implements IgnoreEqualityBoxCopyWith<$R, IgnoreEqualityBox<T>, $Out, T> {
  _IgnoreEqualityBoxCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IgnoreEqualityBox> $mapper =
      IgnoreEqualityBoxMapper.ensureInitialized();
  @override
  $R call({Object? content = $none}) =>
      $apply(FieldCopyWithData({if (content != $none) #content: content}));
  @override
  IgnoreEqualityBox<T> $make(CopyWithData data) =>
      IgnoreEqualityBox(data.get(#content, or: $value.content));

  @override
  IgnoreEqualityBoxCopyWith<$R2, IgnoreEqualityBox<T>, $Out2, T>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _IgnoreEqualityBoxCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}

