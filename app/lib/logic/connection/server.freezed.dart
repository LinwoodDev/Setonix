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
  switch (json['runtimeType']) {
    case 'fetchPlayers':
      return FetchPlayersServerConnectionMessage.fromJson(json);
    case 'chatMessage':
      return ChatMessageServerConnectionMessage.fromJson(json);
    case 'addDeck':
      return AddDeckServerConnectionMessage.fromJson(json);
    case 'removeDeck':
      return RemoveDeckServerConnectionMessage.fromJson(json);
    case 'addSeat':
      return AddSeatServerConnectionMessage.fromJson(json);
    case 'removeSeat':
      return RemoveSeatServerConnectionMessage.fromJson(json);
    case 'joinSeat':
      return JoinSeatServerConnectionMessage.fromJson(json);
    case 'leaveSeat':
      return LeaveSeatServerConnectionMessage.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'ServerConnectionMessage',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ServerConnectionMessage {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck) addDeck,
    required TResult Function(int index) removeDeck,
    required TResult Function(String name, List<GameDeck> decks) addSeat,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck)? addDeck,
    TResult? Function(int index)? removeDeck,
    TResult? Function(String name, List<GameDeck> decks)? addSeat,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck)? addDeck,
    TResult Function(int index)? removeDeck,
    TResult Function(String name, List<GameDeck> decks)? addSeat,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPlayersServerConnectionMessage value)
        fetchPlayers,
    required TResult Function(ChatMessageServerConnectionMessage value)
        chatMessage,
    required TResult Function(AddDeckServerConnectionMessage value) addDeck,
    required TResult Function(RemoveDeckServerConnectionMessage value)
        removeDeck,
    required TResult Function(AddSeatServerConnectionMessage value) addSeat,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
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
  const _$FetchPlayersServerConnectionMessage({final String? $type})
      : $type = $type ?? 'fetchPlayers';

  factory _$FetchPlayersServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$FetchPlayersServerConnectionMessageFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

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
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck) addDeck,
    required TResult Function(int index) removeDeck,
    required TResult Function(String name, List<GameDeck> decks) addSeat,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return fetchPlayers();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck)? addDeck,
    TResult? Function(int index)? removeDeck,
    TResult? Function(String name, List<GameDeck> decks)? addSeat,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return fetchPlayers?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck)? addDeck,
    TResult Function(int index)? removeDeck,
    TResult Function(String name, List<GameDeck> decks)? addSeat,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
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
    required TResult Function(ChatMessageServerConnectionMessage value)
        chatMessage,
    required TResult Function(AddDeckServerConnectionMessage value) addDeck,
    required TResult Function(RemoveDeckServerConnectionMessage value)
        removeDeck,
    required TResult Function(AddSeatServerConnectionMessage value) addSeat,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return fetchPlayers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return fetchPlayers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
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

/// @nodoc
abstract class _$$ChatMessageServerConnectionMessageCopyWith<$Res> {
  factory _$$ChatMessageServerConnectionMessageCopyWith(
          _$ChatMessageServerConnectionMessage value,
          $Res Function(_$ChatMessageServerConnectionMessage) then) =
      __$$ChatMessageServerConnectionMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ChatMessageServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$ChatMessageServerConnectionMessage>
    implements _$$ChatMessageServerConnectionMessageCopyWith<$Res> {
  __$$ChatMessageServerConnectionMessageCopyWithImpl(
      _$ChatMessageServerConnectionMessage _value,
      $Res Function(_$ChatMessageServerConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ChatMessageServerConnectionMessage(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageServerConnectionMessage
    implements ChatMessageServerConnectionMessage {
  const _$ChatMessageServerConnectionMessage(this.message,
      {final String? $type})
      : $type = $type ?? 'chatMessage';

  factory _$ChatMessageServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$ChatMessageServerConnectionMessageFromJson(json);

  @override
  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.chatMessage(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageServerConnectionMessage &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageServerConnectionMessageCopyWith<
          _$ChatMessageServerConnectionMessage>
      get copyWith => __$$ChatMessageServerConnectionMessageCopyWithImpl<
          _$ChatMessageServerConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck) addDeck,
    required TResult Function(int index) removeDeck,
    required TResult Function(String name, List<GameDeck> decks) addSeat,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return chatMessage(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck)? addDeck,
    TResult? Function(int index)? removeDeck,
    TResult? Function(String name, List<GameDeck> decks)? addSeat,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return chatMessage?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck)? addDeck,
    TResult Function(int index)? removeDeck,
    TResult Function(String name, List<GameDeck> decks)? addSeat,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (chatMessage != null) {
      return chatMessage(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPlayersServerConnectionMessage value)
        fetchPlayers,
    required TResult Function(ChatMessageServerConnectionMessage value)
        chatMessage,
    required TResult Function(AddDeckServerConnectionMessage value) addDeck,
    required TResult Function(RemoveDeckServerConnectionMessage value)
        removeDeck,
    required TResult Function(AddSeatServerConnectionMessage value) addSeat,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return chatMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return chatMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
    required TResult orElse(),
  }) {
    if (chatMessage != null) {
      return chatMessage(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class ChatMessageServerConnectionMessage
    implements ServerConnectionMessage {
  const factory ChatMessageServerConnectionMessage(final String message) =
      _$ChatMessageServerConnectionMessage;

  factory ChatMessageServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =
      _$ChatMessageServerConnectionMessage.fromJson;

  String get message;
  @JsonKey(ignore: true)
  _$$ChatMessageServerConnectionMessageCopyWith<
          _$ChatMessageServerConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddDeckServerConnectionMessageCopyWith<$Res> {
  factory _$$AddDeckServerConnectionMessageCopyWith(
          _$AddDeckServerConnectionMessage value,
          $Res Function(_$AddDeckServerConnectionMessage) then) =
      __$$AddDeckServerConnectionMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({GameDeck deck});

  $GameDeckCopyWith<$Res> get deck;
}

/// @nodoc
class __$$AddDeckServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$AddDeckServerConnectionMessage>
    implements _$$AddDeckServerConnectionMessageCopyWith<$Res> {
  __$$AddDeckServerConnectionMessageCopyWithImpl(
      _$AddDeckServerConnectionMessage _value,
      $Res Function(_$AddDeckServerConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deck = null,
  }) {
    return _then(_$AddDeckServerConnectionMessage(
      null == deck
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as GameDeck,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $GameDeckCopyWith<$Res> get deck {
    return $GameDeckCopyWith<$Res>(_value.deck, (value) {
      return _then(_value.copyWith(deck: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AddDeckServerConnectionMessage
    implements AddDeckServerConnectionMessage {
  const _$AddDeckServerConnectionMessage(this.deck, {final String? $type})
      : $type = $type ?? 'addDeck';

  factory _$AddDeckServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$AddDeckServerConnectionMessageFromJson(json);

  @override
  final GameDeck deck;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.addDeck(deck: $deck)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddDeckServerConnectionMessage &&
            (identical(other.deck, deck) || other.deck == deck));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, deck);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddDeckServerConnectionMessageCopyWith<_$AddDeckServerConnectionMessage>
      get copyWith => __$$AddDeckServerConnectionMessageCopyWithImpl<
          _$AddDeckServerConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck) addDeck,
    required TResult Function(int index) removeDeck,
    required TResult Function(String name, List<GameDeck> decks) addSeat,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return addDeck(deck);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck)? addDeck,
    TResult? Function(int index)? removeDeck,
    TResult? Function(String name, List<GameDeck> decks)? addSeat,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return addDeck?.call(deck);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck)? addDeck,
    TResult Function(int index)? removeDeck,
    TResult Function(String name, List<GameDeck> decks)? addSeat,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (addDeck != null) {
      return addDeck(deck);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPlayersServerConnectionMessage value)
        fetchPlayers,
    required TResult Function(ChatMessageServerConnectionMessage value)
        chatMessage,
    required TResult Function(AddDeckServerConnectionMessage value) addDeck,
    required TResult Function(RemoveDeckServerConnectionMessage value)
        removeDeck,
    required TResult Function(AddSeatServerConnectionMessage value) addSeat,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return addDeck(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return addDeck?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
    required TResult orElse(),
  }) {
    if (addDeck != null) {
      return addDeck(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AddDeckServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class AddDeckServerConnectionMessage
    implements ServerConnectionMessage {
  const factory AddDeckServerConnectionMessage(final GameDeck deck) =
      _$AddDeckServerConnectionMessage;

  factory AddDeckServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$AddDeckServerConnectionMessage.fromJson;

  GameDeck get deck;
  @JsonKey(ignore: true)
  _$$AddDeckServerConnectionMessageCopyWith<_$AddDeckServerConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveDeckServerConnectionMessageCopyWith<$Res> {
  factory _$$RemoveDeckServerConnectionMessageCopyWith(
          _$RemoveDeckServerConnectionMessage value,
          $Res Function(_$RemoveDeckServerConnectionMessage) then) =
      __$$RemoveDeckServerConnectionMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$RemoveDeckServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$RemoveDeckServerConnectionMessage>
    implements _$$RemoveDeckServerConnectionMessageCopyWith<$Res> {
  __$$RemoveDeckServerConnectionMessageCopyWithImpl(
      _$RemoveDeckServerConnectionMessage _value,
      $Res Function(_$RemoveDeckServerConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$RemoveDeckServerConnectionMessage(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoveDeckServerConnectionMessage
    implements RemoveDeckServerConnectionMessage {
  const _$RemoveDeckServerConnectionMessage(this.index, {final String? $type})
      : $type = $type ?? 'removeDeck';

  factory _$RemoveDeckServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$RemoveDeckServerConnectionMessageFromJson(json);

  @override
  final int index;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.removeDeck(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveDeckServerConnectionMessage &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveDeckServerConnectionMessageCopyWith<
          _$RemoveDeckServerConnectionMessage>
      get copyWith => __$$RemoveDeckServerConnectionMessageCopyWithImpl<
          _$RemoveDeckServerConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck) addDeck,
    required TResult Function(int index) removeDeck,
    required TResult Function(String name, List<GameDeck> decks) addSeat,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return removeDeck(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck)? addDeck,
    TResult? Function(int index)? removeDeck,
    TResult? Function(String name, List<GameDeck> decks)? addSeat,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return removeDeck?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck)? addDeck,
    TResult Function(int index)? removeDeck,
    TResult Function(String name, List<GameDeck> decks)? addSeat,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (removeDeck != null) {
      return removeDeck(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPlayersServerConnectionMessage value)
        fetchPlayers,
    required TResult Function(ChatMessageServerConnectionMessage value)
        chatMessage,
    required TResult Function(AddDeckServerConnectionMessage value) addDeck,
    required TResult Function(RemoveDeckServerConnectionMessage value)
        removeDeck,
    required TResult Function(AddSeatServerConnectionMessage value) addSeat,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return removeDeck(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return removeDeck?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
    required TResult orElse(),
  }) {
    if (removeDeck != null) {
      return removeDeck(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoveDeckServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class RemoveDeckServerConnectionMessage
    implements ServerConnectionMessage {
  const factory RemoveDeckServerConnectionMessage(final int index) =
      _$RemoveDeckServerConnectionMessage;

  factory RemoveDeckServerConnectionMessage.fromJson(
      Map<String, dynamic> json) = _$RemoveDeckServerConnectionMessage.fromJson;

  int get index;
  @JsonKey(ignore: true)
  _$$RemoveDeckServerConnectionMessageCopyWith<
          _$RemoveDeckServerConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddSeatServerConnectionMessageCopyWith<$Res> {
  factory _$$AddSeatServerConnectionMessageCopyWith(
          _$AddSeatServerConnectionMessage value,
          $Res Function(_$AddSeatServerConnectionMessage) then) =
      __$$AddSeatServerConnectionMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, List<GameDeck> decks});
}

/// @nodoc
class __$$AddSeatServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$AddSeatServerConnectionMessage>
    implements _$$AddSeatServerConnectionMessageCopyWith<$Res> {
  __$$AddSeatServerConnectionMessageCopyWithImpl(
      _$AddSeatServerConnectionMessage _value,
      $Res Function(_$AddSeatServerConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? decks = null,
  }) {
    return _then(_$AddSeatServerConnectionMessage(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == decks
          ? _value._decks
          : decks // ignore: cast_nullable_to_non_nullable
              as List<GameDeck>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddSeatServerConnectionMessage
    implements AddSeatServerConnectionMessage {
  const _$AddSeatServerConnectionMessage(this.name,
      [final List<GameDeck> decks = const [], final String? $type])
      : _decks = decks,
        $type = $type ?? 'addSeat';

  factory _$AddSeatServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$AddSeatServerConnectionMessageFromJson(json);

  @override
  final String name;
  final List<GameDeck> _decks;
  @override
  @JsonKey()
  List<GameDeck> get decks {
    if (_decks is EqualUnmodifiableListView) return _decks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_decks);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.addSeat(name: $name, decks: $decks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddSeatServerConnectionMessage &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._decks, _decks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_decks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddSeatServerConnectionMessageCopyWith<_$AddSeatServerConnectionMessage>
      get copyWith => __$$AddSeatServerConnectionMessageCopyWithImpl<
          _$AddSeatServerConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck) addDeck,
    required TResult Function(int index) removeDeck,
    required TResult Function(String name, List<GameDeck> decks) addSeat,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return addSeat(name, decks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck)? addDeck,
    TResult? Function(int index)? removeDeck,
    TResult? Function(String name, List<GameDeck> decks)? addSeat,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return addSeat?.call(name, decks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck)? addDeck,
    TResult Function(int index)? removeDeck,
    TResult Function(String name, List<GameDeck> decks)? addSeat,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (addSeat != null) {
      return addSeat(name, decks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPlayersServerConnectionMessage value)
        fetchPlayers,
    required TResult Function(ChatMessageServerConnectionMessage value)
        chatMessage,
    required TResult Function(AddDeckServerConnectionMessage value) addDeck,
    required TResult Function(RemoveDeckServerConnectionMessage value)
        removeDeck,
    required TResult Function(AddSeatServerConnectionMessage value) addSeat,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return addSeat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return addSeat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
    required TResult orElse(),
  }) {
    if (addSeat != null) {
      return addSeat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AddSeatServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class AddSeatServerConnectionMessage
    implements ServerConnectionMessage {
  const factory AddSeatServerConnectionMessage(final String name,
      [final List<GameDeck> decks]) = _$AddSeatServerConnectionMessage;

  factory AddSeatServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$AddSeatServerConnectionMessage.fromJson;

  String get name;
  List<GameDeck> get decks;
  @JsonKey(ignore: true)
  _$$AddSeatServerConnectionMessageCopyWith<_$AddSeatServerConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveSeatServerConnectionMessageCopyWith<$Res> {
  factory _$$RemoveSeatServerConnectionMessageCopyWith(
          _$RemoveSeatServerConnectionMessage value,
          $Res Function(_$RemoveSeatServerConnectionMessage) then) =
      __$$RemoveSeatServerConnectionMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$RemoveSeatServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$RemoveSeatServerConnectionMessage>
    implements _$$RemoveSeatServerConnectionMessageCopyWith<$Res> {
  __$$RemoveSeatServerConnectionMessageCopyWithImpl(
      _$RemoveSeatServerConnectionMessage _value,
      $Res Function(_$RemoveSeatServerConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$RemoveSeatServerConnectionMessage(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoveSeatServerConnectionMessage
    implements RemoveSeatServerConnectionMessage {
  const _$RemoveSeatServerConnectionMessage(this.index, {final String? $type})
      : $type = $type ?? 'removeSeat';

  factory _$RemoveSeatServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$RemoveSeatServerConnectionMessageFromJson(json);

  @override
  final int index;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.removeSeat(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveSeatServerConnectionMessage &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveSeatServerConnectionMessageCopyWith<
          _$RemoveSeatServerConnectionMessage>
      get copyWith => __$$RemoveSeatServerConnectionMessageCopyWithImpl<
          _$RemoveSeatServerConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck) addDeck,
    required TResult Function(int index) removeDeck,
    required TResult Function(String name, List<GameDeck> decks) addSeat,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return removeSeat(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck)? addDeck,
    TResult? Function(int index)? removeDeck,
    TResult? Function(String name, List<GameDeck> decks)? addSeat,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return removeSeat?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck)? addDeck,
    TResult Function(int index)? removeDeck,
    TResult Function(String name, List<GameDeck> decks)? addSeat,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (removeSeat != null) {
      return removeSeat(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPlayersServerConnectionMessage value)
        fetchPlayers,
    required TResult Function(ChatMessageServerConnectionMessage value)
        chatMessage,
    required TResult Function(AddDeckServerConnectionMessage value) addDeck,
    required TResult Function(RemoveDeckServerConnectionMessage value)
        removeDeck,
    required TResult Function(AddSeatServerConnectionMessage value) addSeat,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return removeSeat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return removeSeat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
    required TResult orElse(),
  }) {
    if (removeSeat != null) {
      return removeSeat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoveSeatServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class RemoveSeatServerConnectionMessage
    implements ServerConnectionMessage {
  const factory RemoveSeatServerConnectionMessage(final int index) =
      _$RemoveSeatServerConnectionMessage;

  factory RemoveSeatServerConnectionMessage.fromJson(
      Map<String, dynamic> json) = _$RemoveSeatServerConnectionMessage.fromJson;

  int get index;
  @JsonKey(ignore: true)
  _$$RemoveSeatServerConnectionMessageCopyWith<
          _$RemoveSeatServerConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$JoinSeatServerConnectionMessageCopyWith<$Res> {
  factory _$$JoinSeatServerConnectionMessageCopyWith(
          _$JoinSeatServerConnectionMessage value,
          $Res Function(_$JoinSeatServerConnectionMessage) then) =
      __$$JoinSeatServerConnectionMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$JoinSeatServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$JoinSeatServerConnectionMessage>
    implements _$$JoinSeatServerConnectionMessageCopyWith<$Res> {
  __$$JoinSeatServerConnectionMessageCopyWithImpl(
      _$JoinSeatServerConnectionMessage _value,
      $Res Function(_$JoinSeatServerConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$JoinSeatServerConnectionMessage(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinSeatServerConnectionMessage
    implements JoinSeatServerConnectionMessage {
  const _$JoinSeatServerConnectionMessage(this.index, {final String? $type})
      : $type = $type ?? 'joinSeat';

  factory _$JoinSeatServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$JoinSeatServerConnectionMessageFromJson(json);

  @override
  final int index;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.joinSeat(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinSeatServerConnectionMessage &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinSeatServerConnectionMessageCopyWith<_$JoinSeatServerConnectionMessage>
      get copyWith => __$$JoinSeatServerConnectionMessageCopyWithImpl<
          _$JoinSeatServerConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck) addDeck,
    required TResult Function(int index) removeDeck,
    required TResult Function(String name, List<GameDeck> decks) addSeat,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return joinSeat(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck)? addDeck,
    TResult? Function(int index)? removeDeck,
    TResult? Function(String name, List<GameDeck> decks)? addSeat,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return joinSeat?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck)? addDeck,
    TResult Function(int index)? removeDeck,
    TResult Function(String name, List<GameDeck> decks)? addSeat,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (joinSeat != null) {
      return joinSeat(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPlayersServerConnectionMessage value)
        fetchPlayers,
    required TResult Function(ChatMessageServerConnectionMessage value)
        chatMessage,
    required TResult Function(AddDeckServerConnectionMessage value) addDeck,
    required TResult Function(RemoveDeckServerConnectionMessage value)
        removeDeck,
    required TResult Function(AddSeatServerConnectionMessage value) addSeat,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return joinSeat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return joinSeat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
    required TResult orElse(),
  }) {
    if (joinSeat != null) {
      return joinSeat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinSeatServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class JoinSeatServerConnectionMessage
    implements ServerConnectionMessage {
  const factory JoinSeatServerConnectionMessage(final int index) =
      _$JoinSeatServerConnectionMessage;

  factory JoinSeatServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$JoinSeatServerConnectionMessage.fromJson;

  int get index;
  @JsonKey(ignore: true)
  _$$JoinSeatServerConnectionMessageCopyWith<_$JoinSeatServerConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LeaveSeatServerConnectionMessageCopyWith<$Res> {
  factory _$$LeaveSeatServerConnectionMessageCopyWith(
          _$LeaveSeatServerConnectionMessage value,
          $Res Function(_$LeaveSeatServerConnectionMessage) then) =
      __$$LeaveSeatServerConnectionMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$LeaveSeatServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$LeaveSeatServerConnectionMessage>
    implements _$$LeaveSeatServerConnectionMessageCopyWith<$Res> {
  __$$LeaveSeatServerConnectionMessageCopyWithImpl(
      _$LeaveSeatServerConnectionMessage _value,
      $Res Function(_$LeaveSeatServerConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$LeaveSeatServerConnectionMessage(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveSeatServerConnectionMessage
    implements LeaveSeatServerConnectionMessage {
  const _$LeaveSeatServerConnectionMessage(this.index, {final String? $type})
      : $type = $type ?? 'leaveSeat';

  factory _$LeaveSeatServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$LeaveSeatServerConnectionMessageFromJson(json);

  @override
  final int index;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.leaveSeat(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveSeatServerConnectionMessage &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveSeatServerConnectionMessageCopyWith<
          _$LeaveSeatServerConnectionMessage>
      get copyWith => __$$LeaveSeatServerConnectionMessageCopyWithImpl<
          _$LeaveSeatServerConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck) addDeck,
    required TResult Function(int index) removeDeck,
    required TResult Function(String name, List<GameDeck> decks) addSeat,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return leaveSeat(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck)? addDeck,
    TResult? Function(int index)? removeDeck,
    TResult? Function(String name, List<GameDeck> decks)? addSeat,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return leaveSeat?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck)? addDeck,
    TResult Function(int index)? removeDeck,
    TResult Function(String name, List<GameDeck> decks)? addSeat,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (leaveSeat != null) {
      return leaveSeat(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPlayersServerConnectionMessage value)
        fetchPlayers,
    required TResult Function(ChatMessageServerConnectionMessage value)
        chatMessage,
    required TResult Function(AddDeckServerConnectionMessage value) addDeck,
    required TResult Function(RemoveDeckServerConnectionMessage value)
        removeDeck,
    required TResult Function(AddSeatServerConnectionMessage value) addSeat,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return leaveSeat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return leaveSeat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
    required TResult orElse(),
  }) {
    if (leaveSeat != null) {
      return leaveSeat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveSeatServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class LeaveSeatServerConnectionMessage
    implements ServerConnectionMessage {
  const factory LeaveSeatServerConnectionMessage(final int index) =
      _$LeaveSeatServerConnectionMessage;

  factory LeaveSeatServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$LeaveSeatServerConnectionMessage.fromJson;

  int get index;
  @JsonKey(ignore: true)
  _$$LeaveSeatServerConnectionMessageCopyWith<
          _$LeaveSeatServerConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}
