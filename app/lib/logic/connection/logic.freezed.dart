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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GamePlayer _$GamePlayerFromJson(Map<String, dynamic> json) {
  return _GamePlayer.fromJson(json);
}

/// @nodoc
mixin _$GamePlayer {
  String get name => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

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
  $Res call({String name, int id});
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
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GamePlayerImplCopyWith<$Res>
    implements $GamePlayerCopyWith<$Res> {
  factory _$$GamePlayerImplCopyWith(
          _$GamePlayerImpl value, $Res Function(_$GamePlayerImpl) then) =
      __$$GamePlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int id});
}

/// @nodoc
class __$$GamePlayerImplCopyWithImpl<$Res>
    extends _$GamePlayerCopyWithImpl<$Res, _$GamePlayerImpl>
    implements _$$GamePlayerImplCopyWith<$Res> {
  __$$GamePlayerImplCopyWithImpl(
      _$GamePlayerImpl _value, $Res Function(_$GamePlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_$GamePlayerImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GamePlayerImpl implements _GamePlayer {
  const _$GamePlayerImpl({required this.name, required this.id});

  factory _$GamePlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamePlayerImplFromJson(json);

  @override
  final String name;
  @override
  final int id;

  @override
  String toString() {
    return 'GamePlayer(name: $name, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamePlayerImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GamePlayerImplCopyWith<_$GamePlayerImpl> get copyWith =>
      __$$GamePlayerImplCopyWithImpl<_$GamePlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GamePlayerImplToJson(
      this,
    );
  }
}

abstract class _GamePlayer implements GamePlayer {
  const factory _GamePlayer(
      {required final String name, required final int id}) = _$GamePlayerImpl;

  factory _GamePlayer.fromJson(Map<String, dynamic> json) =
      _$GamePlayerImpl.fromJson;

  @override
  String get name;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$GamePlayerImplCopyWith<_$GamePlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CardIndex _$CardIndexFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'custom':
      return AvailableCardIndex.fromJson(json);
    case 'deck':
      return DeckCardIndex.fromJson(json);
    case 'seat':
      return SeatCardIndex.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'CardIndex', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$CardIndex {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameCard card) custom,
    required TResult Function(int cardIndex, int deckIndex) deck,
    required TResult Function(int cardIndex, int deckIndex, int seatIndex) seat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameCard card)? custom,
    TResult? Function(int cardIndex, int deckIndex)? deck,
    TResult? Function(int cardIndex, int deckIndex, int seatIndex)? seat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameCard card)? custom,
    TResult Function(int cardIndex, int deckIndex)? deck,
    TResult Function(int cardIndex, int deckIndex, int seatIndex)? seat,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AvailableCardIndex value) custom,
    required TResult Function(DeckCardIndex value) deck,
    required TResult Function(SeatCardIndex value) seat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AvailableCardIndex value)? custom,
    TResult? Function(DeckCardIndex value)? deck,
    TResult? Function(SeatCardIndex value)? seat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AvailableCardIndex value)? custom,
    TResult Function(DeckCardIndex value)? deck,
    TResult Function(SeatCardIndex value)? seat,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardIndexCopyWith<$Res> {
  factory $CardIndexCopyWith(CardIndex value, $Res Function(CardIndex) then) =
      _$CardIndexCopyWithImpl<$Res, CardIndex>;
}

/// @nodoc
class _$CardIndexCopyWithImpl<$Res, $Val extends CardIndex>
    implements $CardIndexCopyWith<$Res> {
  _$CardIndexCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AvailableCardIndexImplCopyWith<$Res> {
  factory _$$AvailableCardIndexImplCopyWith(_$AvailableCardIndexImpl value,
          $Res Function(_$AvailableCardIndexImpl) then) =
      __$$AvailableCardIndexImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GameCard card});

  $GameCardCopyWith<$Res> get card;
}

/// @nodoc
class __$$AvailableCardIndexImplCopyWithImpl<$Res>
    extends _$CardIndexCopyWithImpl<$Res, _$AvailableCardIndexImpl>
    implements _$$AvailableCardIndexImplCopyWith<$Res> {
  __$$AvailableCardIndexImplCopyWithImpl(_$AvailableCardIndexImpl _value,
      $Res Function(_$AvailableCardIndexImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? card = null,
  }) {
    return _then(_$AvailableCardIndexImpl(
      null == card
          ? _value.card
          : card // ignore: cast_nullable_to_non_nullable
              as GameCard,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $GameCardCopyWith<$Res> get card {
    return $GameCardCopyWith<$Res>(_value.card, (value) {
      return _then(_value.copyWith(card: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailableCardIndexImpl implements AvailableCardIndex {
  const _$AvailableCardIndexImpl(this.card, {final String? $type})
      : $type = $type ?? 'custom';

  factory _$AvailableCardIndexImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailableCardIndexImplFromJson(json);

  @override
  final GameCard card;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'CardIndex.custom(card: $card)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableCardIndexImpl &&
            (identical(other.card, card) || other.card == card));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, card);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableCardIndexImplCopyWith<_$AvailableCardIndexImpl> get copyWith =>
      __$$AvailableCardIndexImplCopyWithImpl<_$AvailableCardIndexImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameCard card) custom,
    required TResult Function(int cardIndex, int deckIndex) deck,
    required TResult Function(int cardIndex, int deckIndex, int seatIndex) seat,
  }) {
    return custom(card);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameCard card)? custom,
    TResult? Function(int cardIndex, int deckIndex)? deck,
    TResult? Function(int cardIndex, int deckIndex, int seatIndex)? seat,
  }) {
    return custom?.call(card);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameCard card)? custom,
    TResult Function(int cardIndex, int deckIndex)? deck,
    TResult Function(int cardIndex, int deckIndex, int seatIndex)? seat,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(card);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AvailableCardIndex value) custom,
    required TResult Function(DeckCardIndex value) deck,
    required TResult Function(SeatCardIndex value) seat,
  }) {
    return custom(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AvailableCardIndex value)? custom,
    TResult? Function(DeckCardIndex value)? deck,
    TResult? Function(SeatCardIndex value)? seat,
  }) {
    return custom?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AvailableCardIndex value)? custom,
    TResult Function(DeckCardIndex value)? deck,
    TResult Function(SeatCardIndex value)? seat,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailableCardIndexImplToJson(
      this,
    );
  }
}

abstract class AvailableCardIndex implements CardIndex {
  const factory AvailableCardIndex(final GameCard card) =
      _$AvailableCardIndexImpl;

  factory AvailableCardIndex.fromJson(Map<String, dynamic> json) =
      _$AvailableCardIndexImpl.fromJson;

  GameCard get card;
  @JsonKey(ignore: true)
  _$$AvailableCardIndexImplCopyWith<_$AvailableCardIndexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeckCardIndexImplCopyWith<$Res> {
  factory _$$DeckCardIndexImplCopyWith(
          _$DeckCardIndexImpl value, $Res Function(_$DeckCardIndexImpl) then) =
      __$$DeckCardIndexImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int cardIndex, int deckIndex});
}

/// @nodoc
class __$$DeckCardIndexImplCopyWithImpl<$Res>
    extends _$CardIndexCopyWithImpl<$Res, _$DeckCardIndexImpl>
    implements _$$DeckCardIndexImplCopyWith<$Res> {
  __$$DeckCardIndexImplCopyWithImpl(
      _$DeckCardIndexImpl _value, $Res Function(_$DeckCardIndexImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardIndex = null,
    Object? deckIndex = null,
  }) {
    return _then(_$DeckCardIndexImpl(
      null == cardIndex
          ? _value.cardIndex
          : cardIndex // ignore: cast_nullable_to_non_nullable
              as int,
      null == deckIndex
          ? _value.deckIndex
          : deckIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeckCardIndexImpl implements DeckCardIndex {
  const _$DeckCardIndexImpl(this.cardIndex, this.deckIndex,
      {final String? $type})
      : $type = $type ?? 'deck';

  factory _$DeckCardIndexImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeckCardIndexImplFromJson(json);

  @override
  final int cardIndex;
  @override
  final int deckIndex;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'CardIndex.deck(cardIndex: $cardIndex, deckIndex: $deckIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckCardIndexImpl &&
            (identical(other.cardIndex, cardIndex) ||
                other.cardIndex == cardIndex) &&
            (identical(other.deckIndex, deckIndex) ||
                other.deckIndex == deckIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cardIndex, deckIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckCardIndexImplCopyWith<_$DeckCardIndexImpl> get copyWith =>
      __$$DeckCardIndexImplCopyWithImpl<_$DeckCardIndexImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameCard card) custom,
    required TResult Function(int cardIndex, int deckIndex) deck,
    required TResult Function(int cardIndex, int deckIndex, int seatIndex) seat,
  }) {
    return deck(cardIndex, deckIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameCard card)? custom,
    TResult? Function(int cardIndex, int deckIndex)? deck,
    TResult? Function(int cardIndex, int deckIndex, int seatIndex)? seat,
  }) {
    return deck?.call(cardIndex, deckIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameCard card)? custom,
    TResult Function(int cardIndex, int deckIndex)? deck,
    TResult Function(int cardIndex, int deckIndex, int seatIndex)? seat,
    required TResult orElse(),
  }) {
    if (deck != null) {
      return deck(cardIndex, deckIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AvailableCardIndex value) custom,
    required TResult Function(DeckCardIndex value) deck,
    required TResult Function(SeatCardIndex value) seat,
  }) {
    return deck(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AvailableCardIndex value)? custom,
    TResult? Function(DeckCardIndex value)? deck,
    TResult? Function(SeatCardIndex value)? seat,
  }) {
    return deck?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AvailableCardIndex value)? custom,
    TResult Function(DeckCardIndex value)? deck,
    TResult Function(SeatCardIndex value)? seat,
    required TResult orElse(),
  }) {
    if (deck != null) {
      return deck(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DeckCardIndexImplToJson(
      this,
    );
  }
}

abstract class DeckCardIndex implements CardIndex {
  const factory DeckCardIndex(final int cardIndex, final int deckIndex) =
      _$DeckCardIndexImpl;

  factory DeckCardIndex.fromJson(Map<String, dynamic> json) =
      _$DeckCardIndexImpl.fromJson;

  int get cardIndex;
  int get deckIndex;
  @JsonKey(ignore: true)
  _$$DeckCardIndexImplCopyWith<_$DeckCardIndexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SeatCardIndexImplCopyWith<$Res> {
  factory _$$SeatCardIndexImplCopyWith(
          _$SeatCardIndexImpl value, $Res Function(_$SeatCardIndexImpl) then) =
      __$$SeatCardIndexImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int cardIndex, int deckIndex, int seatIndex});
}

/// @nodoc
class __$$SeatCardIndexImplCopyWithImpl<$Res>
    extends _$CardIndexCopyWithImpl<$Res, _$SeatCardIndexImpl>
    implements _$$SeatCardIndexImplCopyWith<$Res> {
  __$$SeatCardIndexImplCopyWithImpl(
      _$SeatCardIndexImpl _value, $Res Function(_$SeatCardIndexImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardIndex = null,
    Object? deckIndex = null,
    Object? seatIndex = null,
  }) {
    return _then(_$SeatCardIndexImpl(
      null == cardIndex
          ? _value.cardIndex
          : cardIndex // ignore: cast_nullable_to_non_nullable
              as int,
      null == deckIndex
          ? _value.deckIndex
          : deckIndex // ignore: cast_nullable_to_non_nullable
              as int,
      null == seatIndex
          ? _value.seatIndex
          : seatIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeatCardIndexImpl implements SeatCardIndex {
  const _$SeatCardIndexImpl(this.cardIndex, this.deckIndex, this.seatIndex,
      {final String? $type})
      : $type = $type ?? 'seat';

  factory _$SeatCardIndexImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatCardIndexImplFromJson(json);

  @override
  final int cardIndex;
  @override
  final int deckIndex;
  @override
  final int seatIndex;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'CardIndex.seat(cardIndex: $cardIndex, deckIndex: $deckIndex, seatIndex: $seatIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatCardIndexImpl &&
            (identical(other.cardIndex, cardIndex) ||
                other.cardIndex == cardIndex) &&
            (identical(other.deckIndex, deckIndex) ||
                other.deckIndex == deckIndex) &&
            (identical(other.seatIndex, seatIndex) ||
                other.seatIndex == seatIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cardIndex, deckIndex, seatIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatCardIndexImplCopyWith<_$SeatCardIndexImpl> get copyWith =>
      __$$SeatCardIndexImplCopyWithImpl<_$SeatCardIndexImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameCard card) custom,
    required TResult Function(int cardIndex, int deckIndex) deck,
    required TResult Function(int cardIndex, int deckIndex, int seatIndex) seat,
  }) {
    return seat(cardIndex, deckIndex, seatIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameCard card)? custom,
    TResult? Function(int cardIndex, int deckIndex)? deck,
    TResult? Function(int cardIndex, int deckIndex, int seatIndex)? seat,
  }) {
    return seat?.call(cardIndex, deckIndex, seatIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameCard card)? custom,
    TResult Function(int cardIndex, int deckIndex)? deck,
    TResult Function(int cardIndex, int deckIndex, int seatIndex)? seat,
    required TResult orElse(),
  }) {
    if (seat != null) {
      return seat(cardIndex, deckIndex, seatIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AvailableCardIndex value) custom,
    required TResult Function(DeckCardIndex value) deck,
    required TResult Function(SeatCardIndex value) seat,
  }) {
    return seat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AvailableCardIndex value)? custom,
    TResult? Function(DeckCardIndex value)? deck,
    TResult? Function(SeatCardIndex value)? seat,
  }) {
    return seat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AvailableCardIndex value)? custom,
    TResult Function(DeckCardIndex value)? deck,
    TResult Function(SeatCardIndex value)? seat,
    required TResult orElse(),
  }) {
    if (seat != null) {
      return seat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatCardIndexImplToJson(
      this,
    );
  }
}

abstract class SeatCardIndex implements CardIndex {
  const factory SeatCardIndex(
          final int cardIndex, final int deckIndex, final int seatIndex) =
      _$SeatCardIndexImpl;

  factory SeatCardIndex.fromJson(Map<String, dynamic> json) =
      _$SeatCardIndexImpl.fromJson;

  int get cardIndex;
  int get deckIndex;
  int get seatIndex;
  @JsonKey(ignore: true)
  _$$SeatCardIndexImplCopyWith<_$SeatCardIndexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
