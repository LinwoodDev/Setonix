// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event.dart';

class NetworkingEventMapper extends ClassMapperBase<NetworkingEvent> {
  NetworkingEventMapper._();

  static NetworkingEventMapper? _instance;
  static NetworkingEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NetworkingEventMapper._());
      NetworkingMoveEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NetworkingEvent';

  @override
  final Map<Symbol, Field<NetworkingEvent, dynamic>> fields = const {};

  static NetworkingEvent _instantiate(DecodingData data) {
    return NetworkingEvent();
  }

  @override
  final Function instantiate = _instantiate;

  static NetworkingEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NetworkingEvent>(map);
  }

  static NetworkingEvent fromJson(String json) {
    return ensureInitialized().decodeJson<NetworkingEvent>(json);
  }
}

mixin NetworkingEventMappable {
  String toJson() {
    return NetworkingEventMapper.ensureInitialized()
        .encodeJson<NetworkingEvent>(this as NetworkingEvent);
  }

  Map<String, dynamic> toMap() {
    return NetworkingEventMapper.ensureInitialized()
        .encodeMap<NetworkingEvent>(this as NetworkingEvent);
  }

  NetworkingEventCopyWith<NetworkingEvent, NetworkingEvent, NetworkingEvent>
      get copyWith => _NetworkingEventCopyWithImpl(
          this as NetworkingEvent, $identity, $identity);
  @override
  String toString() {
    return NetworkingEventMapper.ensureInitialized()
        .stringifyValue(this as NetworkingEvent);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NetworkingEventMapper.ensureInitialized()
                .isValueEqual(this as NetworkingEvent, other));
  }

  @override
  int get hashCode {
    return NetworkingEventMapper.ensureInitialized()
        .hashValue(this as NetworkingEvent);
  }
}

extension NetworkingEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NetworkingEvent, $Out> {
  NetworkingEventCopyWith<$R, NetworkingEvent, $Out> get $asNetworkingEvent =>
      $base.as((v, t, t2) => _NetworkingEventCopyWithImpl(v, t, t2));
}

abstract class NetworkingEventCopyWith<$R, $In extends NetworkingEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  NetworkingEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NetworkingEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NetworkingEvent, $Out>
    implements NetworkingEventCopyWith<$R, NetworkingEvent, $Out> {
  _NetworkingEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NetworkingEvent> $mapper =
      NetworkingEventMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  NetworkingEvent $make(CopyWithData data) => NetworkingEvent();

  @override
  NetworkingEventCopyWith<$R2, NetworkingEvent, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NetworkingEventCopyWithImpl($value, $cast, t);
}

class NetworkingMoveEventMapper
    extends SubClassMapperBase<NetworkingMoveEvent> {
  NetworkingMoveEventMapper._();

  static NetworkingMoveEventMapper? _instance;
  static NetworkingMoveEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NetworkingMoveEventMapper._());
      NetworkingEventMapper.ensureInitialized().addSubMapper(_instance!);
      _t$_R0Mapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NetworkingMoveEvent';

  static _t$_R0<double, double> _$position(NetworkingMoveEvent v) => v.position;
  static const Field<NetworkingMoveEvent, _t$_R0<double, double>> _f$position =
      Field('position', _$position);
  static _t$_R0<double, double> _$velocity(NetworkingMoveEvent v) => v.velocity;
  static const Field<NetworkingMoveEvent, _t$_R0<double, double>> _f$velocity =
      Field('velocity', _$velocity);

  @override
  final Map<Symbol, Field<NetworkingMoveEvent, dynamic>> fields = const {
    #position: _f$position,
    #velocity: _f$velocity,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'move';
  @override
  late final ClassMapperBase superMapper =
      NetworkingEventMapper.ensureInitialized();

  static NetworkingMoveEvent _instantiate(DecodingData data) {
    return NetworkingMoveEvent(
        position: data.dec(_f$position), velocity: data.dec(_f$velocity));
  }

  @override
  final Function instantiate = _instantiate;

  static NetworkingMoveEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NetworkingMoveEvent>(map);
  }

  static NetworkingMoveEvent fromJson(String json) {
    return ensureInitialized().decodeJson<NetworkingMoveEvent>(json);
  }
}

mixin NetworkingMoveEventMappable {
  String toJson() {
    return NetworkingMoveEventMapper.ensureInitialized()
        .encodeJson<NetworkingMoveEvent>(this as NetworkingMoveEvent);
  }

  Map<String, dynamic> toMap() {
    return NetworkingMoveEventMapper.ensureInitialized()
        .encodeMap<NetworkingMoveEvent>(this as NetworkingMoveEvent);
  }

  NetworkingMoveEventCopyWith<NetworkingMoveEvent, NetworkingMoveEvent,
          NetworkingMoveEvent>
      get copyWith => _NetworkingMoveEventCopyWithImpl(
          this as NetworkingMoveEvent, $identity, $identity);
  @override
  String toString() {
    return NetworkingMoveEventMapper.ensureInitialized()
        .stringifyValue(this as NetworkingMoveEvent);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NetworkingMoveEventMapper.ensureInitialized()
                .isValueEqual(this as NetworkingMoveEvent, other));
  }

  @override
  int get hashCode {
    return NetworkingMoveEventMapper.ensureInitialized()
        .hashValue(this as NetworkingMoveEvent);
  }
}

extension NetworkingMoveEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NetworkingMoveEvent, $Out> {
  NetworkingMoveEventCopyWith<$R, NetworkingMoveEvent, $Out>
      get $asNetworkingMoveEvent =>
          $base.as((v, t, t2) => _NetworkingMoveEventCopyWithImpl(v, t, t2));
}

abstract class NetworkingMoveEventCopyWith<$R, $In extends NetworkingMoveEvent,
    $Out> implements NetworkingEventCopyWith<$R, $In, $Out> {
  @override
  $R call({_t$_R0<double, double>? position, _t$_R0<double, double>? velocity});
  NetworkingMoveEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NetworkingMoveEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NetworkingMoveEvent, $Out>
    implements NetworkingMoveEventCopyWith<$R, NetworkingMoveEvent, $Out> {
  _NetworkingMoveEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NetworkingMoveEvent> $mapper =
      NetworkingMoveEventMapper.ensureInitialized();
  @override
  $R call(
          {_t$_R0<double, double>? position,
          _t$_R0<double, double>? velocity}) =>
      $apply(FieldCopyWithData({
        if (position != null) #position: position,
        if (velocity != null) #velocity: velocity
      }));
  @override
  NetworkingMoveEvent $make(CopyWithData data) => NetworkingMoveEvent(
      position: data.get(#position, or: $value.position),
      velocity: data.get(#velocity, or: $value.velocity));

  @override
  NetworkingMoveEventCopyWith<$R2, NetworkingMoveEvent, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _NetworkingMoveEventCopyWithImpl($value, $cast, t);
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
  final Map<Symbol, Field<_t$_R0, dynamic>> fields = const {
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
