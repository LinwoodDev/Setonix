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

/// @nodoc
mixin _$GameServer {
  String get address => throw _privateConstructorUsedError;
  GameProperty get property => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String address, GameProperty property) lan,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address, GameProperty property)? lan,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address, GameProperty property)? lan,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LanGameServer value) lan,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LanGameServer value)? lan,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LanGameServer value)? lan,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

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
  $Res call({String address, GameProperty property});

  $GamePropertyCopyWith<$Res> get property;
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
    Object? address = null,
    Object? property = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      property: null == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as GameProperty,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GamePropertyCopyWith<$Res> get property {
    return $GamePropertyCopyWith<$Res>(_value.property, (value) {
      return _then(_value.copyWith(property: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LanGameServerImplCopyWith<$Res>
    implements $GameServerCopyWith<$Res> {
  factory _$$LanGameServerImplCopyWith(
          _$LanGameServerImpl value, $Res Function(_$LanGameServerImpl) then) =
      __$$LanGameServerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, GameProperty property});

  @override
  $GamePropertyCopyWith<$Res> get property;
}

/// @nodoc
class __$$LanGameServerImplCopyWithImpl<$Res>
    extends _$GameServerCopyWithImpl<$Res, _$LanGameServerImpl>
    implements _$$LanGameServerImplCopyWith<$Res> {
  __$$LanGameServerImplCopyWithImpl(
      _$LanGameServerImpl _value, $Res Function(_$LanGameServerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? property = null,
  }) {
    return _then(_$LanGameServerImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      property: null == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as GameProperty,
    ));
  }
}

/// @nodoc

class _$LanGameServerImpl implements LanGameServer {
  const _$LanGameServerImpl({required this.address, required this.property});

  @override
  final String address;
  @override
  final GameProperty property;

  @override
  String toString() {
    return 'GameServer.lan(address: $address, property: $property)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanGameServerImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.property, property) ||
                other.property == property));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, property);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LanGameServerImplCopyWith<_$LanGameServerImpl> get copyWith =>
      __$$LanGameServerImplCopyWithImpl<_$LanGameServerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String address, GameProperty property) lan,
  }) {
    return lan(address, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address, GameProperty property)? lan,
  }) {
    return lan?.call(address, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address, GameProperty property)? lan,
    required TResult orElse(),
  }) {
    if (lan != null) {
      return lan(address, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LanGameServer value) lan,
  }) {
    return lan(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LanGameServer value)? lan,
  }) {
    return lan?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LanGameServer value)? lan,
    required TResult orElse(),
  }) {
    if (lan != null) {
      return lan(this);
    }
    return orElse();
  }
}

abstract class LanGameServer implements GameServer {
  const factory LanGameServer(
      {required final String address,
      required final GameProperty property}) = _$LanGameServerImpl;

  @override
  String get address;
  @override
  GameProperty get property;
  @override
  @JsonKey(ignore: true)
  _$$LanGameServerImplCopyWith<_$LanGameServerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GameProperty {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GamePropertyCopyWith<GameProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamePropertyCopyWith<$Res> {
  factory $GamePropertyCopyWith(
          GameProperty value, $Res Function(GameProperty) then) =
      _$GamePropertyCopyWithImpl<$Res, GameProperty>;
  @useResult
  $Res call({String name, String description});
}

/// @nodoc
class _$GamePropertyCopyWithImpl<$Res, $Val extends GameProperty>
    implements $GamePropertyCopyWith<$Res> {
  _$GamePropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GamePropertyImplCopyWith<$Res>
    implements $GamePropertyCopyWith<$Res> {
  factory _$$GamePropertyImplCopyWith(
          _$GamePropertyImpl value, $Res Function(_$GamePropertyImpl) then) =
      __$$GamePropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String description});
}

/// @nodoc
class __$$GamePropertyImplCopyWithImpl<$Res>
    extends _$GamePropertyCopyWithImpl<$Res, _$GamePropertyImpl>
    implements _$$GamePropertyImplCopyWith<$Res> {
  __$$GamePropertyImplCopyWithImpl(
      _$GamePropertyImpl _value, $Res Function(_$GamePropertyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_$GamePropertyImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GamePropertyImpl implements _GameProperty {
  const _$GamePropertyImpl({this.name = '', this.description = ''});

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'GameProperty(name: $name, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamePropertyImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GamePropertyImplCopyWith<_$GamePropertyImpl> get copyWith =>
      __$$GamePropertyImplCopyWithImpl<_$GamePropertyImpl>(this, _$identity);
}

abstract class _GameProperty implements GameProperty {
  const factory _GameProperty({final String name, final String description}) =
      _$GamePropertyImpl;

  @override
  String get name;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$GamePropertyImplCopyWith<_$GamePropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
