// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'state.dart';

class PlayerStateMapper extends EnumMapper<PlayerState> {
  PlayerStateMapper._();

  static PlayerStateMapper? _instance;
  static PlayerStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlayerStateMapper._());
    }
    return _instance!;
  }

  static PlayerState fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PlayerState decode(dynamic value) {
    switch (value) {
      case 'idle':
        return PlayerState.idle;
      case 'walking':
        return PlayerState.walking;
      case 'sitting':
        return PlayerState.sitting;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PlayerState self) {
    switch (self) {
      case PlayerState.idle:
        return 'idle';
      case PlayerState.walking:
        return 'walking';
      case PlayerState.sitting:
        return 'sitting';
    }
  }
}

extension PlayerStateMapperExtension on PlayerState {
  String toValue() {
    PlayerStateMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PlayerState>(this) as String;
  }
}

class NetworkingUserMapper extends ClassMapperBase<NetworkingUser> {
  NetworkingUserMapper._();

  static NetworkingUserMapper? _instance;
  static NetworkingUserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NetworkingUserMapper._());
      _t$_R0Mapper.ensureInitialized();
      PlayerStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NetworkingUser';

  static String _$name(NetworkingUser v) => v.name;
  static const Field<NetworkingUser, String> _f$name = Field('name', _$name);
  static _t$_R0<double, double> _$position(NetworkingUser v) => v.position;
  static const Field<NetworkingUser, _t$_R0<double, double>> _f$position =
      Field('position', _$position, opt: true, def: (0, 0));
  static PlayerState _$state(NetworkingUser v) => v.state;
  static const Field<NetworkingUser, PlayerState> _f$state =
      Field('state', _$state, opt: true, def: PlayerState.idle);
  static _t$_R0<double, double> _$velocity(NetworkingUser v) => v.velocity;
  static const Field<NetworkingUser, _t$_R0<double, double>> _f$velocity =
      Field('velocity', _$velocity, opt: true, def: (0, 0));

  @override
  final MappableFields<NetworkingUser> fields = const {
    #name: _f$name,
    #position: _f$position,
    #state: _f$state,
    #velocity: _f$velocity,
  };

  static NetworkingUser _instantiate(DecodingData data) {
    return NetworkingUser(
        name: data.dec(_f$name),
        position: data.dec(_f$position),
        state: data.dec(_f$state),
        velocity: data.dec(_f$velocity));
  }

  @override
  final Function instantiate = _instantiate;

  static NetworkingUser fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NetworkingUser>(map);
  }

  static NetworkingUser fromJson(String json) {
    return ensureInitialized().decodeJson<NetworkingUser>(json);
  }
}

mixin NetworkingUserMappable {
  String toJson() {
    return NetworkingUserMapper.ensureInitialized()
        .encodeJson<NetworkingUser>(this as NetworkingUser);
  }

  Map<String, dynamic> toMap() {
    return NetworkingUserMapper.ensureInitialized()
        .encodeMap<NetworkingUser>(this as NetworkingUser);
  }

  NetworkingUserCopyWith<NetworkingUser, NetworkingUser, NetworkingUser>
      get copyWith => _NetworkingUserCopyWithImpl(
          this as NetworkingUser, $identity, $identity);
  @override
  String toString() {
    return NetworkingUserMapper.ensureInitialized()
        .stringifyValue(this as NetworkingUser);
  }

  @override
  bool operator ==(Object other) {
    return NetworkingUserMapper.ensureInitialized()
        .equalsValue(this as NetworkingUser, other);
  }

  @override
  int get hashCode {
    return NetworkingUserMapper.ensureInitialized()
        .hashValue(this as NetworkingUser);
  }
}

extension NetworkingUserValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NetworkingUser, $Out> {
  NetworkingUserCopyWith<$R, NetworkingUser, $Out> get $asNetworkingUser =>
      $base.as((v, t, t2) => _NetworkingUserCopyWithImpl(v, t, t2));
}

abstract class NetworkingUserCopyWith<$R, $In extends NetworkingUser, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? name,
      _t$_R0<double, double>? position,
      PlayerState? state,
      _t$_R0<double, double>? velocity});
  NetworkingUserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NetworkingUserCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NetworkingUser, $Out>
    implements NetworkingUserCopyWith<$R, NetworkingUser, $Out> {
  _NetworkingUserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NetworkingUser> $mapper =
      NetworkingUserMapper.ensureInitialized();
  @override
  $R call(
          {String? name,
          _t$_R0<double, double>? position,
          PlayerState? state,
          _t$_R0<double, double>? velocity}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (position != null) #position: position,
        if (state != null) #state: state,
        if (velocity != null) #velocity: velocity
      }));
  @override
  NetworkingUser $make(CopyWithData data) => NetworkingUser(
      name: data.get(#name, or: $value.name),
      position: data.get(#position, or: $value.position),
      state: data.get(#state, or: $value.state),
      velocity: data.get(#velocity, or: $value.velocity));

  @override
  NetworkingUserCopyWith<$R2, NetworkingUser, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NetworkingUserCopyWithImpl($value, $cast, t);
}

typedef _t$_R0<A, B> = (A, B);

class _t$_R0Mapper extends RecordMapperBase<_t$_R0> {
  static _t$_R0Mapper? _instance;
  _t$_R0Mapper._();

  static _t$_R0Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = _t$_R0Mapper._());
      MapperBase.addType(<A, B>(f) => f<(A, B)>());
    }
    return _instance!;
  }

  static dynamic _$$1(_t$_R0 v) => v.$1;
  static dynamic _arg$$1<A, B>(f) => f<A>();
  static const Field<_t$_R0, dynamic> _f$$1 = Field('\$1', _$$1, arg: _arg$$1);
  static dynamic _$$2(_t$_R0 v) => v.$2;
  static dynamic _arg$$2<A, B>(f) => f<B>();
  static const Field<_t$_R0, dynamic> _f$$2 = Field('\$2', _$$2, arg: _arg$$2);

  @override
  final MappableFields<_t$_R0> fields = const {
    #$1: _f$$1,
    #$2: _f$$2,
  };

  @override
  Function get typeFactory => <A, B>(f) => f<_t$_R0<A, B>>();

  static _t$_R0<A, B> _instantiate<A, B>(DecodingData<_t$_R0> data) {
    return (data.dec(_f$$1), data.dec(_f$$2));
  }

  @override
  final Function instantiate = _instantiate;

  static _t$_R0<A, B> fromMap<A, B>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<_t$_R0<A, B>>(map);
  }

  static _t$_R0<A, B> fromJson<A, B>(String json) {
    return ensureInitialized().decodeJson<_t$_R0<A, B>>(json);
  }
}
