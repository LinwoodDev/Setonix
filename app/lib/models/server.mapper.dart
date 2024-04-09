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
      LanGameServerMapper.ensureInitialized();
      GamePropertyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameServer';

  static GameProperty _$property(GameServer v) => v.property;
  static const Field<GameServer, GameProperty> _f$property =
      Field('property', _$property);

  @override
  final MappableFields<GameServer> fields = const {
    #property: _f$property,
  };

  static GameServer _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('GameServer');
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
  String toJson();
  Map<String, dynamic> toMap();
  GameServerCopyWith<GameServer, GameServer, GameServer> get copyWith;
}

abstract class GameServerCopyWith<$R, $In extends GameServer, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  GamePropertyCopyWith<$R, GameProperty, GameProperty> get property;
  $R call({GameProperty? property});
  GameServerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
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

  static String _$name(GameProperty v) => v.name;
  static const Field<GameProperty, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(GameProperty v) => v.description;
  static const Field<GameProperty, String> _f$description =
      Field('description', _$description, opt: true, def: '');

  @override
  final MappableFields<GameProperty> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static GameProperty _instantiate(DecodingData data) {
    return GameProperty(
        name: data.dec(_f$name), description: data.dec(_f$description));
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
  $R call({String? name, String? description});
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
  $R call({String? name, String? description}) => $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (description != null) #description: description
      }));
  @override
  GameProperty $make(CopyWithData data) => GameProperty(
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description));

  @override
  GamePropertyCopyWith<$R2, GameProperty, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GamePropertyCopyWithImpl($value, $cast, t);
}

class LanGameServerMapper extends ClassMapperBase<LanGameServer> {
  LanGameServerMapper._();

  static LanGameServerMapper? _instance;
  static LanGameServerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanGameServerMapper._());
      GameServerMapper.ensureInitialized();
      GamePropertyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanGameServer';

  static String _$address(LanGameServer v) => v.address;
  static const Field<LanGameServer, String> _f$address =
      Field('address', _$address);
  static GameProperty _$property(LanGameServer v) => v.property;
  static const Field<LanGameServer, GameProperty> _f$property =
      Field('property', _$property);

  @override
  final MappableFields<LanGameServer> fields = const {
    #address: _f$address,
    #property: _f$property,
  };

  static LanGameServer _instantiate(DecodingData data) {
    return LanGameServer(
        address: data.dec(_f$address), property: data.dec(_f$property));
  }

  @override
  final Function instantiate = _instantiate;

  static LanGameServer fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanGameServer>(map);
  }

  static LanGameServer fromJson(String json) {
    return ensureInitialized().decodeJson<LanGameServer>(json);
  }
}

mixin LanGameServerMappable {
  String toJson() {
    return LanGameServerMapper.ensureInitialized()
        .encodeJson<LanGameServer>(this as LanGameServer);
  }

  Map<String, dynamic> toMap() {
    return LanGameServerMapper.ensureInitialized()
        .encodeMap<LanGameServer>(this as LanGameServer);
  }

  LanGameServerCopyWith<LanGameServer, LanGameServer, LanGameServer>
      get copyWith => _LanGameServerCopyWithImpl(
          this as LanGameServer, $identity, $identity);
  @override
  String toString() {
    return LanGameServerMapper.ensureInitialized()
        .stringifyValue(this as LanGameServer);
  }

  @override
  bool operator ==(Object other) {
    return LanGameServerMapper.ensureInitialized()
        .equalsValue(this as LanGameServer, other);
  }

  @override
  int get hashCode {
    return LanGameServerMapper.ensureInitialized()
        .hashValue(this as LanGameServer);
  }
}

extension LanGameServerValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanGameServer, $Out> {
  LanGameServerCopyWith<$R, LanGameServer, $Out> get $asLanGameServer =>
      $base.as((v, t, t2) => _LanGameServerCopyWithImpl(v, t, t2));
}

abstract class LanGameServerCopyWith<$R, $In extends LanGameServer, $Out>
    implements GameServerCopyWith<$R, $In, $Out> {
  @override
  GamePropertyCopyWith<$R, GameProperty, GameProperty> get property;
  @override
  $R call({String? address, GameProperty? property});
  LanGameServerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LanGameServerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanGameServer, $Out>
    implements LanGameServerCopyWith<$R, LanGameServer, $Out> {
  _LanGameServerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanGameServer> $mapper =
      LanGameServerMapper.ensureInitialized();
  @override
  GamePropertyCopyWith<$R, GameProperty, GameProperty> get property =>
      $value.property.copyWith.$chain((v) => call(property: v));
  @override
  $R call({String? address, GameProperty? property}) =>
      $apply(FieldCopyWithData({
        if (address != null) #address: address,
        if (property != null) #property: property
      }));
  @override
  LanGameServer $make(CopyWithData data) => LanGameServer(
      address: data.get(#address, or: $value.address),
      property: data.get(#property, or: $value.property));

  @override
  LanGameServerCopyWith<$R2, LanGameServer, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LanGameServerCopyWithImpl($value, $cast, t);
}
