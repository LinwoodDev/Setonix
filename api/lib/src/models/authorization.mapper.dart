// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'authorization.dart';

/// @nodoc
class ServerRoleDefinitionMapper extends ClassMapperBase<ServerRoleDefinition> {
  ServerRoleDefinitionMapper._();

  static ServerRoleDefinitionMapper? _instance;
  static ServerRoleDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerRoleDefinitionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ServerRoleDefinition';

  static String _$name(ServerRoleDefinition v) => v.name;
  static const Field<ServerRoleDefinition, String> _f$name = Field(
    'name',
    _$name,
  );
  static Set<String> _$permissions(ServerRoleDefinition v) => v.permissions;
  static const Field<ServerRoleDefinition, Set<String>> _f$permissions = Field(
    'permissions',
    _$permissions,
    opt: true,
    def: const {},
  );
  static int _$priority(ServerRoleDefinition v) => v.priority;
  static const Field<ServerRoleDefinition, int> _f$priority = Field(
    'priority',
    _$priority,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<ServerRoleDefinition> fields = const {
    #name: _f$name,
    #permissions: _f$permissions,
    #priority: _f$priority,
  };

  static ServerRoleDefinition _instantiate(DecodingData data) {
    return ServerRoleDefinition(
      name: data.dec(_f$name),
      permissions: data.dec(_f$permissions),
      priority: data.dec(_f$priority),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ServerRoleDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerRoleDefinition>(map);
  }

  static ServerRoleDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<ServerRoleDefinition>(json);
  }
}

/// @nodoc
mixin ServerRoleDefinitionMappable {
  String toJson() {
    return ServerRoleDefinitionMapper.ensureInitialized()
        .encodeJson<ServerRoleDefinition>(this as ServerRoleDefinition);
  }

  Map<String, dynamic> toMap() {
    return ServerRoleDefinitionMapper.ensureInitialized()
        .encodeMap<ServerRoleDefinition>(this as ServerRoleDefinition);
  }

  ServerRoleDefinitionCopyWith<
    ServerRoleDefinition,
    ServerRoleDefinition,
    ServerRoleDefinition
  >
  get copyWith =>
      _ServerRoleDefinitionCopyWithImpl<
        ServerRoleDefinition,
        ServerRoleDefinition
      >(this as ServerRoleDefinition, $identity, $identity);
  @override
  String toString() {
    return ServerRoleDefinitionMapper.ensureInitialized().stringifyValue(
      this as ServerRoleDefinition,
    );
  }

  @override
  bool operator ==(Object other) {
    return ServerRoleDefinitionMapper.ensureInitialized().equalsValue(
      this as ServerRoleDefinition,
      other,
    );
  }

  @override
  int get hashCode {
    return ServerRoleDefinitionMapper.ensureInitialized().hashValue(
      this as ServerRoleDefinition,
    );
  }
}

/// @nodoc
extension ServerRoleDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerRoleDefinition, $Out> {
  ServerRoleDefinitionCopyWith<$R, ServerRoleDefinition, $Out>
  get $asServerRoleDefinition => $base.as(
    (v, t, t2) => _ServerRoleDefinitionCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class ServerRoleDefinitionCopyWith<
  $R,
  $In extends ServerRoleDefinition,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, Set<String>? permissions, int? priority});
  ServerRoleDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ServerRoleDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerRoleDefinition, $Out>
    implements ServerRoleDefinitionCopyWith<$R, ServerRoleDefinition, $Out> {
  _ServerRoleDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerRoleDefinition> $mapper =
      ServerRoleDefinitionMapper.ensureInitialized();
  @override
  $R call({String? name, Set<String>? permissions, int? priority}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (permissions != null) #permissions: permissions,
      if (priority != null) #priority: priority,
    }),
  );
  @override
  ServerRoleDefinition $make(CopyWithData data) => ServerRoleDefinition(
    name: data.get(#name, or: $value.name),
    permissions: data.get(#permissions, or: $value.permissions),
    priority: data.get(#priority, or: $value.priority),
  );

  @override
  ServerRoleDefinitionCopyWith<$R2, ServerRoleDefinition, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ServerRoleDefinitionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

