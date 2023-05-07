// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClientConnectionMessage _$ClientConnectionMessageFromJson(
    Map<String, dynamic> json) {
  return FetchedPlayersClientConnectionMessage.fromJson(json);
}

/// @nodoc
mixin _$ClientConnectionMessage {
  List<GamePlayer> get players => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<GamePlayer> players) fetchedPlayers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<GamePlayer> players)? fetchedPlayers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<GamePlayer> players)? fetchedPlayers,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchedPlayersClientConnectionMessage value)
        fetchedPlayers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchedPlayersClientConnectionMessage value)?
        fetchedPlayers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchedPlayersClientConnectionMessage value)?
        fetchedPlayers,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientConnectionMessageCopyWith<ClientConnectionMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientConnectionMessageCopyWith<$Res> {
  factory $ClientConnectionMessageCopyWith(ClientConnectionMessage value,
          $Res Function(ClientConnectionMessage) then) =
      _$ClientConnectionMessageCopyWithImpl<$Res, ClientConnectionMessage>;
  @useResult
  $Res call({List<GamePlayer> players});
}

/// @nodoc
class _$ClientConnectionMessageCopyWithImpl<$Res,
        $Val extends ClientConnectionMessage>
    implements $ClientConnectionMessageCopyWith<$Res> {
  _$ClientConnectionMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? players = null,
  }) {
    return _then(_value.copyWith(
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<GamePlayer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FetchedPlayersClientConnectionMessageCopyWith<$Res>
    implements $ClientConnectionMessageCopyWith<$Res> {
  factory _$$FetchedPlayersClientConnectionMessageCopyWith(
          _$FetchedPlayersClientConnectionMessage value,
          $Res Function(_$FetchedPlayersClientConnectionMessage) then) =
      __$$FetchedPlayersClientConnectionMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GamePlayer> players});
}

/// @nodoc
class __$$FetchedPlayersClientConnectionMessageCopyWithImpl<$Res>
    extends _$ClientConnectionMessageCopyWithImpl<$Res,
        _$FetchedPlayersClientConnectionMessage>
    implements _$$FetchedPlayersClientConnectionMessageCopyWith<$Res> {
  __$$FetchedPlayersClientConnectionMessageCopyWithImpl(
      _$FetchedPlayersClientConnectionMessage _value,
      $Res Function(_$FetchedPlayersClientConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? players = null,
  }) {
    return _then(_$FetchedPlayersClientConnectionMessage(
      null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<GamePlayer>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FetchedPlayersClientConnectionMessage
    implements FetchedPlayersClientConnectionMessage {
  const _$FetchedPlayersClientConnectionMessage(final List<GamePlayer> players)
      : _players = players;

  factory _$FetchedPlayersClientConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$FetchedPlayersClientConnectionMessageFromJson(json);

  final List<GamePlayer> _players;
  @override
  List<GamePlayer> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  String toString() {
    return 'ClientConnectionMessage.fetchedPlayers(players: $players)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchedPlayersClientConnectionMessage &&
            const DeepCollectionEquality().equals(other._players, _players));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_players));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchedPlayersClientConnectionMessageCopyWith<
          _$FetchedPlayersClientConnectionMessage>
      get copyWith => __$$FetchedPlayersClientConnectionMessageCopyWithImpl<
          _$FetchedPlayersClientConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<GamePlayer> players) fetchedPlayers,
  }) {
    return fetchedPlayers(players);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<GamePlayer> players)? fetchedPlayers,
  }) {
    return fetchedPlayers?.call(players);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<GamePlayer> players)? fetchedPlayers,
    required TResult orElse(),
  }) {
    if (fetchedPlayers != null) {
      return fetchedPlayers(players);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchedPlayersClientConnectionMessage value)
        fetchedPlayers,
  }) {
    return fetchedPlayers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchedPlayersClientConnectionMessage value)?
        fetchedPlayers,
  }) {
    return fetchedPlayers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchedPlayersClientConnectionMessage value)?
        fetchedPlayers,
    required TResult orElse(),
  }) {
    if (fetchedPlayers != null) {
      return fetchedPlayers(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FetchedPlayersClientConnectionMessageToJson(
      this,
    );
  }
}

abstract class FetchedPlayersClientConnectionMessage
    implements ClientConnectionMessage {
  const factory FetchedPlayersClientConnectionMessage(
      final List<GamePlayer> players) = _$FetchedPlayersClientConnectionMessage;

  factory FetchedPlayersClientConnectionMessage.fromJson(
          Map<String, dynamic> json) =
      _$FetchedPlayersClientConnectionMessage.fromJson;

  @override
  List<GamePlayer> get players;
  @override
  @JsonKey(ignore: true)
  _$$FetchedPlayersClientConnectionMessageCopyWith<
          _$FetchedPlayersClientConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}
