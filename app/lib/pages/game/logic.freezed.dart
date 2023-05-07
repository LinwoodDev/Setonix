// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GamePlayer _$GamePlayerFromJson(Map<String, dynamic> json) {
  return _GamePlayer.fromJson(json);
}

/// @nodoc
mixin _$GamePlayer {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GamePlayerCopyWith<GamePlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamePlayerCopyWith<$Res> {
  factory $GamePlayerCopyWith(
          GamePlayer value, $Res Function(GamePlayer) then) =
      _$GamePlayerCopyWithImpl<$Res, GamePlayer>;
  @useResult
  $Res call({String name, String id});
}

/// @nodoc
class _$GamePlayerCopyWithImpl<$Res, $Val extends GamePlayer>
    implements $GamePlayerCopyWith<$Res> {
  _$GamePlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GamePlayerCopyWith<$Res>
    implements $GamePlayerCopyWith<$Res> {
  factory _$$_GamePlayerCopyWith(
          _$_GamePlayer value, $Res Function(_$_GamePlayer) then) =
      __$$_GamePlayerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String id});
}

/// @nodoc
class __$$_GamePlayerCopyWithImpl<$Res>
    extends _$GamePlayerCopyWithImpl<$Res, _$_GamePlayer>
    implements _$$_GamePlayerCopyWith<$Res> {
  __$$_GamePlayerCopyWithImpl(
      _$_GamePlayer _value, $Res Function(_$_GamePlayer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_$_GamePlayer(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GamePlayer implements _GamePlayer {
  const _$_GamePlayer({required this.name, required this.id});

  factory _$_GamePlayer.fromJson(Map<String, dynamic> json) =>
      _$$_GamePlayerFromJson(json);

  @override
  final String name;
  @override
  final String id;

  @override
  String toString() {
    return 'GamePlayer(name: $name, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GamePlayer &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GamePlayerCopyWith<_$_GamePlayer> get copyWith =>
      __$$_GamePlayerCopyWithImpl<_$_GamePlayer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GamePlayerToJson(
      this,
    );
  }
}

abstract class _GamePlayer implements GamePlayer {
  const factory _GamePlayer(
      {required final String name, required final String id}) = _$_GamePlayer;

  factory _GamePlayer.fromJson(Map<String, dynamic> json) =
      _$_GamePlayer.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_GamePlayerCopyWith<_$_GamePlayer> get copyWith =>
      throw _privateConstructorUsedError;
}
