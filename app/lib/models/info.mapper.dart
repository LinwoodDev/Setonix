// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'info.dart';

class ServersInfoMapper extends ClassMapperBase<ServersInfo> {
  ServersInfoMapper._();

  static ServersInfoMapper? _instance;
  static ServersInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServersInfoMapper._());
      ServerInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServersInfo';

  static List<ServerInfo> _$official(ServersInfo v) => v.official;
  static const Field<ServersInfo, List<ServerInfo>> _f$official =
      Field('official', _$official, opt: true, def: const []);
  static List<ServerInfo> _$community(ServersInfo v) => v.community;
  static const Field<ServersInfo, List<ServerInfo>> _f$community =
      Field('community', _$community, opt: true, def: const []);

  @override
  final MappableFields<ServersInfo> fields = const {
    #official: _f$official,
    #community: _f$community,
  };

  static ServersInfo _instantiate(DecodingData data) {
    return ServersInfo(
        official: data.dec(_f$official), community: data.dec(_f$community));
  }

  @override
  final Function instantiate = _instantiate;

  static ServersInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServersInfo>(map);
  }

  static ServersInfo fromJson(String json) {
    return ensureInitialized().decodeJson<ServersInfo>(json);
  }
}

mixin ServersInfoMappable {
  String toJson() {
    return ServersInfoMapper.ensureInitialized()
        .encodeJson<ServersInfo>(this as ServersInfo);
  }

  Map<String, dynamic> toMap() {
    return ServersInfoMapper.ensureInitialized()
        .encodeMap<ServersInfo>(this as ServersInfo);
  }

  ServersInfoCopyWith<ServersInfo, ServersInfo, ServersInfo> get copyWith =>
      _ServersInfoCopyWithImpl(this as ServersInfo, $identity, $identity);
  @override
  String toString() {
    return ServersInfoMapper.ensureInitialized()
        .stringifyValue(this as ServersInfo);
  }

  @override
  bool operator ==(Object other) {
    return ServersInfoMapper.ensureInitialized()
        .equalsValue(this as ServersInfo, other);
  }

  @override
  int get hashCode {
    return ServersInfoMapper.ensureInitialized().hashValue(this as ServersInfo);
  }
}

extension ServersInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServersInfo, $Out> {
  ServersInfoCopyWith<$R, ServersInfo, $Out> get $asServersInfo =>
      $base.as((v, t, t2) => _ServersInfoCopyWithImpl(v, t, t2));
}

abstract class ServersInfoCopyWith<$R, $In extends ServersInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ServerInfo, ServerInfoCopyWith<$R, ServerInfo, ServerInfo>>
      get official;
  ListCopyWith<$R, ServerInfo, ServerInfoCopyWith<$R, ServerInfo, ServerInfo>>
      get community;
  $R call({List<ServerInfo>? official, List<ServerInfo>? community});
  ServersInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ServersInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServersInfo, $Out>
    implements ServersInfoCopyWith<$R, ServersInfo, $Out> {
  _ServersInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServersInfo> $mapper =
      ServersInfoMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ServerInfo, ServerInfoCopyWith<$R, ServerInfo, ServerInfo>>
      get official => ListCopyWith($value.official,
          (v, t) => v.copyWith.$chain(t), (v) => call(official: v));
  @override
  ListCopyWith<$R, ServerInfo, ServerInfoCopyWith<$R, ServerInfo, ServerInfo>>
      get community => ListCopyWith($value.community,
          (v, t) => v.copyWith.$chain(t), (v) => call(community: v));
  @override
  $R call({List<ServerInfo>? official, List<ServerInfo>? community}) =>
      $apply(FieldCopyWithData({
        if (official != null) #official: official,
        if (community != null) #community: community
      }));
  @override
  ServersInfo $make(CopyWithData data) => ServersInfo(
      official: data.get(#official, or: $value.official),
      community: data.get(#community, or: $value.community));

  @override
  ServersInfoCopyWith<$R2, ServersInfo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ServersInfoCopyWithImpl($value, $cast, t);
}

class ServerInfoMapper extends ClassMapperBase<ServerInfo> {
  ServerInfoMapper._();

  static ServerInfoMapper? _instance;
  static ServerInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ServerInfo';

  static String _$name(ServerInfo v) => v.name;
  static const Field<ServerInfo, String> _f$name = Field('name', _$name);
  static String _$description(ServerInfo v) => v.description;
  static const Field<ServerInfo, String> _f$description =
      Field('description', _$description);
  static String _$address(ServerInfo v) => v.address;
  static const Field<ServerInfo, String> _f$address =
      Field('address', _$address);

  @override
  final MappableFields<ServerInfo> fields = const {
    #name: _f$name,
    #description: _f$description,
    #address: _f$address,
  };

  static ServerInfo _instantiate(DecodingData data) {
    return ServerInfo(
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        address: data.dec(_f$address));
  }

  @override
  final Function instantiate = _instantiate;

  static ServerInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerInfo>(map);
  }

  static ServerInfo fromJson(String json) {
    return ensureInitialized().decodeJson<ServerInfo>(json);
  }
}

mixin ServerInfoMappable {
  String toJson() {
    return ServerInfoMapper.ensureInitialized()
        .encodeJson<ServerInfo>(this as ServerInfo);
  }

  Map<String, dynamic> toMap() {
    return ServerInfoMapper.ensureInitialized()
        .encodeMap<ServerInfo>(this as ServerInfo);
  }

  ServerInfoCopyWith<ServerInfo, ServerInfo, ServerInfo> get copyWith =>
      _ServerInfoCopyWithImpl(this as ServerInfo, $identity, $identity);
  @override
  String toString() {
    return ServerInfoMapper.ensureInitialized()
        .stringifyValue(this as ServerInfo);
  }

  @override
  bool operator ==(Object other) {
    return ServerInfoMapper.ensureInitialized()
        .equalsValue(this as ServerInfo, other);
  }

  @override
  int get hashCode {
    return ServerInfoMapper.ensureInitialized().hashValue(this as ServerInfo);
  }
}

extension ServerInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerInfo, $Out> {
  ServerInfoCopyWith<$R, ServerInfo, $Out> get $asServerInfo =>
      $base.as((v, t, t2) => _ServerInfoCopyWithImpl(v, t, t2));
}

abstract class ServerInfoCopyWith<$R, $In extends ServerInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? description, String? address});
  ServerInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ServerInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerInfo, $Out>
    implements ServerInfoCopyWith<$R, ServerInfo, $Out> {
  _ServerInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerInfo> $mapper =
      ServerInfoMapper.ensureInitialized();
  @override
  $R call({String? name, String? description, String? address}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (address != null) #address: address
      }));
  @override
  ServerInfo $make(CopyWithData data) => ServerInfo(
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      address: data.get(#address, or: $value.address));

  @override
  ServerInfoCopyWith<$R2, ServerInfo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ServerInfoCopyWithImpl($value, $cast, t);
}
