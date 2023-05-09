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
  switch (json['type']) {
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
    case 'addCards':
      return AddCardsServerConnectionMessage.fromJson(json);
    case 'putCards':
      return PutCardsServerConnectionMessage.fromJson(json);
    case 'removeCards':
      return RemoveCardsServerConnectionMessage.fromJson(json);
    case 'removeSeat':
      return RemoveSeatServerConnectionMessage.fromJson(json);
    case 'joinSeat':
      return JoinSeatServerConnectionMessage.fromJson(json);
    case 'leaveSeat':
      return LeaveSeatServerConnectionMessage.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'ServerConnectionMessage',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$ServerConnectionMessage {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
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
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
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

  @JsonKey(name: 'type')
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
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
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
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
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
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
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
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
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

  @JsonKey(name: 'type')
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
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
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
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
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
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
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
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
  $Res call({GameDeck deck, int? seatIndex});

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
    Object? seatIndex = freezed,
  }) {
    return _then(_$AddDeckServerConnectionMessage(
      null == deck
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as GameDeck,
      freezed == seatIndex
          ? _value.seatIndex
          : seatIndex // ignore: cast_nullable_to_non_nullable
              as int?,
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
  const _$AddDeckServerConnectionMessage(this.deck, this.seatIndex,
      {final String? $type})
      : $type = $type ?? 'addDeck';

  factory _$AddDeckServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$AddDeckServerConnectionMessageFromJson(json);

  @override
  final GameDeck deck;
  @override
  final int? seatIndex;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.addDeck(deck: $deck, seatIndex: $seatIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddDeckServerConnectionMessage &&
            (identical(other.deck, deck) || other.deck == deck) &&
            (identical(other.seatIndex, seatIndex) ||
                other.seatIndex == seatIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, deck, seatIndex);

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
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return addDeck(deck, seatIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return addDeck?.call(deck, seatIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (addDeck != null) {
      return addDeck(deck, seatIndex);
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
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
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
  const factory AddDeckServerConnectionMessage(
          final GameDeck deck, final int? seatIndex) =
      _$AddDeckServerConnectionMessage;

  factory AddDeckServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$AddDeckServerConnectionMessage.fromJson;

  GameDeck get deck;
  int? get seatIndex;
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
  $Res call({int index, int? seatIndex});
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
    Object? seatIndex = freezed,
  }) {
    return _then(_$RemoveDeckServerConnectionMessage(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == seatIndex
          ? _value.seatIndex
          : seatIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoveDeckServerConnectionMessage
    implements RemoveDeckServerConnectionMessage {
  const _$RemoveDeckServerConnectionMessage(this.index, this.seatIndex,
      {final String? $type})
      : $type = $type ?? 'removeDeck';

  factory _$RemoveDeckServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$RemoveDeckServerConnectionMessageFromJson(json);

  @override
  final int index;
  @override
  final int? seatIndex;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.removeDeck(index: $index, seatIndex: $seatIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveDeckServerConnectionMessage &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.seatIndex, seatIndex) ||
                other.seatIndex == seatIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index, seatIndex);

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
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return removeDeck(index, seatIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return removeDeck?.call(index, seatIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (removeDeck != null) {
      return removeDeck(index, seatIndex);
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
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
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
  const factory RemoveDeckServerConnectionMessage(
          final int index, final int? seatIndex) =
      _$RemoveDeckServerConnectionMessage;

  factory RemoveDeckServerConnectionMessage.fromJson(
      Map<String, dynamic> json) = _$RemoveDeckServerConnectionMessage.fromJson;

  int get index;
  int? get seatIndex;
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
  $Res call({String name});
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
  }) {
    return _then(_$AddSeatServerConnectionMessage(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddSeatServerConnectionMessage
    implements AddSeatServerConnectionMessage {
  const _$AddSeatServerConnectionMessage(this.name, {final String? $type})
      : $type = $type ?? 'addSeat';

  factory _$AddSeatServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$AddSeatServerConnectionMessageFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.addSeat(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddSeatServerConnectionMessage &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

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
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return addSeat(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return addSeat?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (addSeat != null) {
      return addSeat(name);
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
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
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
  const factory AddSeatServerConnectionMessage(final String name) =
      _$AddSeatServerConnectionMessage;

  factory AddSeatServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$AddSeatServerConnectionMessage.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$AddSeatServerConnectionMessageCopyWith<_$AddSeatServerConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddCardsServerConnectionMessageCopyWith<$Res> {
  factory _$$AddCardsServerConnectionMessageCopyWith(
          _$AddCardsServerConnectionMessage value,
          $Res Function(_$AddCardsServerConnectionMessage) then) =
      __$$AddCardsServerConnectionMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CardIndex> cards, int deckIndex, int? seatIndex});
}

/// @nodoc
class __$$AddCardsServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$AddCardsServerConnectionMessage>
    implements _$$AddCardsServerConnectionMessageCopyWith<$Res> {
  __$$AddCardsServerConnectionMessageCopyWithImpl(
      _$AddCardsServerConnectionMessage _value,
      $Res Function(_$AddCardsServerConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? deckIndex = null,
    Object? seatIndex = freezed,
  }) {
    return _then(_$AddCardsServerConnectionMessage(
      null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardIndex>,
      null == deckIndex
          ? _value.deckIndex
          : deckIndex // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == seatIndex
          ? _value.seatIndex
          : seatIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddCardsServerConnectionMessage
    implements AddCardsServerConnectionMessage {
  const _$AddCardsServerConnectionMessage(
      final List<CardIndex> cards, this.deckIndex, this.seatIndex,
      {final String? $type})
      : _cards = cards,
        $type = $type ?? 'addCards';

  factory _$AddCardsServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$AddCardsServerConnectionMessageFromJson(json);

  final List<CardIndex> _cards;
  @override
  List<CardIndex> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final int deckIndex;
  @override
  final int? seatIndex;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.addCards(cards: $cards, deckIndex: $deckIndex, seatIndex: $seatIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCardsServerConnectionMessage &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.deckIndex, deckIndex) ||
                other.deckIndex == deckIndex) &&
            (identical(other.seatIndex, seatIndex) ||
                other.seatIndex == seatIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_cards), deckIndex, seatIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCardsServerConnectionMessageCopyWith<_$AddCardsServerConnectionMessage>
      get copyWith => __$$AddCardsServerConnectionMessageCopyWithImpl<
          _$AddCardsServerConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return addCards(cards, deckIndex, seatIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return addCards?.call(cards, deckIndex, seatIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (addCards != null) {
      return addCards(cards, deckIndex, seatIndex);
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return addCards(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return addCards?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
    required TResult orElse(),
  }) {
    if (addCards != null) {
      return addCards(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AddCardsServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class AddCardsServerConnectionMessage
    implements ServerConnectionMessage {
  const factory AddCardsServerConnectionMessage(
      final List<CardIndex> cards,
      final int deckIndex,
      final int? seatIndex) = _$AddCardsServerConnectionMessage;

  factory AddCardsServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$AddCardsServerConnectionMessage.fromJson;

  List<CardIndex> get cards;
  int get deckIndex;
  int? get seatIndex;
  @JsonKey(ignore: true)
  _$$AddCardsServerConnectionMessageCopyWith<_$AddCardsServerConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PutCardsServerConnectionMessageCopyWith<$Res> {
  factory _$$PutCardsServerConnectionMessageCopyWith(
          _$PutCardsServerConnectionMessage value,
          $Res Function(_$PutCardsServerConnectionMessage) then) =
      __$$PutCardsServerConnectionMessageCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int deckIndex,
      int? seatIndex,
      PickLocation location,
      int count,
      int movedDeckIndex,
      int? movedSeatIndex});
}

/// @nodoc
class __$$PutCardsServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$PutCardsServerConnectionMessage>
    implements _$$PutCardsServerConnectionMessageCopyWith<$Res> {
  __$$PutCardsServerConnectionMessageCopyWithImpl(
      _$PutCardsServerConnectionMessage _value,
      $Res Function(_$PutCardsServerConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deckIndex = null,
    Object? seatIndex = freezed,
    Object? location = null,
    Object? count = null,
    Object? movedDeckIndex = null,
    Object? movedSeatIndex = freezed,
  }) {
    return _then(_$PutCardsServerConnectionMessage(
      null == deckIndex
          ? _value.deckIndex
          : deckIndex // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == seatIndex
          ? _value.seatIndex
          : seatIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as PickLocation,
      null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      null == movedDeckIndex
          ? _value.movedDeckIndex
          : movedDeckIndex // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == movedSeatIndex
          ? _value.movedSeatIndex
          : movedSeatIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PutCardsServerConnectionMessage
    implements PutCardsServerConnectionMessage {
  const _$PutCardsServerConnectionMessage(this.deckIndex, this.seatIndex,
      this.location, this.count, this.movedDeckIndex, this.movedSeatIndex,
      {final String? $type})
      : $type = $type ?? 'putCards';

  factory _$PutCardsServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$PutCardsServerConnectionMessageFromJson(json);

  @override
  final int deckIndex;
  @override
  final int? seatIndex;
  @override
  final PickLocation location;
  @override
  final int count;
  @override
  final int movedDeckIndex;
  @override
  final int? movedSeatIndex;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.putCards(deckIndex: $deckIndex, seatIndex: $seatIndex, location: $location, count: $count, movedDeckIndex: $movedDeckIndex, movedSeatIndex: $movedSeatIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PutCardsServerConnectionMessage &&
            (identical(other.deckIndex, deckIndex) ||
                other.deckIndex == deckIndex) &&
            (identical(other.seatIndex, seatIndex) ||
                other.seatIndex == seatIndex) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.movedDeckIndex, movedDeckIndex) ||
                other.movedDeckIndex == movedDeckIndex) &&
            (identical(other.movedSeatIndex, movedSeatIndex) ||
                other.movedSeatIndex == movedSeatIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, deckIndex, seatIndex, location,
      count, movedDeckIndex, movedSeatIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PutCardsServerConnectionMessageCopyWith<_$PutCardsServerConnectionMessage>
      get copyWith => __$$PutCardsServerConnectionMessageCopyWithImpl<
          _$PutCardsServerConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return putCards(
        deckIndex, seatIndex, location, count, movedDeckIndex, movedSeatIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return putCards?.call(
        deckIndex, seatIndex, location, count, movedDeckIndex, movedSeatIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (putCards != null) {
      return putCards(deckIndex, seatIndex, location, count, movedDeckIndex,
          movedSeatIndex);
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return putCards(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return putCards?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
    required TResult orElse(),
  }) {
    if (putCards != null) {
      return putCards(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PutCardsServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class PutCardsServerConnectionMessage
    implements ServerConnectionMessage {
  const factory PutCardsServerConnectionMessage(
      final int deckIndex,
      final int? seatIndex,
      final PickLocation location,
      final int count,
      final int movedDeckIndex,
      final int? movedSeatIndex) = _$PutCardsServerConnectionMessage;

  factory PutCardsServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$PutCardsServerConnectionMessage.fromJson;

  int get deckIndex;
  int? get seatIndex;
  PickLocation get location;
  int get count;
  int get movedDeckIndex;
  int? get movedSeatIndex;
  @JsonKey(ignore: true)
  _$$PutCardsServerConnectionMessageCopyWith<_$PutCardsServerConnectionMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveCardsServerConnectionMessageCopyWith<$Res> {
  factory _$$RemoveCardsServerConnectionMessageCopyWith(
          _$RemoveCardsServerConnectionMessage value,
          $Res Function(_$RemoveCardsServerConnectionMessage) then) =
      __$$RemoveCardsServerConnectionMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CardIndex> cards});
}

/// @nodoc
class __$$RemoveCardsServerConnectionMessageCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$RemoveCardsServerConnectionMessage>
    implements _$$RemoveCardsServerConnectionMessageCopyWith<$Res> {
  __$$RemoveCardsServerConnectionMessageCopyWithImpl(
      _$RemoveCardsServerConnectionMessage _value,
      $Res Function(_$RemoveCardsServerConnectionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
  }) {
    return _then(_$RemoveCardsServerConnectionMessage(
      null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardIndex>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoveCardsServerConnectionMessage
    implements RemoveCardsServerConnectionMessage {
  const _$RemoveCardsServerConnectionMessage(final List<CardIndex> cards,
      {final String? $type})
      : _cards = cards,
        $type = $type ?? 'removeCards';

  factory _$RemoveCardsServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =>
      _$$RemoveCardsServerConnectionMessageFromJson(json);

  final List<CardIndex> _cards;
  @override
  List<CardIndex> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.removeCards(cards: $cards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveCardsServerConnectionMessage &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveCardsServerConnectionMessageCopyWith<
          _$RemoveCardsServerConnectionMessage>
      get copyWith => __$$RemoveCardsServerConnectionMessageCopyWithImpl<
          _$RemoveCardsServerConnectionMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPlayers,
    required TResult Function(String message) chatMessage,
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
    required TResult Function(int index) removeSeat,
    required TResult Function(int index) joinSeat,
    required TResult Function(int index) leaveSeat,
  }) {
    return removeCards(cards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPlayers,
    TResult? Function(String message)? chatMessage,
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
    TResult? Function(int index)? removeSeat,
    TResult? Function(int index)? joinSeat,
    TResult? Function(int index)? leaveSeat,
  }) {
    return removeCards?.call(cards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPlayers,
    TResult Function(String message)? chatMessage,
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
    TResult Function(int index)? removeSeat,
    TResult Function(int index)? joinSeat,
    TResult Function(int index)? leaveSeat,
    required TResult orElse(),
  }) {
    if (removeCards != null) {
      return removeCards(cards);
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
    required TResult Function(RemoveSeatServerConnectionMessage value)
        removeSeat,
    required TResult Function(JoinSeatServerConnectionMessage value) joinSeat,
    required TResult Function(LeaveSeatServerConnectionMessage value) leaveSeat,
  }) {
    return removeCards(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult? Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult? Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult? Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult? Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
    TResult? Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult? Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult? Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
  }) {
    return removeCards?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPlayersServerConnectionMessage value)? fetchPlayers,
    TResult Function(ChatMessageServerConnectionMessage value)? chatMessage,
    TResult Function(AddDeckServerConnectionMessage value)? addDeck,
    TResult Function(RemoveDeckServerConnectionMessage value)? removeDeck,
    TResult Function(AddSeatServerConnectionMessage value)? addSeat,
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
    TResult Function(RemoveSeatServerConnectionMessage value)? removeSeat,
    TResult Function(JoinSeatServerConnectionMessage value)? joinSeat,
    TResult Function(LeaveSeatServerConnectionMessage value)? leaveSeat,
    required TResult orElse(),
  }) {
    if (removeCards != null) {
      return removeCards(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoveCardsServerConnectionMessageToJson(
      this,
    );
  }
}

abstract class RemoveCardsServerConnectionMessage
    implements ServerConnectionMessage {
  const factory RemoveCardsServerConnectionMessage(
      final List<CardIndex> cards) = _$RemoveCardsServerConnectionMessage;

  factory RemoveCardsServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =
      _$RemoveCardsServerConnectionMessage.fromJson;

  List<CardIndex> get cards;
  @JsonKey(ignore: true)
  _$$RemoveCardsServerConnectionMessageCopyWith<
          _$RemoveCardsServerConnectionMessage>
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

  @JsonKey(name: 'type')
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
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
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
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
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
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
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
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
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

  @JsonKey(name: 'type')
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
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
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
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
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
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
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
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
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

  @JsonKey(name: 'type')
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
    required TResult Function(GameDeck deck, int? seatIndex) addDeck,
    required TResult Function(int index, int? seatIndex) removeDeck,
    required TResult Function(String name) addSeat,
    required TResult Function(
            List<CardIndex> cards, int deckIndex, int? seatIndex)
        addCards,
    required TResult Function(
            int deckIndex,
            int? seatIndex,
            PickLocation location,
            int count,
            int movedDeckIndex,
            int? movedSeatIndex)
        putCards,
    required TResult Function(List<CardIndex> cards) removeCards,
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
    TResult? Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult? Function(int index, int? seatIndex)? removeDeck,
    TResult? Function(String name)? addSeat,
    TResult? Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult? Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult? Function(List<CardIndex> cards)? removeCards,
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
    TResult Function(GameDeck deck, int? seatIndex)? addDeck,
    TResult Function(int index, int? seatIndex)? removeDeck,
    TResult Function(String name)? addSeat,
    TResult Function(List<CardIndex> cards, int deckIndex, int? seatIndex)?
        addCards,
    TResult Function(int deckIndex, int? seatIndex, PickLocation location,
            int count, int movedDeckIndex, int? movedSeatIndex)?
        putCards,
    TResult Function(List<CardIndex> cards)? removeCards,
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
    required TResult Function(AddCardsServerConnectionMessage value) addCards,
    required TResult Function(PutCardsServerConnectionMessage value) putCards,
    required TResult Function(RemoveCardsServerConnectionMessage value)
        removeCards,
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
    TResult? Function(AddCardsServerConnectionMessage value)? addCards,
    TResult? Function(PutCardsServerConnectionMessage value)? putCards,
    TResult? Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
    TResult Function(AddCardsServerConnectionMessage value)? addCards,
    TResult Function(PutCardsServerConnectionMessage value)? putCards,
    TResult Function(RemoveCardsServerConnectionMessage value)? removeCards,
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
