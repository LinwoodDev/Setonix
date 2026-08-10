// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user.dart';

/// @nodoc
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

  static String? _$fingerprint(SetonixUser v) => v.fingerprint;
  static const Field<SetonixUser, String> _f$fingerprint = Field(
    'fingerprint',
    _$fingerprint,
    opt: true,
  );
  static String _$name(SetonixUser v) => v.name;
  static const Field<SetonixUser, String> _f$name = Field('name', _$name);
  static bool _$onWhitelist(SetonixUser v) => v.onWhitelist;
  static const Field<SetonixUser, bool> _f$onWhitelist = Field(
    'onWhitelist',
    _$onWhitelist,
    opt: true,
    def: false,
  );
  static Set<String> _$roles(SetonixUser v) => v.roles;
  static const Field<SetonixUser, Set<String>> _f$roles = Field(
    'roles',
    _$roles,
    opt: true,
    def: const {kDefaultServerRole},
  );
  static bool _$banned(SetonixUser v) => v.banned;
  static const Field<SetonixUser, bool> _f$banned = Field(
    'banned',
    _$banned,
    opt: true,
    def: false,
  );
  static DateTime? _$bannedUntil(SetonixUser v) => v.bannedUntil;
  static const Field<SetonixUser, DateTime> _f$bannedUntil = Field(
    'bannedUntil',
    _$bannedUntil,
    opt: true,
  );
  static String? _$banReason(SetonixUser v) => v.banReason;
  static const Field<SetonixUser, String> _f$banReason = Field(
    'banReason',
    _$banReason,
    opt: true,
  );
  static DateTime? _$createdAt(SetonixUser v) => v.createdAt;
  static const Field<SetonixUser, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(SetonixUser v) => v.updatedAt;
  static const Field<SetonixUser, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );
  static DateTime? _$lastLogin(SetonixUser v) => v.lastLogin;
  static const Field<SetonixUser, DateTime> _f$lastLogin = Field(
    'lastLogin',
    _$lastLogin,
    opt: true,
  );

  @override
  final MappableFields<SetonixUser> fields = const {
    #fingerprint: _f$fingerprint,
    #name: _f$name,
    #onWhitelist: _f$onWhitelist,
    #roles: _f$roles,
    #banned: _f$banned,
    #bannedUntil: _f$bannedUntil,
    #banReason: _f$banReason,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #lastLogin: _f$lastLogin,
  };

  static SetonixUser _instantiate(DecodingData data) {
    return SetonixUser(
      fingerprint: data.dec(_f$fingerprint),
      name: data.dec(_f$name),
      onWhitelist: data.dec(_f$onWhitelist),
      roles: data.dec(_f$roles),
      banned: data.dec(_f$banned),
      bannedUntil: data.dec(_f$bannedUntil),
      banReason: data.dec(_f$banReason),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      lastLogin: data.dec(_f$lastLogin),
    );
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

/// @nodoc
mixin SetonixUserMappable {
  String toJson() {
    return SetonixUserMapper.ensureInitialized().encodeJson<SetonixUser>(
      this as SetonixUser,
    );
  }

  Map<String, dynamic> toMap() {
    return SetonixUserMapper.ensureInitialized().encodeMap<SetonixUser>(
      this as SetonixUser,
    );
  }

  SetonixUserCopyWith<SetonixUser, SetonixUser, SetonixUser> get copyWith =>
      _SetonixUserCopyWithImpl<SetonixUser, SetonixUser>(
        this as SetonixUser,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SetonixUserMapper.ensureInitialized().stringifyValue(
      this as SetonixUser,
    );
  }

  @override
  bool operator ==(Object other) {
    return SetonixUserMapper.ensureInitialized().equalsValue(
      this as SetonixUser,
      other,
    );
  }

  @override
  int get hashCode {
    return SetonixUserMapper.ensureInitialized().hashValue(this as SetonixUser);
  }
}

/// @nodoc
extension SetonixUserValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SetonixUser, $Out> {
  SetonixUserCopyWith<$R, SetonixUser, $Out> get $asSetonixUser =>
      $base.as((v, t, t2) => _SetonixUserCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class SetonixUserCopyWith<$R, $In extends SetonixUser, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? fingerprint,
    String? name,
    bool? onWhitelist,
    Set<String>? roles,
    bool? banned,
    DateTime? bannedUntil,
    String? banReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLogin,
  });
  SetonixUserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _SetonixUserCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SetonixUser, $Out>
    implements SetonixUserCopyWith<$R, SetonixUser, $Out> {
  _SetonixUserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SetonixUser> $mapper =
      SetonixUserMapper.ensureInitialized();
  @override
  $R call({
    Object? fingerprint = $none,
    String? name,
    bool? onWhitelist,
    Set<String>? roles,
    bool? banned,
    Object? bannedUntil = $none,
    Object? banReason = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
    Object? lastLogin = $none,
  }) => $apply(
    FieldCopyWithData({
      if (fingerprint != $none) #fingerprint: fingerprint,
      if (name != null) #name: name,
      if (onWhitelist != null) #onWhitelist: onWhitelist,
      if (roles != null) #roles: roles,
      if (banned != null) #banned: banned,
      if (bannedUntil != $none) #bannedUntil: bannedUntil,
      if (banReason != $none) #banReason: banReason,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
      if (lastLogin != $none) #lastLogin: lastLogin,
    }),
  );
  @override
  SetonixUser $make(CopyWithData data) => SetonixUser(
    fingerprint: data.get(#fingerprint, or: $value.fingerprint),
    name: data.get(#name, or: $value.name),
    onWhitelist: data.get(#onWhitelist, or: $value.onWhitelist),
    roles: data.get(#roles, or: $value.roles),
    banned: data.get(#banned, or: $value.banned),
    bannedUntil: data.get(#bannedUntil, or: $value.bannedUntil),
    banReason: data.get(#banReason, or: $value.banReason),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    lastLogin: data.get(#lastLogin, or: $value.lastLogin),
  );

  @override
  SetonixUserCopyWith<$R2, SetonixUser, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SetonixUserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

