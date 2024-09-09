// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'server.dart';

class GameServerMapper extends ClassMapperBase<GameServer> {
  GameServerMapper._();

  static GameServerMapper? _instance;
  static GameServerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameServerMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GameServer';

  static String _$name(GameServer v) => v.name;
  static const Field<GameServer, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$address(GameServer v) => v.address;
  static const Field<GameServer, String> _f$address =
      Field('address', _$address);
  static bool _$secure(GameServer v) => v.secure;
  static const Field<GameServer, bool> _f$secure =
      Field('secure', _$secure, opt: true, def: true);

  @override
  final MappableFields<GameServer> fields = const {
    #name: _f$name,
    #address: _f$address,
    #secure: _f$secure,
  };

  static GameServer _instantiate(DecodingData data) {
    return GameServer(
        name: data.dec(_f$name),
        address: data.dec(_f$address),
        secure: data.dec(_f$secure));
  }

  @override
  final Function instantiate = _instantiate;

  static GameServer fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameServer>(map);
  }

  static GameServer fromJson(String json) {
    return ensureInitialized().decodeJson<GameServer>(json);
  }
}

mixin GameServerMappable {
  String toJson() {
    return GameServerMapper.ensureInitialized()
        .encodeJson<GameServer>(this as GameServer);
  }

  Map<String, dynamic> toMap() {
    return GameServerMapper.ensureInitialized()
        .encodeMap<GameServer>(this as GameServer);
  }

  GameServerCopyWith<GameServer, GameServer, GameServer> get copyWith =>
      _GameServerCopyWithImpl(this as GameServer, $identity, $identity);
  @override
  String toString() {
    return GameServerMapper.ensureInitialized()
        .stringifyValue(this as GameServer);
  }

  @override
  bool operator ==(Object other) {
    return GameServerMapper.ensureInitialized()
        .equalsValue(this as GameServer, other);
  }

  @override
  int get hashCode {
    return GameServerMapper.ensureInitialized().hashValue(this as GameServer);
  }
}

extension GameServerValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameServer, $Out> {
  GameServerCopyWith<$R, GameServer, $Out> get $asGameServer =>
      $base.as((v, t, t2) => _GameServerCopyWithImpl(v, t, t2));
}

abstract class GameServerCopyWith<$R, $In extends GameServer, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? address, bool? secure});
  GameServerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameServerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameServer, $Out>
    implements GameServerCopyWith<$R, GameServer, $Out> {
  _GameServerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameServer> $mapper =
      GameServerMapper.ensureInitialized();
  @override
  $R call({String? name, String? address, bool? secure}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (address != null) #address: address,
        if (secure != null) #secure: secure
      }));
  @override
  GameServer $make(CopyWithData data) => GameServer(
      name: data.get(#name, or: $value.name),
      address: data.get(#address, or: $value.address),
      secure: data.get(#secure, or: $value.secure));

  @override
  GameServerCopyWith<$R2, GameServer, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameServerCopyWithImpl($value, $cast, t);
}

class GamePropertyMapper extends ClassMapperBase<GameProperty> {
  GamePropertyMapper._();

  static GamePropertyMapper? _instance;
  static GamePropertyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GamePropertyMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GameProperty';

  static String _$description(GameProperty v) => v.description;
  static const Field<GameProperty, String> _f$description =
      Field('description', _$description, opt: true, def: '');

  @override
  final MappableFields<GameProperty> fields = const {
    #description: _f$description,
  };

  static GameProperty _instantiate(DecodingData data) {
    return GameProperty(description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static GameProperty fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameProperty>(map);
  }

  static GameProperty fromJson(String json) {
    return ensureInitialized().decodeJson<GameProperty>(json);
  }
}

mixin GamePropertyMappable {
  String toJson() {
    return GamePropertyMapper.ensureInitialized()
        .encodeJson<GameProperty>(this as GameProperty);
  }

  Map<String, dynamic> toMap() {
    return GamePropertyMapper.ensureInitialized()
        .encodeMap<GameProperty>(this as GameProperty);
  }

  GamePropertyCopyWith<GameProperty, GameProperty, GameProperty> get copyWith =>
      _GamePropertyCopyWithImpl(this as GameProperty, $identity, $identity);
  @override
  String toString() {
    return GamePropertyMapper.ensureInitialized()
        .stringifyValue(this as GameProperty);
  }

  @override
  bool operator ==(Object other) {
    return GamePropertyMapper.ensureInitialized()
        .equalsValue(this as GameProperty, other);
  }

  @override
  int get hashCode {
    return GamePropertyMapper.ensureInitialized()
        .hashValue(this as GameProperty);
  }
}

extension GamePropertyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameProperty, $Out> {
  GamePropertyCopyWith<$R, GameProperty, $Out> get $asGameProperty =>
      $base.as((v, t, t2) => _GamePropertyCopyWithImpl(v, t, t2));
}

abstract class GamePropertyCopyWith<$R, $In extends GameProperty, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? description});
  GamePropertyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GamePropertyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameProperty, $Out>
    implements GamePropertyCopyWith<$R, GameProperty, $Out> {
  _GamePropertyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameProperty> $mapper =
      GamePropertyMapper.ensureInitialized();
  @override
  $R call({String? description}) => $apply(
      FieldCopyWithData({if (description != null) #description: description}));
  @override
  GameProperty $make(CopyWithData data) =>
      GameProperty(description: data.get(#description, or: $value.description));

  @override
  GamePropertyCopyWith<$R2, GameProperty, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GamePropertyCopyWithImpl($value, $cast, t);
}
