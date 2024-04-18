// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vector.dart';

class VectorDefinitionMapper extends ClassMapperBase<VectorDefinition> {
  VectorDefinitionMapper._();

  static VectorDefinitionMapper? _instance;
  static VectorDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VectorDefinitionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VectorDefinition';

  static int _$x(VectorDefinition v) => v.x;
  static const Field<VectorDefinition, int> _f$x = Field('x', _$x);
  static int _$y(VectorDefinition v) => v.y;
  static const Field<VectorDefinition, int> _f$y = Field('y', _$y);

  @override
  final MappableFields<VectorDefinition> fields = const {
    #x: _f$x,
    #y: _f$y,
  };

  @override
  final MappingHook hook = const VectorDefinitionHook();
  static VectorDefinition _instantiate(DecodingData data) {
    return VectorDefinition(data.dec(_f$x), data.dec(_f$y));
  }

  @override
  final Function instantiate = _instantiate;

  static VectorDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VectorDefinition>(map);
  }

  static VectorDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<VectorDefinition>(json);
  }
}

mixin VectorDefinitionMappable {
  String toJson() {
    return VectorDefinitionMapper.ensureInitialized()
        .encodeJson<VectorDefinition>(this as VectorDefinition);
  }

  Map<String, dynamic> toMap() {
    return VectorDefinitionMapper.ensureInitialized()
        .encodeMap<VectorDefinition>(this as VectorDefinition);
  }

  VectorDefinitionCopyWith<VectorDefinition, VectorDefinition, VectorDefinition>
      get copyWith => _VectorDefinitionCopyWithImpl(
          this as VectorDefinition, $identity, $identity);
  @override
  String toString() {
    return VectorDefinitionMapper.ensureInitialized()
        .stringifyValue(this as VectorDefinition);
  }

  @override
  bool operator ==(Object other) {
    return VectorDefinitionMapper.ensureInitialized()
        .equalsValue(this as VectorDefinition, other);
  }

  @override
  int get hashCode {
    return VectorDefinitionMapper.ensureInitialized()
        .hashValue(this as VectorDefinition);
  }
}

extension VectorDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VectorDefinition, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, $Out>
      get $asVectorDefinition =>
          $base.as((v, t, t2) => _VectorDefinitionCopyWithImpl(v, t, t2));
}

abstract class VectorDefinitionCopyWith<$R, $In extends VectorDefinition, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? x, int? y});
  VectorDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _VectorDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VectorDefinition, $Out>
    implements VectorDefinitionCopyWith<$R, VectorDefinition, $Out> {
  _VectorDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VectorDefinition> $mapper =
      VectorDefinitionMapper.ensureInitialized();
  @override
  $R call({int? x, int? y}) =>
      $apply(FieldCopyWithData({if (x != null) #x: x, if (y != null) #y: y}));
  @override
  VectorDefinition $make(CopyWithData data) =>
      VectorDefinition(data.get(#x, or: $value.x), data.get(#y, or: $value.y));

  @override
  VectorDefinitionCopyWith<$R2, VectorDefinition, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _VectorDefinitionCopyWithImpl($value, $cast, t);
}
