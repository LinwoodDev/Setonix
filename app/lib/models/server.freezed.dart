// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameServer _$GameServerFromJson(Map<String, dynamic> json) {
  return _GameServer.fromJson(json);
}

/// @nodoc
mixin _$GameServer {
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameServerCopyWith<GameServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameServerCopyWith<$Res> {
  factory $GameServerCopyWith(
          GameServer value, $Res Function(GameServer) then) =
      _$GameServerCopyWithImpl<$Res, GameServer>;
  @useResult
  $Res call({String name, String address, int port});
}

/// @nodoc
class _$GameServerCopyWithImpl<$Res, $Val extends GameServer>
    implements $GameServerCopyWith<$Res> {
  _$GameServerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? port = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameServerCopyWith<$Res>
    implements $GameServerCopyWith<$Res> {
  factory _$$_GameServerCopyWith(
          _$_GameServer value, $Res Function(_$_GameServer) then) =
      __$$_GameServerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String address, int port});
}

/// @nodoc
class __$$_GameServerCopyWithImpl<$Res>
    extends _$GameServerCopyWithImpl<$Res, _$_GameServer>
    implements _$$_GameServerCopyWith<$Res> {
  __$$_GameServerCopyWithImpl(
      _$_GameServer _value, $Res Function(_$_GameServer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? port = null,
  }) {
    return _then(_$_GameServer(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameServer extends _GameServer {
  const _$_GameServer({this.name = '', this.address = '', this.port = 0})
      : super._();

  factory _$_GameServer.fromJson(Map<String, dynamic> json) =>
      _$$_GameServerFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final int port;

  @override
  String toString() {
    return 'GameServer(name: $name, address: $address, port: $port)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameServer &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.port, port) || other.port == port));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, address, port);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameServerCopyWith<_$_GameServer> get copyWith =>
      __$$_GameServerCopyWithImpl<_$_GameServer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameServerToJson(
      this,
    );
  }
}

abstract class _GameServer extends GameServer {
  const factory _GameServer(
      {final String name,
      final String address,
      final int port}) = _$_GameServer;
  const _GameServer._() : super._();

  factory _GameServer.fromJson(Map<String, dynamic> json) =
      _$_GameServer.fromJson;

  @override
  String get name;
  @override
  String get address;
  @override
  int get port;
  @override
  @JsonKey(ignore: true)
  _$$_GameServerCopyWith<_$_GameServer> get copyWith =>
      throw _privateConstructorUsedError;
}
