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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
    case 'shuffle':
      return ShuffleServerConnectionMessage.fromJson(json);
    case 'changeVisibility':
      return ChangeVisibilityServerConnectionMessage.fromJson(json);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
abstract class _$$FetchPlayersServerConnectionMessageImplCopyWith<$Res> {
  factory _$$FetchPlayersServerConnectionMessageImplCopyWith(
          _$FetchPlayersServerConnectionMessageImpl value,
          $Res Function(_$FetchPlayersServerConnectionMessageImpl) then) =
      __$$FetchPlayersServerConnectionMessageImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchPlayersServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$FetchPlayersServerConnectionMessageImpl>
    implements _$$FetchPlayersServerConnectionMessageImplCopyWith<$Res> {
  __$$FetchPlayersServerConnectionMessageImplCopyWithImpl(
      _$FetchPlayersServerConnectionMessageImpl _value,
      $Res Function(_$FetchPlayersServerConnectionMessageImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$FetchPlayersServerConnectionMessageImpl
    implements FetchPlayersServerConnectionMessage {
  const _$FetchPlayersServerConnectionMessageImpl({final String? $type})
      : $type = $type ?? 'fetchPlayers';

  factory _$FetchPlayersServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$FetchPlayersServerConnectionMessageImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.fetchPlayers()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchPlayersServerConnectionMessageImpl);
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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (fetchPlayers != null) {
      return fetchPlayers(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FetchPlayersServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class FetchPlayersServerConnectionMessage
    implements ServerConnectionMessage {
  const factory FetchPlayersServerConnectionMessage() =
      _$FetchPlayersServerConnectionMessageImpl;

  factory FetchPlayersServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =
      _$FetchPlayersServerConnectionMessageImpl.fromJson;
}

/// @nodoc
abstract class _$$ChatMessageServerConnectionMessageImplCopyWith<$Res> {
  factory _$$ChatMessageServerConnectionMessageImplCopyWith(
          _$ChatMessageServerConnectionMessageImpl value,
          $Res Function(_$ChatMessageServerConnectionMessageImpl) then) =
      __$$ChatMessageServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ChatMessageServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$ChatMessageServerConnectionMessageImpl>
    implements _$$ChatMessageServerConnectionMessageImplCopyWith<$Res> {
  __$$ChatMessageServerConnectionMessageImplCopyWithImpl(
      _$ChatMessageServerConnectionMessageImpl _value,
      $Res Function(_$ChatMessageServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ChatMessageServerConnectionMessageImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageServerConnectionMessageImpl
    implements ChatMessageServerConnectionMessage {
  const _$ChatMessageServerConnectionMessageImpl(this.message,
      {final String? $type})
      : $type = $type ?? 'chatMessage';

  factory _$ChatMessageServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChatMessageServerConnectionMessageImplFromJson(json);

  @override
  final String message;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.chatMessage(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageServerConnectionMessageImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageServerConnectionMessageImplCopyWith<
          _$ChatMessageServerConnectionMessageImpl>
      get copyWith => __$$ChatMessageServerConnectionMessageImplCopyWithImpl<
          _$ChatMessageServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (chatMessage != null) {
      return chatMessage(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class ChatMessageServerConnectionMessage
    implements ServerConnectionMessage {
  const factory ChatMessageServerConnectionMessage(final String message) =
      _$ChatMessageServerConnectionMessageImpl;

  factory ChatMessageServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =
      _$ChatMessageServerConnectionMessageImpl.fromJson;

  String get message;
  @JsonKey(ignore: true)
  _$$ChatMessageServerConnectionMessageImplCopyWith<
          _$ChatMessageServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddDeckServerConnectionMessageImplCopyWith<$Res> {
  factory _$$AddDeckServerConnectionMessageImplCopyWith(
          _$AddDeckServerConnectionMessageImpl value,
          $Res Function(_$AddDeckServerConnectionMessageImpl) then) =
      __$$AddDeckServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GameDeck deck, int? seatIndex});

  $GameDeckCopyWith<$Res> get deck;
}

/// @nodoc
class __$$AddDeckServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$AddDeckServerConnectionMessageImpl>
    implements _$$AddDeckServerConnectionMessageImplCopyWith<$Res> {
  __$$AddDeckServerConnectionMessageImplCopyWithImpl(
      _$AddDeckServerConnectionMessageImpl _value,
      $Res Function(_$AddDeckServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deck = null,
    Object? seatIndex = freezed,
  }) {
    return _then(_$AddDeckServerConnectionMessageImpl(
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
class _$AddDeckServerConnectionMessageImpl
    implements AddDeckServerConnectionMessage {
  const _$AddDeckServerConnectionMessageImpl(this.deck, this.seatIndex,
      {final String? $type})
      : $type = $type ?? 'addDeck';

  factory _$AddDeckServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddDeckServerConnectionMessageImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddDeckServerConnectionMessageImpl &&
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
  _$$AddDeckServerConnectionMessageImplCopyWith<
          _$AddDeckServerConnectionMessageImpl>
      get copyWith => __$$AddDeckServerConnectionMessageImplCopyWithImpl<
          _$AddDeckServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (addDeck != null) {
      return addDeck(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AddDeckServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class AddDeckServerConnectionMessage
    implements ServerConnectionMessage {
  const factory AddDeckServerConnectionMessage(
          final GameDeck deck, final int? seatIndex) =
      _$AddDeckServerConnectionMessageImpl;

  factory AddDeckServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$AddDeckServerConnectionMessageImpl.fromJson;

  GameDeck get deck;
  int? get seatIndex;
  @JsonKey(ignore: true)
  _$$AddDeckServerConnectionMessageImplCopyWith<
          _$AddDeckServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveDeckServerConnectionMessageImplCopyWith<$Res> {
  factory _$$RemoveDeckServerConnectionMessageImplCopyWith(
          _$RemoveDeckServerConnectionMessageImpl value,
          $Res Function(_$RemoveDeckServerConnectionMessageImpl) then) =
      __$$RemoveDeckServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index, int? seatIndex});
}

/// @nodoc
class __$$RemoveDeckServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$RemoveDeckServerConnectionMessageImpl>
    implements _$$RemoveDeckServerConnectionMessageImplCopyWith<$Res> {
  __$$RemoveDeckServerConnectionMessageImplCopyWithImpl(
      _$RemoveDeckServerConnectionMessageImpl _value,
      $Res Function(_$RemoveDeckServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? seatIndex = freezed,
  }) {
    return _then(_$RemoveDeckServerConnectionMessageImpl(
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
class _$RemoveDeckServerConnectionMessageImpl
    implements RemoveDeckServerConnectionMessage {
  const _$RemoveDeckServerConnectionMessageImpl(this.index, this.seatIndex,
      {final String? $type})
      : $type = $type ?? 'removeDeck';

  factory _$RemoveDeckServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RemoveDeckServerConnectionMessageImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveDeckServerConnectionMessageImpl &&
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
  _$$RemoveDeckServerConnectionMessageImplCopyWith<
          _$RemoveDeckServerConnectionMessageImpl>
      get copyWith => __$$RemoveDeckServerConnectionMessageImplCopyWithImpl<
          _$RemoveDeckServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (removeDeck != null) {
      return removeDeck(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoveDeckServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class RemoveDeckServerConnectionMessage
    implements ServerConnectionMessage {
  const factory RemoveDeckServerConnectionMessage(
          final int index, final int? seatIndex) =
      _$RemoveDeckServerConnectionMessageImpl;

  factory RemoveDeckServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =
      _$RemoveDeckServerConnectionMessageImpl.fromJson;

  int get index;
  int? get seatIndex;
  @JsonKey(ignore: true)
  _$$RemoveDeckServerConnectionMessageImplCopyWith<
          _$RemoveDeckServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddSeatServerConnectionMessageImplCopyWith<$Res> {
  factory _$$AddSeatServerConnectionMessageImplCopyWith(
          _$AddSeatServerConnectionMessageImpl value,
          $Res Function(_$AddSeatServerConnectionMessageImpl) then) =
      __$$AddSeatServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$AddSeatServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$AddSeatServerConnectionMessageImpl>
    implements _$$AddSeatServerConnectionMessageImplCopyWith<$Res> {
  __$$AddSeatServerConnectionMessageImplCopyWithImpl(
      _$AddSeatServerConnectionMessageImpl _value,
      $Res Function(_$AddSeatServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$AddSeatServerConnectionMessageImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddSeatServerConnectionMessageImpl
    implements AddSeatServerConnectionMessage {
  const _$AddSeatServerConnectionMessageImpl(this.name, {final String? $type})
      : $type = $type ?? 'addSeat';

  factory _$AddSeatServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddSeatServerConnectionMessageImplFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.addSeat(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddSeatServerConnectionMessageImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddSeatServerConnectionMessageImplCopyWith<
          _$AddSeatServerConnectionMessageImpl>
      get copyWith => __$$AddSeatServerConnectionMessageImplCopyWithImpl<
          _$AddSeatServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (addSeat != null) {
      return addSeat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AddSeatServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class AddSeatServerConnectionMessage
    implements ServerConnectionMessage {
  const factory AddSeatServerConnectionMessage(final String name) =
      _$AddSeatServerConnectionMessageImpl;

  factory AddSeatServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$AddSeatServerConnectionMessageImpl.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$AddSeatServerConnectionMessageImplCopyWith<
          _$AddSeatServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddCardsServerConnectionMessageImplCopyWith<$Res> {
  factory _$$AddCardsServerConnectionMessageImplCopyWith(
          _$AddCardsServerConnectionMessageImpl value,
          $Res Function(_$AddCardsServerConnectionMessageImpl) then) =
      __$$AddCardsServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CardIndex> cards, int deckIndex, int? seatIndex});
}

/// @nodoc
class __$$AddCardsServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$AddCardsServerConnectionMessageImpl>
    implements _$$AddCardsServerConnectionMessageImplCopyWith<$Res> {
  __$$AddCardsServerConnectionMessageImplCopyWithImpl(
      _$AddCardsServerConnectionMessageImpl _value,
      $Res Function(_$AddCardsServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? deckIndex = null,
    Object? seatIndex = freezed,
  }) {
    return _then(_$AddCardsServerConnectionMessageImpl(
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
class _$AddCardsServerConnectionMessageImpl
    implements AddCardsServerConnectionMessage {
  const _$AddCardsServerConnectionMessageImpl(
      final List<CardIndex> cards, this.deckIndex, this.seatIndex,
      {final String? $type})
      : _cards = cards,
        $type = $type ?? 'addCards';

  factory _$AddCardsServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddCardsServerConnectionMessageImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCardsServerConnectionMessageImpl &&
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
  _$$AddCardsServerConnectionMessageImplCopyWith<
          _$AddCardsServerConnectionMessageImpl>
      get copyWith => __$$AddCardsServerConnectionMessageImplCopyWithImpl<
          _$AddCardsServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (addCards != null) {
      return addCards(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AddCardsServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class AddCardsServerConnectionMessage
    implements ServerConnectionMessage {
  const factory AddCardsServerConnectionMessage(
      final List<CardIndex> cards,
      final int deckIndex,
      final int? seatIndex) = _$AddCardsServerConnectionMessageImpl;

  factory AddCardsServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$AddCardsServerConnectionMessageImpl.fromJson;

  List<CardIndex> get cards;
  int get deckIndex;
  int? get seatIndex;
  @JsonKey(ignore: true)
  _$$AddCardsServerConnectionMessageImplCopyWith<
          _$AddCardsServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PutCardsServerConnectionMessageImplCopyWith<$Res> {
  factory _$$PutCardsServerConnectionMessageImplCopyWith(
          _$PutCardsServerConnectionMessageImpl value,
          $Res Function(_$PutCardsServerConnectionMessageImpl) then) =
      __$$PutCardsServerConnectionMessageImplCopyWithImpl<$Res>;
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
class __$$PutCardsServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$PutCardsServerConnectionMessageImpl>
    implements _$$PutCardsServerConnectionMessageImplCopyWith<$Res> {
  __$$PutCardsServerConnectionMessageImplCopyWithImpl(
      _$PutCardsServerConnectionMessageImpl _value,
      $Res Function(_$PutCardsServerConnectionMessageImpl) _then)
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
    return _then(_$PutCardsServerConnectionMessageImpl(
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
class _$PutCardsServerConnectionMessageImpl
    implements PutCardsServerConnectionMessage {
  const _$PutCardsServerConnectionMessageImpl(this.deckIndex, this.seatIndex,
      this.location, this.count, this.movedDeckIndex, this.movedSeatIndex,
      {final String? $type})
      : $type = $type ?? 'putCards';

  factory _$PutCardsServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PutCardsServerConnectionMessageImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PutCardsServerConnectionMessageImpl &&
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
  _$$PutCardsServerConnectionMessageImplCopyWith<
          _$PutCardsServerConnectionMessageImpl>
      get copyWith => __$$PutCardsServerConnectionMessageImplCopyWithImpl<
          _$PutCardsServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (putCards != null) {
      return putCards(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PutCardsServerConnectionMessageImplToJson(
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
      final int? movedSeatIndex) = _$PutCardsServerConnectionMessageImpl;

  factory PutCardsServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$PutCardsServerConnectionMessageImpl.fromJson;

  int get deckIndex;
  int? get seatIndex;
  PickLocation get location;
  int get count;
  int get movedDeckIndex;
  int? get movedSeatIndex;
  @JsonKey(ignore: true)
  _$$PutCardsServerConnectionMessageImplCopyWith<
          _$PutCardsServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveCardsServerConnectionMessageImplCopyWith<$Res> {
  factory _$$RemoveCardsServerConnectionMessageImplCopyWith(
          _$RemoveCardsServerConnectionMessageImpl value,
          $Res Function(_$RemoveCardsServerConnectionMessageImpl) then) =
      __$$RemoveCardsServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CardIndex> cards});
}

/// @nodoc
class __$$RemoveCardsServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$RemoveCardsServerConnectionMessageImpl>
    implements _$$RemoveCardsServerConnectionMessageImplCopyWith<$Res> {
  __$$RemoveCardsServerConnectionMessageImplCopyWithImpl(
      _$RemoveCardsServerConnectionMessageImpl _value,
      $Res Function(_$RemoveCardsServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
  }) {
    return _then(_$RemoveCardsServerConnectionMessageImpl(
      null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardIndex>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoveCardsServerConnectionMessageImpl
    implements RemoveCardsServerConnectionMessage {
  const _$RemoveCardsServerConnectionMessageImpl(final List<CardIndex> cards,
      {final String? $type})
      : _cards = cards,
        $type = $type ?? 'removeCards';

  factory _$RemoveCardsServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RemoveCardsServerConnectionMessageImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveCardsServerConnectionMessageImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveCardsServerConnectionMessageImplCopyWith<
          _$RemoveCardsServerConnectionMessageImpl>
      get copyWith => __$$RemoveCardsServerConnectionMessageImplCopyWithImpl<
          _$RemoveCardsServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (removeCards != null) {
      return removeCards(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoveCardsServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class RemoveCardsServerConnectionMessage
    implements ServerConnectionMessage {
  const factory RemoveCardsServerConnectionMessage(
      final List<CardIndex> cards) = _$RemoveCardsServerConnectionMessageImpl;

  factory RemoveCardsServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =
      _$RemoveCardsServerConnectionMessageImpl.fromJson;

  List<CardIndex> get cards;
  @JsonKey(ignore: true)
  _$$RemoveCardsServerConnectionMessageImplCopyWith<
          _$RemoveCardsServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveSeatServerConnectionMessageImplCopyWith<$Res> {
  factory _$$RemoveSeatServerConnectionMessageImplCopyWith(
          _$RemoveSeatServerConnectionMessageImpl value,
          $Res Function(_$RemoveSeatServerConnectionMessageImpl) then) =
      __$$RemoveSeatServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$RemoveSeatServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$RemoveSeatServerConnectionMessageImpl>
    implements _$$RemoveSeatServerConnectionMessageImplCopyWith<$Res> {
  __$$RemoveSeatServerConnectionMessageImplCopyWithImpl(
      _$RemoveSeatServerConnectionMessageImpl _value,
      $Res Function(_$RemoveSeatServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$RemoveSeatServerConnectionMessageImpl(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoveSeatServerConnectionMessageImpl
    implements RemoveSeatServerConnectionMessage {
  const _$RemoveSeatServerConnectionMessageImpl(this.index,
      {final String? $type})
      : $type = $type ?? 'removeSeat';

  factory _$RemoveSeatServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RemoveSeatServerConnectionMessageImplFromJson(json);

  @override
  final int index;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.removeSeat(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveSeatServerConnectionMessageImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveSeatServerConnectionMessageImplCopyWith<
          _$RemoveSeatServerConnectionMessageImpl>
      get copyWith => __$$RemoveSeatServerConnectionMessageImplCopyWithImpl<
          _$RemoveSeatServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (removeSeat != null) {
      return removeSeat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoveSeatServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class RemoveSeatServerConnectionMessage
    implements ServerConnectionMessage {
  const factory RemoveSeatServerConnectionMessage(final int index) =
      _$RemoveSeatServerConnectionMessageImpl;

  factory RemoveSeatServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =
      _$RemoveSeatServerConnectionMessageImpl.fromJson;

  int get index;
  @JsonKey(ignore: true)
  _$$RemoveSeatServerConnectionMessageImplCopyWith<
          _$RemoveSeatServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$JoinSeatServerConnectionMessageImplCopyWith<$Res> {
  factory _$$JoinSeatServerConnectionMessageImplCopyWith(
          _$JoinSeatServerConnectionMessageImpl value,
          $Res Function(_$JoinSeatServerConnectionMessageImpl) then) =
      __$$JoinSeatServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$JoinSeatServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$JoinSeatServerConnectionMessageImpl>
    implements _$$JoinSeatServerConnectionMessageImplCopyWith<$Res> {
  __$$JoinSeatServerConnectionMessageImplCopyWithImpl(
      _$JoinSeatServerConnectionMessageImpl _value,
      $Res Function(_$JoinSeatServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$JoinSeatServerConnectionMessageImpl(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinSeatServerConnectionMessageImpl
    implements JoinSeatServerConnectionMessage {
  const _$JoinSeatServerConnectionMessageImpl(this.index, {final String? $type})
      : $type = $type ?? 'joinSeat';

  factory _$JoinSeatServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$JoinSeatServerConnectionMessageImplFromJson(json);

  @override
  final int index;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.joinSeat(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinSeatServerConnectionMessageImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinSeatServerConnectionMessageImplCopyWith<
          _$JoinSeatServerConnectionMessageImpl>
      get copyWith => __$$JoinSeatServerConnectionMessageImplCopyWithImpl<
          _$JoinSeatServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (joinSeat != null) {
      return joinSeat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinSeatServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class JoinSeatServerConnectionMessage
    implements ServerConnectionMessage {
  const factory JoinSeatServerConnectionMessage(final int index) =
      _$JoinSeatServerConnectionMessageImpl;

  factory JoinSeatServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$JoinSeatServerConnectionMessageImpl.fromJson;

  int get index;
  @JsonKey(ignore: true)
  _$$JoinSeatServerConnectionMessageImplCopyWith<
          _$JoinSeatServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LeaveSeatServerConnectionMessageImplCopyWith<$Res> {
  factory _$$LeaveSeatServerConnectionMessageImplCopyWith(
          _$LeaveSeatServerConnectionMessageImpl value,
          $Res Function(_$LeaveSeatServerConnectionMessageImpl) then) =
      __$$LeaveSeatServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$LeaveSeatServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$LeaveSeatServerConnectionMessageImpl>
    implements _$$LeaveSeatServerConnectionMessageImplCopyWith<$Res> {
  __$$LeaveSeatServerConnectionMessageImplCopyWithImpl(
      _$LeaveSeatServerConnectionMessageImpl _value,
      $Res Function(_$LeaveSeatServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$LeaveSeatServerConnectionMessageImpl(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveSeatServerConnectionMessageImpl
    implements LeaveSeatServerConnectionMessage {
  const _$LeaveSeatServerConnectionMessageImpl(this.index,
      {final String? $type})
      : $type = $type ?? 'leaveSeat';

  factory _$LeaveSeatServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LeaveSeatServerConnectionMessageImplFromJson(json);

  @override
  final int index;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.leaveSeat(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveSeatServerConnectionMessageImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveSeatServerConnectionMessageImplCopyWith<
          _$LeaveSeatServerConnectionMessageImpl>
      get copyWith => __$$LeaveSeatServerConnectionMessageImplCopyWithImpl<
          _$LeaveSeatServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (leaveSeat != null) {
      return leaveSeat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveSeatServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class LeaveSeatServerConnectionMessage
    implements ServerConnectionMessage {
  const factory LeaveSeatServerConnectionMessage(final int index) =
      _$LeaveSeatServerConnectionMessageImpl;

  factory LeaveSeatServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$LeaveSeatServerConnectionMessageImpl.fromJson;

  int get index;
  @JsonKey(ignore: true)
  _$$LeaveSeatServerConnectionMessageImplCopyWith<
          _$LeaveSeatServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShuffleServerConnectionMessageImplCopyWith<$Res> {
  factory _$$ShuffleServerConnectionMessageImplCopyWith(
          _$ShuffleServerConnectionMessageImpl value,
          $Res Function(_$ShuffleServerConnectionMessageImpl) then) =
      __$$ShuffleServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int deckIndex, int? seatIndex});
}

/// @nodoc
class __$$ShuffleServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$ShuffleServerConnectionMessageImpl>
    implements _$$ShuffleServerConnectionMessageImplCopyWith<$Res> {
  __$$ShuffleServerConnectionMessageImplCopyWithImpl(
      _$ShuffleServerConnectionMessageImpl _value,
      $Res Function(_$ShuffleServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deckIndex = null,
    Object? seatIndex = freezed,
  }) {
    return _then(_$ShuffleServerConnectionMessageImpl(
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
class _$ShuffleServerConnectionMessageImpl
    implements ShuffleServerConnectionMessage {
  const _$ShuffleServerConnectionMessageImpl(this.deckIndex, this.seatIndex,
      {final String? $type})
      : $type = $type ?? 'shuffle';

  factory _$ShuffleServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ShuffleServerConnectionMessageImplFromJson(json);

  @override
  final int deckIndex;
  @override
  final int? seatIndex;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.shuffle(deckIndex: $deckIndex, seatIndex: $seatIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShuffleServerConnectionMessageImpl &&
            (identical(other.deckIndex, deckIndex) ||
                other.deckIndex == deckIndex) &&
            (identical(other.seatIndex, seatIndex) ||
                other.seatIndex == seatIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, deckIndex, seatIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShuffleServerConnectionMessageImplCopyWith<
          _$ShuffleServerConnectionMessageImpl>
      get copyWith => __$$ShuffleServerConnectionMessageImplCopyWithImpl<
          _$ShuffleServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
  }) {
    return shuffle(deckIndex, seatIndex);
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
  }) {
    return shuffle?.call(deckIndex, seatIndex);
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (shuffle != null) {
      return shuffle(deckIndex, seatIndex);
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
  }) {
    return shuffle(this);
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
  }) {
    return shuffle?.call(this);
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (shuffle != null) {
      return shuffle(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ShuffleServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class ShuffleServerConnectionMessage
    implements ServerConnectionMessage {
  const factory ShuffleServerConnectionMessage(
          final int deckIndex, final int? seatIndex) =
      _$ShuffleServerConnectionMessageImpl;

  factory ShuffleServerConnectionMessage.fromJson(Map<String, dynamic> json) =
      _$ShuffleServerConnectionMessageImpl.fromJson;

  int get deckIndex;
  int? get seatIndex;
  @JsonKey(ignore: true)
  _$$ShuffleServerConnectionMessageImplCopyWith<
          _$ShuffleServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeVisibilityServerConnectionMessageImplCopyWith<$Res> {
  factory _$$ChangeVisibilityServerConnectionMessageImplCopyWith(
          _$ChangeVisibilityServerConnectionMessageImpl value,
          $Res Function(_$ChangeVisibilityServerConnectionMessageImpl) then) =
      __$$ChangeVisibilityServerConnectionMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int deckIndex,
      int? seatIndex,
      DeckVisibility visibility,
      DeckVisibility? ownVisibility});
}

/// @nodoc
class __$$ChangeVisibilityServerConnectionMessageImplCopyWithImpl<$Res>
    extends _$ServerConnectionMessageCopyWithImpl<$Res,
        _$ChangeVisibilityServerConnectionMessageImpl>
    implements _$$ChangeVisibilityServerConnectionMessageImplCopyWith<$Res> {
  __$$ChangeVisibilityServerConnectionMessageImplCopyWithImpl(
      _$ChangeVisibilityServerConnectionMessageImpl _value,
      $Res Function(_$ChangeVisibilityServerConnectionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deckIndex = null,
    Object? seatIndex = freezed,
    Object? visibility = null,
    Object? ownVisibility = freezed,
  }) {
    return _then(_$ChangeVisibilityServerConnectionMessageImpl(
      null == deckIndex
          ? _value.deckIndex
          : deckIndex // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == seatIndex
          ? _value.seatIndex
          : seatIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as DeckVisibility,
      freezed == ownVisibility
          ? _value.ownVisibility
          : ownVisibility // ignore: cast_nullable_to_non_nullable
              as DeckVisibility?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangeVisibilityServerConnectionMessageImpl
    implements ChangeVisibilityServerConnectionMessage {
  const _$ChangeVisibilityServerConnectionMessageImpl(
      this.deckIndex, this.seatIndex, this.visibility,
      [this.ownVisibility, final String? $type])
      : $type = $type ?? 'changeVisibility';

  factory _$ChangeVisibilityServerConnectionMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChangeVisibilityServerConnectionMessageImplFromJson(json);

  @override
  final int deckIndex;
  @override
  final int? seatIndex;
  @override
  final DeckVisibility visibility;
  @override
  final DeckVisibility? ownVisibility;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ServerConnectionMessage.changeVisibility(deckIndex: $deckIndex, seatIndex: $seatIndex, visibility: $visibility, ownVisibility: $ownVisibility)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeVisibilityServerConnectionMessageImpl &&
            (identical(other.deckIndex, deckIndex) ||
                other.deckIndex == deckIndex) &&
            (identical(other.seatIndex, seatIndex) ||
                other.seatIndex == seatIndex) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.ownVisibility, ownVisibility) ||
                other.ownVisibility == ownVisibility));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, deckIndex, seatIndex, visibility, ownVisibility);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeVisibilityServerConnectionMessageImplCopyWith<
          _$ChangeVisibilityServerConnectionMessageImpl>
      get copyWith =>
          __$$ChangeVisibilityServerConnectionMessageImplCopyWithImpl<
              _$ChangeVisibilityServerConnectionMessageImpl>(this, _$identity);

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
    required TResult Function(int deckIndex, int? seatIndex) shuffle,
    required TResult Function(int deckIndex, int? seatIndex,
            DeckVisibility visibility, DeckVisibility? ownVisibility)
        changeVisibility,
  }) {
    return changeVisibility(deckIndex, seatIndex, visibility, ownVisibility);
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
    TResult? Function(int deckIndex, int? seatIndex)? shuffle,
    TResult? Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
  }) {
    return changeVisibility?.call(
        deckIndex, seatIndex, visibility, ownVisibility);
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
    TResult Function(int deckIndex, int? seatIndex)? shuffle,
    TResult Function(int deckIndex, int? seatIndex, DeckVisibility visibility,
            DeckVisibility? ownVisibility)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (changeVisibility != null) {
      return changeVisibility(deckIndex, seatIndex, visibility, ownVisibility);
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
    required TResult Function(ShuffleServerConnectionMessage value) shuffle,
    required TResult Function(ChangeVisibilityServerConnectionMessage value)
        changeVisibility,
  }) {
    return changeVisibility(this);
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
    TResult? Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult? Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
  }) {
    return changeVisibility?.call(this);
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
    TResult Function(ShuffleServerConnectionMessage value)? shuffle,
    TResult Function(ChangeVisibilityServerConnectionMessage value)?
        changeVisibility,
    required TResult orElse(),
  }) {
    if (changeVisibility != null) {
      return changeVisibility(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeVisibilityServerConnectionMessageImplToJson(
      this,
    );
  }
}

abstract class ChangeVisibilityServerConnectionMessage
    implements ServerConnectionMessage {
  const factory ChangeVisibilityServerConnectionMessage(final int deckIndex,
          final int? seatIndex, final DeckVisibility visibility,
          [final DeckVisibility? ownVisibility]) =
      _$ChangeVisibilityServerConnectionMessageImpl;

  factory ChangeVisibilityServerConnectionMessage.fromJson(
          Map<String, dynamic> json) =
      _$ChangeVisibilityServerConnectionMessageImpl.fromJson;

  int get deckIndex;
  int? get seatIndex;
  DeckVisibility get visibility;
  DeckVisibility? get ownVisibility;
  @JsonKey(ignore: true)
  _$$ChangeVisibilityServerConnectionMessageImplCopyWith<
          _$ChangeVisibilityServerConnectionMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}
