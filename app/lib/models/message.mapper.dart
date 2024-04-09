// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'message.dart';

class NetworkMessageMapper extends ClassMapperBase<NetworkMessage> {
  NetworkMessageMapper._();

  static NetworkMessageMapper? _instance;
  static NetworkMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NetworkMessageMapper._());
      NetworkPlayerJoinMessageMapper.ensureInitialized();
      NetworkPlayerLeaveMessageMapper.ensureInitialized();
      NetworkUpdateMessageMapper.ensureInitialized();
      NetworkInitMessageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NetworkMessage';

  @override
  final MappableFields<NetworkMessage> fields = const {};

  static NetworkMessage _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('NetworkMessage');
  }

  @override
  final Function instantiate = _instantiate;

  static NetworkMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NetworkMessage>(map);
  }

  static NetworkMessage fromJson(String json) {
    return ensureInitialized().decodeJson<NetworkMessage>(json);
  }
}

mixin NetworkMessageMappable {
  String toJson();
  Map<String, dynamic> toMap();
  NetworkMessageCopyWith<NetworkMessage, NetworkMessage, NetworkMessage>
      get copyWith;
}

abstract class NetworkMessageCopyWith<$R, $In extends NetworkMessage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  NetworkMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class NetworkPlayerJoinMessageMapper
    extends ClassMapperBase<NetworkPlayerJoinMessage> {
  NetworkPlayerJoinMessageMapper._();

  static NetworkPlayerJoinMessageMapper? _instance;
  static NetworkPlayerJoinMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = NetworkPlayerJoinMessageMapper._());
      NetworkMessageMapper.ensureInitialized();
      NetworkingUserMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NetworkPlayerJoinMessage';

  static int _$id(NetworkPlayerJoinMessage v) => v.id;
  static const Field<NetworkPlayerJoinMessage, int> _f$id = Field('id', _$id);
  static NetworkingUser _$user(NetworkPlayerJoinMessage v) => v.user;
  static const Field<NetworkPlayerJoinMessage, NetworkingUser> _f$user =
      Field('user', _$user);

  @override
  final MappableFields<NetworkPlayerJoinMessage> fields = const {
    #id: _f$id,
    #user: _f$user,
  };

  static NetworkPlayerJoinMessage _instantiate(DecodingData data) {
    return NetworkPlayerJoinMessage(
        id: data.dec(_f$id), user: data.dec(_f$user));
  }

  @override
  final Function instantiate = _instantiate;

  static NetworkPlayerJoinMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NetworkPlayerJoinMessage>(map);
  }

  static NetworkPlayerJoinMessage fromJson(String json) {
    return ensureInitialized().decodeJson<NetworkPlayerJoinMessage>(json);
  }
}

mixin NetworkPlayerJoinMessageMappable {
  String toJson() {
    return NetworkPlayerJoinMessageMapper.ensureInitialized()
        .encodeJson<NetworkPlayerJoinMessage>(this as NetworkPlayerJoinMessage);
  }

  Map<String, dynamic> toMap() {
    return NetworkPlayerJoinMessageMapper.ensureInitialized()
        .encodeMap<NetworkPlayerJoinMessage>(this as NetworkPlayerJoinMessage);
  }

  NetworkPlayerJoinMessageCopyWith<NetworkPlayerJoinMessage,
          NetworkPlayerJoinMessage, NetworkPlayerJoinMessage>
      get copyWith => _NetworkPlayerJoinMessageCopyWithImpl(
          this as NetworkPlayerJoinMessage, $identity, $identity);
  @override
  String toString() {
    return NetworkPlayerJoinMessageMapper.ensureInitialized()
        .stringifyValue(this as NetworkPlayerJoinMessage);
  }

  @override
  bool operator ==(Object other) {
    return NetworkPlayerJoinMessageMapper.ensureInitialized()
        .equalsValue(this as NetworkPlayerJoinMessage, other);
  }

  @override
  int get hashCode {
    return NetworkPlayerJoinMessageMapper.ensureInitialized()
        .hashValue(this as NetworkPlayerJoinMessage);
  }
}

extension NetworkPlayerJoinMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NetworkPlayerJoinMessage, $Out> {
  NetworkPlayerJoinMessageCopyWith<$R, NetworkPlayerJoinMessage, $Out>
      get $asNetworkPlayerJoinMessage => $base
          .as((v, t, t2) => _NetworkPlayerJoinMessageCopyWithImpl(v, t, t2));
}

abstract class NetworkPlayerJoinMessageCopyWith<
    $R,
    $In extends NetworkPlayerJoinMessage,
    $Out> implements NetworkMessageCopyWith<$R, $In, $Out> {
  NetworkingUserCopyWith<$R, NetworkingUser, NetworkingUser> get user;
  @override
  $R call({int? id, NetworkingUser? user});
  NetworkPlayerJoinMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NetworkPlayerJoinMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NetworkPlayerJoinMessage, $Out>
    implements
        NetworkPlayerJoinMessageCopyWith<$R, NetworkPlayerJoinMessage, $Out> {
  _NetworkPlayerJoinMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NetworkPlayerJoinMessage> $mapper =
      NetworkPlayerJoinMessageMapper.ensureInitialized();
  @override
  NetworkingUserCopyWith<$R, NetworkingUser, NetworkingUser> get user =>
      $value.user.copyWith.$chain((v) => call(user: v));
  @override
  $R call({int? id, NetworkingUser? user}) => $apply(FieldCopyWithData(
      {if (id != null) #id: id, if (user != null) #user: user}));
  @override
  NetworkPlayerJoinMessage $make(CopyWithData data) => NetworkPlayerJoinMessage(
      id: data.get(#id, or: $value.id), user: data.get(#user, or: $value.user));

  @override
  NetworkPlayerJoinMessageCopyWith<$R2, NetworkPlayerJoinMessage, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _NetworkPlayerJoinMessageCopyWithImpl($value, $cast, t);
}

class NetworkPlayerLeaveMessageMapper
    extends ClassMapperBase<NetworkPlayerLeaveMessage> {
  NetworkPlayerLeaveMessageMapper._();

  static NetworkPlayerLeaveMessageMapper? _instance;
  static NetworkPlayerLeaveMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = NetworkPlayerLeaveMessageMapper._());
      NetworkMessageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NetworkPlayerLeaveMessage';

  static int _$id(NetworkPlayerLeaveMessage v) => v.id;
  static const Field<NetworkPlayerLeaveMessage, int> _f$id = Field('id', _$id);

  @override
  final MappableFields<NetworkPlayerLeaveMessage> fields = const {
    #id: _f$id,
  };

  static NetworkPlayerLeaveMessage _instantiate(DecodingData data) {
    return NetworkPlayerLeaveMessage(id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static NetworkPlayerLeaveMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NetworkPlayerLeaveMessage>(map);
  }

  static NetworkPlayerLeaveMessage fromJson(String json) {
    return ensureInitialized().decodeJson<NetworkPlayerLeaveMessage>(json);
  }
}

mixin NetworkPlayerLeaveMessageMappable {
  String toJson() {
    return NetworkPlayerLeaveMessageMapper.ensureInitialized()
        .encodeJson<NetworkPlayerLeaveMessage>(
            this as NetworkPlayerLeaveMessage);
  }

  Map<String, dynamic> toMap() {
    return NetworkPlayerLeaveMessageMapper.ensureInitialized()
        .encodeMap<NetworkPlayerLeaveMessage>(
            this as NetworkPlayerLeaveMessage);
  }

  NetworkPlayerLeaveMessageCopyWith<NetworkPlayerLeaveMessage,
          NetworkPlayerLeaveMessage, NetworkPlayerLeaveMessage>
      get copyWith => _NetworkPlayerLeaveMessageCopyWithImpl(
          this as NetworkPlayerLeaveMessage, $identity, $identity);
  @override
  String toString() {
    return NetworkPlayerLeaveMessageMapper.ensureInitialized()
        .stringifyValue(this as NetworkPlayerLeaveMessage);
  }

  @override
  bool operator ==(Object other) {
    return NetworkPlayerLeaveMessageMapper.ensureInitialized()
        .equalsValue(this as NetworkPlayerLeaveMessage, other);
  }

  @override
  int get hashCode {
    return NetworkPlayerLeaveMessageMapper.ensureInitialized()
        .hashValue(this as NetworkPlayerLeaveMessage);
  }
}

extension NetworkPlayerLeaveMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NetworkPlayerLeaveMessage, $Out> {
  NetworkPlayerLeaveMessageCopyWith<$R, NetworkPlayerLeaveMessage, $Out>
      get $asNetworkPlayerLeaveMessage => $base
          .as((v, t, t2) => _NetworkPlayerLeaveMessageCopyWithImpl(v, t, t2));
}

abstract class NetworkPlayerLeaveMessageCopyWith<
    $R,
    $In extends NetworkPlayerLeaveMessage,
    $Out> implements NetworkMessageCopyWith<$R, $In, $Out> {
  @override
  $R call({int? id});
  NetworkPlayerLeaveMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NetworkPlayerLeaveMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NetworkPlayerLeaveMessage, $Out>
    implements
        NetworkPlayerLeaveMessageCopyWith<$R, NetworkPlayerLeaveMessage, $Out> {
  _NetworkPlayerLeaveMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NetworkPlayerLeaveMessage> $mapper =
      NetworkPlayerLeaveMessageMapper.ensureInitialized();
  @override
  $R call({int? id}) => $apply(FieldCopyWithData({if (id != null) #id: id}));
  @override
  NetworkPlayerLeaveMessage $make(CopyWithData data) =>
      NetworkPlayerLeaveMessage(id: data.get(#id, or: $value.id));

  @override
  NetworkPlayerLeaveMessageCopyWith<$R2, NetworkPlayerLeaveMessage, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _NetworkPlayerLeaveMessageCopyWithImpl($value, $cast, t);
}

class NetworkUpdateMessageMapper extends ClassMapperBase<NetworkUpdateMessage> {
  NetworkUpdateMessageMapper._();

  static NetworkUpdateMessageMapper? _instance;
  static NetworkUpdateMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NetworkUpdateMessageMapper._());
      NetworkMessageMapper.ensureInitialized();
      PlayerStateMapper.ensureInitialized();
      _t$_R0Mapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NetworkUpdateMessage';

  static int _$id(NetworkUpdateMessage v) => v.id;
  static const Field<NetworkUpdateMessage, int> _f$id = Field('id', _$id);
  static String? _$name(NetworkUpdateMessage v) => v.name;
  static const Field<NetworkUpdateMessage, String> _f$name =
      Field('name', _$name, opt: true);
  static PlayerState? _$state(NetworkUpdateMessage v) => v.state;
  static const Field<NetworkUpdateMessage, PlayerState> _f$state =
      Field('state', _$state, opt: true);
  static _t$_R0<double, double>? _$position(NetworkUpdateMessage v) =>
      v.position;
  static const Field<NetworkUpdateMessage, _t$_R0<double, double>> _f$position =
      Field('position', _$position, opt: true);
  static _t$_R0<double, double>? _$velocity(NetworkUpdateMessage v) =>
      v.velocity;
  static const Field<NetworkUpdateMessage, _t$_R0<double, double>> _f$velocity =
      Field('velocity', _$velocity, opt: true);

  @override
  final MappableFields<NetworkUpdateMessage> fields = const {
    #id: _f$id,
    #name: _f$name,
    #state: _f$state,
    #position: _f$position,
    #velocity: _f$velocity,
  };

  static NetworkUpdateMessage _instantiate(DecodingData data) {
    return NetworkUpdateMessage(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        state: data.dec(_f$state),
        position: data.dec(_f$position),
        velocity: data.dec(_f$velocity));
  }

  @override
  final Function instantiate = _instantiate;

  static NetworkUpdateMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NetworkUpdateMessage>(map);
  }

  static NetworkUpdateMessage fromJson(String json) {
    return ensureInitialized().decodeJson<NetworkUpdateMessage>(json);
  }
}

mixin NetworkUpdateMessageMappable {
  String toJson() {
    return NetworkUpdateMessageMapper.ensureInitialized()
        .encodeJson<NetworkUpdateMessage>(this as NetworkUpdateMessage);
  }

  Map<String, dynamic> toMap() {
    return NetworkUpdateMessageMapper.ensureInitialized()
        .encodeMap<NetworkUpdateMessage>(this as NetworkUpdateMessage);
  }

  NetworkUpdateMessageCopyWith<NetworkUpdateMessage, NetworkUpdateMessage,
          NetworkUpdateMessage>
      get copyWith => _NetworkUpdateMessageCopyWithImpl(
          this as NetworkUpdateMessage, $identity, $identity);
  @override
  String toString() {
    return NetworkUpdateMessageMapper.ensureInitialized()
        .stringifyValue(this as NetworkUpdateMessage);
  }

  @override
  bool operator ==(Object other) {
    return NetworkUpdateMessageMapper.ensureInitialized()
        .equalsValue(this as NetworkUpdateMessage, other);
  }

  @override
  int get hashCode {
    return NetworkUpdateMessageMapper.ensureInitialized()
        .hashValue(this as NetworkUpdateMessage);
  }
}

extension NetworkUpdateMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NetworkUpdateMessage, $Out> {
  NetworkUpdateMessageCopyWith<$R, NetworkUpdateMessage, $Out>
      get $asNetworkUpdateMessage =>
          $base.as((v, t, t2) => _NetworkUpdateMessageCopyWithImpl(v, t, t2));
}

abstract class NetworkUpdateMessageCopyWith<
    $R,
    $In extends NetworkUpdateMessage,
    $Out> implements NetworkMessageCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {int? id,
      String? name,
      PlayerState? state,
      _t$_R0<double, double>? position,
      _t$_R0<double, double>? velocity});
  NetworkUpdateMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NetworkUpdateMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NetworkUpdateMessage, $Out>
    implements NetworkUpdateMessageCopyWith<$R, NetworkUpdateMessage, $Out> {
  _NetworkUpdateMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NetworkUpdateMessage> $mapper =
      NetworkUpdateMessageMapper.ensureInitialized();
  @override
  $R call(
          {int? id,
          Object? name = $none,
          Object? state = $none,
          Object? position = $none,
          Object? velocity = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != $none) #name: name,
        if (state != $none) #state: state,
        if (position != $none) #position: position,
        if (velocity != $none) #velocity: velocity
      }));
  @override
  NetworkUpdateMessage $make(CopyWithData data) => NetworkUpdateMessage(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      state: data.get(#state, or: $value.state),
      position: data.get(#position, or: $value.position),
      velocity: data.get(#velocity, or: $value.velocity));

  @override
  NetworkUpdateMessageCopyWith<$R2, NetworkUpdateMessage, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _NetworkUpdateMessageCopyWithImpl($value, $cast, t);
}

class NetworkInitMessageMapper extends ClassMapperBase<NetworkInitMessage> {
  NetworkInitMessageMapper._();

  static NetworkInitMessageMapper? _instance;
  static NetworkInitMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NetworkInitMessageMapper._());
      NetworkMessageMapper.ensureInitialized();
      NetworkingUserMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NetworkInitMessage';

  static Map<String, NetworkingUser> _$users(NetworkInitMessage v) => v.users;
  static const Field<NetworkInitMessage, Map<String, NetworkingUser>> _f$users =
      Field('users', _$users);

  @override
  final MappableFields<NetworkInitMessage> fields = const {
    #users: _f$users,
  };

  static NetworkInitMessage _instantiate(DecodingData data) {
    return NetworkInitMessage(users: data.dec(_f$users));
  }

  @override
  final Function instantiate = _instantiate;

  static NetworkInitMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NetworkInitMessage>(map);
  }

  static NetworkInitMessage fromJson(String json) {
    return ensureInitialized().decodeJson<NetworkInitMessage>(json);
  }
}

mixin NetworkInitMessageMappable {
  String toJson() {
    return NetworkInitMessageMapper.ensureInitialized()
        .encodeJson<NetworkInitMessage>(this as NetworkInitMessage);
  }

  Map<String, dynamic> toMap() {
    return NetworkInitMessageMapper.ensureInitialized()
        .encodeMap<NetworkInitMessage>(this as NetworkInitMessage);
  }

  NetworkInitMessageCopyWith<NetworkInitMessage, NetworkInitMessage,
          NetworkInitMessage>
      get copyWith => _NetworkInitMessageCopyWithImpl(
          this as NetworkInitMessage, $identity, $identity);
  @override
  String toString() {
    return NetworkInitMessageMapper.ensureInitialized()
        .stringifyValue(this as NetworkInitMessage);
  }

  @override
  bool operator ==(Object other) {
    return NetworkInitMessageMapper.ensureInitialized()
        .equalsValue(this as NetworkInitMessage, other);
  }

  @override
  int get hashCode {
    return NetworkInitMessageMapper.ensureInitialized()
        .hashValue(this as NetworkInitMessage);
  }
}

extension NetworkInitMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NetworkInitMessage, $Out> {
  NetworkInitMessageCopyWith<$R, NetworkInitMessage, $Out>
      get $asNetworkInitMessage =>
          $base.as((v, t, t2) => _NetworkInitMessageCopyWithImpl(v, t, t2));
}

abstract class NetworkInitMessageCopyWith<$R, $In extends NetworkInitMessage,
    $Out> implements NetworkMessageCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, NetworkingUser,
      NetworkingUserCopyWith<$R, NetworkingUser, NetworkingUser>> get users;
  @override
  $R call({Map<String, NetworkingUser>? users});
  NetworkInitMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NetworkInitMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NetworkInitMessage, $Out>
    implements NetworkInitMessageCopyWith<$R, NetworkInitMessage, $Out> {
  _NetworkInitMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NetworkInitMessage> $mapper =
      NetworkInitMessageMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, NetworkingUser,
          NetworkingUserCopyWith<$R, NetworkingUser, NetworkingUser>>
      get users => MapCopyWith(
          $value.users, (v, t) => v.copyWith.$chain(t), (v) => call(users: v));
  @override
  $R call({Map<String, NetworkingUser>? users}) =>
      $apply(FieldCopyWithData({if (users != null) #users: users}));
  @override
  NetworkInitMessage $make(CopyWithData data) =>
      NetworkInitMessage(users: data.get(#users, or: $value.users));

  @override
  NetworkInitMessageCopyWith<$R2, NetworkInitMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NetworkInitMessageCopyWithImpl($value, $cast, t);
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
