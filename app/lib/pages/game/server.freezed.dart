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

ServerConnectionMessage _$ServerConnectionMessageFromJson(
    Map<String, dynamic> json) {
  return FetchPlayersServerConnectionMessage.fromJson(json);
}

/// @nodoc
mixin _$ServerConnectionMessage {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPlayersServerConnectionMessage value)
        fetchPlayers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerConnectionMessageCopyWith<$Res> {
  factory $ServerConnectionMessageCopyWith(ServerConnectionMessage value,
          $Res Function(ServerConnectionMessage) then) =
      _$ServerConnectionMessageCopyWithImpl<$Res, ServerConnectionMessage>;
}

/// @nodoc
class _$ServerConnectionMessageCopyWithImpl<$Res,
        $Val extends ServerConnectionMessage>
    implements $ServerConnectionMessageCopyWith<$Res> {
  _$ServerConnectionMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FetchPlayersServerConnectionMessageCopyWith<$Res> {
  factory _$$FetchPlayersServerConnectionMessageCopyWith(
          _$FetchPlayersServerConnectionMessage value,
          $Res Function(_$FetchPlayersServerConnectionMessage) then) =
      __$$FetchPlayersServerConnectionMessageCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchPlayersServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$FetchPlayersServerConnectionMessage>
    implements _$$FetchPlayersServerConnectionMessageCopyWith<$Res> {
  __$$FetchPlayersServerConnectionMessageCopyWithImpl(
      _$FetchPlayersServerConnectionMessage _value,
      $Res Function(_$FetchPlayersServerConnectionMessage) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$FetchPlayersServerConnectionMessage
    implements FetchPlayersServerConnectionMessage {
  const _$FetchPlayersServerConnectionMessage();

  factory _$FetchPlayersServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$FetchPlayersServerConnectionMessageFromJson(json);

  @override
  String toString() {
    return 'ServerConnectionMessage.fetchPlayers()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchPlayersServerConnectionMessage);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
  }) {
    return fetchPlayers();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
  }) {
    return fetchPlayers?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    required TResult orElse(),
  }) {
    if (fetchPlayers != null) {
      return fetchPlayers();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPlayersServerConnectionMessage value)
        fetchPlayers,
  }) {
    return fetchPlayers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
  }) {
    return fetchPlayers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    required TResult orElse(),
  }) {
    if (fetchPlayers != null) {
      return fetchPlayers(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FetchPlayersServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class FetchPlayersServerConnectionMessage
    implements ServerConnectionMessage {
  const factory FetchPlayersServerConnectionMessage() =
      _$FetchPlayersServerConnectionMessage;

  factory FetchPlayersServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =
      _$FetchPlayersServerConnectionMessage.fromJson;
}
