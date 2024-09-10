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
      ListGameServerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameServer';

  static String _$address(GameServer v) => v.address;
  static const Field<GameServer, String> _f$address =
      Field('address', _$address);
  static bool _$secure(GameServer v) => v.secure;
  static const Field<GameServer, bool> _f$secure =
      Field('secure', _$secure, opt: true, def: true);

  @override
  final MappableFields<GameServer> fields = const {
    #address: _f$address,
    #secure: _f$secure,
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
  $R call({String? address, bool? secure});
  GameServerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class LanGameServerMapper extends ClassMapperBase<LanGameServer> {
  LanGameServerMapper._();

  static LanGameServerMapper? _instance;
  static LanGameServerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanGameServerMapper._());
      GameServerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanGameServer';

  static String _$address(LanGameServer v) => v.address;
  static const Field<LanGameServer, String> _f$address =
      Field('address', _$address);
  static bool _$secure(LanGameServer v) => v.secure;
  static const Field<LanGameServer, bool> _f$secure =
      Field('secure', _$secure, opt: true, def: true);

  @override
  final MappableFields<LanGameServer> fields = const {
    #address: _f$address,
    #secure: _f$secure,
  };

  static LanGameServer _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('LanGameServer');
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
  String toJson();
  Map<String, dynamic> toMap();
  LanGameServerCopyWith<LanGameServer, LanGameServer, LanGameServer>
      get copyWith;
}

abstract class LanGameServerCopyWith<$R, $In extends LanGameServer, $Out>
    implements GameServerCopyWith<$R, $In, $Out> {
  @override
  $R call({String? address, bool? secure});
  LanGameServerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ListGameServerMapper extends ClassMapperBase<ListGameServer> {
  ListGameServerMapper._();

  static ListGameServerMapper? _instance;
  static ListGameServerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ListGameServerMapper._());
      GameServerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ListGameServer';

  static String _$name(ListGameServer v) => v.name;
  static const Field<ListGameServer, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$address(ListGameServer v) => v.address;
  static const Field<ListGameServer, String> _f$address =
      Field('address', _$address);
  static bool _$secure(ListGameServer v) => v.secure;
  static const Field<ListGameServer, bool> _f$secure =
      Field('secure', _$secure, opt: true, def: true);

  @override
  final MappableFields<ListGameServer> fields = const {
    #name: _f$name,
    #address: _f$address,
    #secure: _f$secure,
  };

  static ListGameServer _instantiate(DecodingData data) {
    return ListGameServer(
        name: data.dec(_f$name),
        address: data.dec(_f$address),
        secure: data.dec(_f$secure));
  }

  @override
  final Function instantiate = _instantiate;

  static ListGameServer fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ListGameServer>(map);
  }

  static ListGameServer fromJson(String json) {
    return ensureInitialized().decodeJson<ListGameServer>(json);
  }
}

mixin ListGameServerMappable {
  String toJson() {
    return ListGameServerMapper.ensureInitialized()
        .encodeJson<ListGameServer>(this as ListGameServer);
  }

  Map<String, dynamic> toMap() {
    return ListGameServerMapper.ensureInitialized()
        .encodeMap<ListGameServer>(this as ListGameServer);
  }

  ListGameServerCopyWith<ListGameServer, ListGameServer, ListGameServer>
      get copyWith => _ListGameServerCopyWithImpl(
          this as ListGameServer, $identity, $identity);
  @override
  String toString() {
    return ListGameServerMapper.ensureInitialized()
        .stringifyValue(this as ListGameServer);
  }

  @override
  bool operator ==(Object other) {
    return ListGameServerMapper.ensureInitialized()
        .equalsValue(this as ListGameServer, other);
  }

  @override
  int get hashCode {
    return ListGameServerMapper.ensureInitialized()
        .hashValue(this as ListGameServer);
  }
}

extension ListGameServerValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ListGameServer, $Out> {
  ListGameServerCopyWith<$R, ListGameServer, $Out> get $asListGameServer =>
      $base.as((v, t, t2) => _ListGameServerCopyWithImpl(v, t, t2));
}

abstract class ListGameServerCopyWith<$R, $In extends ListGameServer, $Out>
    implements GameServerCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? address, bool? secure});
  ListGameServerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ListGameServerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ListGameServer, $Out>
    implements ListGameServerCopyWith<$R, ListGameServer, $Out> {
  _ListGameServerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ListGameServer> $mapper =
      ListGameServerMapper.ensureInitialized();
  @override
  $R call({String? name, String? address, bool? secure}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (address != null) #address: address,
        if (secure != null) #secure: secure
      }));
  @override
  ListGameServer $make(CopyWithData data) => ListGameServer(
      name: data.get(#name, or: $value.name),
      address: data.get(#address, or: $value.address),
      secure: data.get(#secure, or: $value.secure));

  @override
  ListGameServerCopyWith<$R2, ListGameServer, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ListGameServerCopyWithImpl($value, $cast, t);
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
