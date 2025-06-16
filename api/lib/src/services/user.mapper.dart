// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user.dart';

class SetonixUserMapper extends ClassMapperBase<SetonixUser> {
  SetonixUserMapper._();

  static SetonixUserMapper? _instance;
  static SetonixUserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SetonixUserMapper._());
      MapperContainer.globals.useAll([Base64Uint8ListHook()]);
    }
    return _instance!;
  }

  @override
  final String id = 'SetonixUser';

  static Uint8List? _$publicKey(SetonixUser v) => v.publicKey;
  static const Field<SetonixUser, Uint8List> _f$publicKey =
      Field('publicKey', _$publicKey, opt: true);
  static String _$name(SetonixUser v) => v.name;
  static const Field<SetonixUser, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<SetonixUser> fields = const {
    #publicKey: _f$publicKey,
    #name: _f$name,
  };

  static SetonixUser _instantiate(DecodingData data) {
    return SetonixUser(
        publicKey: data.dec(_f$publicKey), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static SetonixUser fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SetonixUser>(map);
  }

  static SetonixUser fromJson(String json) {
    return ensureInitialized().decodeJson<SetonixUser>(json);
  }
}

mixin SetonixUserMappable {
  String toJson() {
    return SetonixUserMapper.ensureInitialized()
        .encodeJson<SetonixUser>(this as SetonixUser);
  }

  Map<String, dynamic> toMap() {
    return SetonixUserMapper.ensureInitialized()
        .encodeMap<SetonixUser>(this as SetonixUser);
  }

  SetonixUserCopyWith<SetonixUser, SetonixUser, SetonixUser> get copyWith =>
      _SetonixUserCopyWithImpl<SetonixUser, SetonixUser>(
          this as SetonixUser, $identity, $identity);
  @override
  String toString() {
    return SetonixUserMapper.ensureInitialized()
        .stringifyValue(this as SetonixUser);
  }

  @override
  bool operator ==(Object other) {
    return SetonixUserMapper.ensureInitialized()
        .equalsValue(this as SetonixUser, other);
  }

  @override
  int get hashCode {
    return SetonixUserMapper.ensureInitialized().hashValue(this as SetonixUser);
  }
}

extension SetonixUserValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SetonixUser, $Out> {
  SetonixUserCopyWith<$R, SetonixUser, $Out> get $asSetonixUser =>
      $base.as((v, t, t2) => _SetonixUserCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SetonixUserCopyWith<$R, $In extends SetonixUser, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Uint8List? publicKey, String? name});
  SetonixUserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SetonixUserCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SetonixUser, $Out>
    implements SetonixUserCopyWith<$R, SetonixUser, $Out> {
  _SetonixUserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SetonixUser> $mapper =
      SetonixUserMapper.ensureInitialized();
  @override
  $R call({Object? publicKey = $none, String? name}) =>
      $apply(FieldCopyWithData({
        if (publicKey != $none) #publicKey: publicKey,
        if (name != null) #name: name
      }));
  @override
  SetonixUser $make(CopyWithData data) => SetonixUser(
      publicKey: data.get(#publicKey, or: $value.publicKey),
      name: data.get(#name, or: $value.name));

  @override
  SetonixUserCopyWith<$R2, SetonixUser, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SetonixUserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
