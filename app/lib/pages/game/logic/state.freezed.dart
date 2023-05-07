// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameCard _$GameCardFromJson(Map<String, dynamic> json) {
  return ClassicGameCard.fromJson(json);
}

/// @nodoc
mixin _$GameCard {
  GameCardColor get color => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameCardColor color, int number) classic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameCardColor color, int number)? classic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameCardColor color, int number)? classic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassicGameCard value) classic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassicGameCard value)? classic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassicGameCard value)? classic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCardCopyWith<GameCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCardCopyWith<$Res> {
  factory $GameCardCopyWith(GameCard value, $Res Function(GameCard) then) =
      _$GameCardCopyWithImpl<$Res, GameCard>;
  @useResult
  $Res call({GameCardColor color, int number});
}

/// @nodoc
class _$GameCardCopyWithImpl<$Res, $Val extends GameCard>
    implements $GameCardCopyWith<$Res> {
  _$GameCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? number = null,
  }) {
    return _then(_value.copyWith(
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as GameCardColor,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassicGameCardCopyWith<$Res>
    implements $GameCardCopyWith<$Res> {
  factory _$$ClassicGameCardCopyWith(
          _$ClassicGameCard value, $Res Function(_$ClassicGameCard) then) =
      __$$ClassicGameCardCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GameCardColor color, int number});
}

/// @nodoc
class __$$ClassicGameCardCopyWithImpl<$Res>
    extends _$GameCardCopyWithImpl<$Res, _$ClassicGameCard>
    implements _$$ClassicGameCardCopyWith<$Res> {
  __$$ClassicGameCardCopyWithImpl(
      _$ClassicGameCard _value, $Res Function(_$ClassicGameCard) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? number = null,
  }) {
    return _then(_$ClassicGameCard(
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as GameCardColor,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassicGameCard implements ClassicGameCard {
  const _$ClassicGameCard({this.color = GameCardColor.heart, this.number = 1});

  factory _$ClassicGameCard.fromJson(Map<String, dynamic> json) =>
      _$$ClassicGameCardFromJson(json);

  @override
  @JsonKey()
  final GameCardColor color;
  @override
  @JsonKey()
  final int number;

  @override
  String toString() {
    return 'GameCard.classic(color: $color, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassicGameCard &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.number, number) || other.number == number));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, color, number);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassicGameCardCopyWith<_$ClassicGameCard> get copyWith =>
      __$$ClassicGameCardCopyWithImpl<_$ClassicGameCard>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameCardColor color, int number) classic,
  }) {
    return classic(color, number);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameCardColor color, int number)? classic,
  }) {
    return classic?.call(color, number);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameCardColor color, int number)? classic,
    required TResult orElse(),
  }) {
    if (classic != null) {
      return classic(color, number);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassicGameCard value) classic,
  }) {
    return classic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassicGameCard value)? classic,
  }) {
    return classic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassicGameCard value)? classic,
    required TResult orElse(),
  }) {
    if (classic != null) {
      return classic(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassicGameCardToJson(
      this,
    );
  }
}

abstract class ClassicGameCard implements GameCard {
  const factory ClassicGameCard({final GameCardColor color, final int number}) =
      _$ClassicGameCard;

  factory ClassicGameCard.fromJson(Map<String, dynamic> json) =
      _$ClassicGameCard.fromJson;

  @override
  GameCardColor get color;
  @override
  int get number;
  @override
  @JsonKey(ignore: true)
  _$$ClassicGameCardCopyWith<_$ClassicGameCard> get copyWith =>
      throw _privateConstructorUsedError;
}

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  List<GameDeck> get decks => throw _privateConstructorUsedError;
  Map<String, GameDeck> get playerDecks => throw _privateConstructorUsedError;
  GameDeck get playerDeck => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {List<GameDeck> decks,
      Map<String, GameDeck> playerDecks,
      GameDeck playerDeck});

  $GameDeckCopyWith<$Res> get playerDeck;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decks = null,
    Object? playerDecks = null,
    Object? playerDeck = null,
  }) {
    return _then(_value.copyWith(
      decks: null == decks
          ? _value.decks
          : decks // ignore: cast_nullable_to_non_nullable
              as List<GameDeck>,
      playerDecks: null == playerDecks
          ? _value.playerDecks
          : playerDecks // ignore: cast_nullable_to_non_nullable
              as Map<String, GameDeck>,
      playerDeck: null == playerDeck
          ? _value.playerDeck
          : playerDeck // ignore: cast_nullable_to_non_nullable
              as GameDeck,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameDeckCopyWith<$Res> get playerDeck {
    return $GameDeckCopyWith<$Res>(_value.playerDeck, (value) {
      return _then(_value.copyWith(playerDeck: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$$_GameStateCopyWith(
          _$_GameState value, $Res Function(_$_GameState) then) =
      __$$_GameStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<GameDeck> decks,
      Map<String, GameDeck> playerDecks,
      GameDeck playerDeck});

  @override
  $GameDeckCopyWith<$Res> get playerDeck;
}

/// @nodoc
class __$$_GameStateCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$_GameState>
    implements _$$_GameStateCopyWith<$Res> {
  __$$_GameStateCopyWithImpl(
      _$_GameState _value, $Res Function(_$_GameState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decks = null,
    Object? playerDecks = null,
    Object? playerDeck = null,
  }) {
    return _then(_$_GameState(
      decks: null == decks
          ? _value._decks
          : decks // ignore: cast_nullable_to_non_nullable
              as List<GameDeck>,
      playerDecks: null == playerDecks
          ? _value._playerDecks
          : playerDecks // ignore: cast_nullable_to_non_nullable
              as Map<String, GameDeck>,
      playerDeck: null == playerDeck
          ? _value.playerDeck
          : playerDeck // ignore: cast_nullable_to_non_nullable
              as GameDeck,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameState extends _GameState {
  const _$_GameState(
      {final List<GameDeck> decks = const [],
      final Map<String, GameDeck> playerDecks = const {},
      this.playerDeck = const GameDeck()})
      : _decks = decks,
        _playerDecks = playerDecks,
        super._();

  factory _$_GameState.fromJson(Map<String, dynamic> json) =>
      _$$_GameStateFromJson(json);

  final List<GameDeck> _decks;
  @override
  @JsonKey()
  List<GameDeck> get decks {
    if (_decks is EqualUnmodifiableListView) return _decks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_decks);
  }

  final Map<String, GameDeck> _playerDecks;
  @override
  @JsonKey()
  Map<String, GameDeck> get playerDecks {
    if (_playerDecks is EqualUnmodifiableMapView) return _playerDecks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerDecks);
  }

  @override
  @JsonKey()
  final GameDeck playerDeck;

  @override
  String toString() {
    return 'GameState(decks: $decks, playerDecks: $playerDecks, playerDeck: $playerDeck)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameState &&
            const DeepCollectionEquality().equals(other._decks, _decks) &&
            const DeepCollectionEquality()
                .equals(other._playerDecks, _playerDecks) &&
            (identical(other.playerDeck, playerDeck) ||
                other.playerDeck == playerDeck));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_decks),
      const DeepCollectionEquality().hash(_playerDecks),
      playerDeck);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      __$$_GameStateCopyWithImpl<_$_GameState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameStateToJson(
      this,
    );
  }
}

abstract class _GameState extends GameState {
  const factory _GameState(
      {final List<GameDeck> decks,
      final Map<String, GameDeck> playerDecks,
      final GameDeck playerDeck}) = _$_GameState;
  const _GameState._() : super._();

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$_GameState.fromJson;

  @override
  List<GameDeck> get decks;
  @override
  Map<String, GameDeck> get playerDecks;
  @override
  GameDeck get playerDeck;
  @override
  @JsonKey(ignore: true)
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

DeckRefill _$DeckRefillFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'none':
      return _DeckRefillNone.fromJson(json);
    case 'shuffle':
      return _DeckRefillShuffle.fromJson(json);
    case 'first':
      return _DeckRefillFirst.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'DeckRefill',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$DeckRefill {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(int? count) shuffle,
    required TResult Function(int? count) first,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(int? count)? shuffle,
    TResult? Function(int? count)? first,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(int? count)? shuffle,
    TResult Function(int? count)? first,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DeckRefillNone value) none,
    required TResult Function(_DeckRefillShuffle value) shuffle,
    required TResult Function(_DeckRefillFirst value) first,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DeckRefillNone value)? none,
    TResult? Function(_DeckRefillShuffle value)? shuffle,
    TResult? Function(_DeckRefillFirst value)? first,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DeckRefillNone value)? none,
    TResult Function(_DeckRefillShuffle value)? shuffle,
    TResult Function(_DeckRefillFirst value)? first,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckRefillCopyWith<$Res> {
  factory $DeckRefillCopyWith(
          DeckRefill value, $Res Function(DeckRefill) then) =
      _$DeckRefillCopyWithImpl<$Res, DeckRefill>;
}

/// @nodoc
class _$DeckRefillCopyWithImpl<$Res, $Val extends DeckRefill>
    implements $DeckRefillCopyWith<$Res> {
  _$DeckRefillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_DeckRefillNoneCopyWith<$Res> {
  factory _$$_DeckRefillNoneCopyWith(
          _$_DeckRefillNone value, $Res Function(_$_DeckRefillNone) then) =
      __$$_DeckRefillNoneCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_DeckRefillNoneCopyWithImpl<$Res>
    extends _$DeckRefillCopyWithImpl<$Res, _$_DeckRefillNone>
    implements _$$_DeckRefillNoneCopyWith<$Res> {
  __$$_DeckRefillNoneCopyWithImpl(
      _$_DeckRefillNone _value, $Res Function(_$_DeckRefillNone) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_DeckRefillNone implements _DeckRefillNone {
  const _$_DeckRefillNone({final String? $type}) : $type = $type ?? 'none';

  factory _$_DeckRefillNone.fromJson(Map<String, dynamic> json) =>
      _$$_DeckRefillNoneFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DeckRefill.none()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_DeckRefillNone);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(int? count) shuffle,
    required TResult Function(int? count) first,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(int? count)? shuffle,
    TResult? Function(int? count)? first,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(int? count)? shuffle,
    TResult Function(int? count)? first,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DeckRefillNone value) none,
    required TResult Function(_DeckRefillShuffle value) shuffle,
    required TResult Function(_DeckRefillFirst value) first,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DeckRefillNone value)? none,
    TResult? Function(_DeckRefillShuffle value)? shuffle,
    TResult? Function(_DeckRefillFirst value)? first,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DeckRefillNone value)? none,
    TResult Function(_DeckRefillShuffle value)? shuffle,
    TResult Function(_DeckRefillFirst value)? first,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeckRefillNoneToJson(
      this,
    );
  }
}

abstract class _DeckRefillNone implements DeckRefill {
  const factory _DeckRefillNone() = _$_DeckRefillNone;

  factory _DeckRefillNone.fromJson(Map<String, dynamic> json) =
      _$_DeckRefillNone.fromJson;
}

/// @nodoc
abstract class _$$_DeckRefillShuffleCopyWith<$Res> {
  factory _$$_DeckRefillShuffleCopyWith(_$_DeckRefillShuffle value,
          $Res Function(_$_DeckRefillShuffle) then) =
      __$$_DeckRefillShuffleCopyWithImpl<$Res>;
  @useResult
  $Res call({int? count});
}

/// @nodoc
class __$$_DeckRefillShuffleCopyWithImpl<$Res>
    extends _$DeckRefillCopyWithImpl<$Res, _$_DeckRefillShuffle>
    implements _$$_DeckRefillShuffleCopyWith<$Res> {
  __$$_DeckRefillShuffleCopyWithImpl(
      _$_DeckRefillShuffle _value, $Res Function(_$_DeckRefillShuffle) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
  }) {
    return _then(_$_DeckRefillShuffle(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DeckRefillShuffle implements _DeckRefillShuffle {
  const _$_DeckRefillShuffle({this.count, final String? $type})
      : $type = $type ?? 'shuffle';

  factory _$_DeckRefillShuffle.fromJson(Map<String, dynamic> json) =>
      _$$_DeckRefillShuffleFromJson(json);

  @override
  final int? count;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DeckRefill.shuffle(count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeckRefillShuffle &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeckRefillShuffleCopyWith<_$_DeckRefillShuffle> get copyWith =>
      __$$_DeckRefillShuffleCopyWithImpl<_$_DeckRefillShuffle>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(int? count) shuffle,
    required TResult Function(int? count) first,
  }) {
    return shuffle(count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(int? count)? shuffle,
    TResult? Function(int? count)? first,
  }) {
    return shuffle?.call(count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(int? count)? shuffle,
    TResult Function(int? count)? first,
    required TResult orElse(),
  }) {
    if (shuffle != null) {
      return shuffle(count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DeckRefillNone value) none,
    required TResult Function(_DeckRefillShuffle value) shuffle,
    required TResult Function(_DeckRefillFirst value) first,
  }) {
    return shuffle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DeckRefillNone value)? none,
    TResult? Function(_DeckRefillShuffle value)? shuffle,
    TResult? Function(_DeckRefillFirst value)? first,
  }) {
    return shuffle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DeckRefillNone value)? none,
    TResult Function(_DeckRefillShuffle value)? shuffle,
    TResult Function(_DeckRefillFirst value)? first,
    required TResult orElse(),
  }) {
    if (shuffle != null) {
      return shuffle(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeckRefillShuffleToJson(
      this,
    );
  }
}

abstract class _DeckRefillShuffle implements DeckRefill {
  const factory _DeckRefillShuffle({final int? count}) = _$_DeckRefillShuffle;

  factory _DeckRefillShuffle.fromJson(Map<String, dynamic> json) =
      _$_DeckRefillShuffle.fromJson;

  int? get count;
  @JsonKey(ignore: true)
  _$$_DeckRefillShuffleCopyWith<_$_DeckRefillShuffle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_DeckRefillFirstCopyWith<$Res> {
  factory _$$_DeckRefillFirstCopyWith(
          _$_DeckRefillFirst value, $Res Function(_$_DeckRefillFirst) then) =
      __$$_DeckRefillFirstCopyWithImpl<$Res>;
  @useResult
  $Res call({int? count});
}

/// @nodoc
class __$$_DeckRefillFirstCopyWithImpl<$Res>
    extends _$DeckRefillCopyWithImpl<$Res, _$_DeckRefillFirst>
    implements _$$_DeckRefillFirstCopyWith<$Res> {
  __$$_DeckRefillFirstCopyWithImpl(
      _$_DeckRefillFirst _value, $Res Function(_$_DeckRefillFirst) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
  }) {
    return _then(_$_DeckRefillFirst(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DeckRefillFirst implements _DeckRefillFirst {
  const _$_DeckRefillFirst({this.count, final String? $type})
      : $type = $type ?? 'first';

  factory _$_DeckRefillFirst.fromJson(Map<String, dynamic> json) =>
      _$$_DeckRefillFirstFromJson(json);

  @override
  final int? count;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DeckRefill.first(count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeckRefillFirst &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeckRefillFirstCopyWith<_$_DeckRefillFirst> get copyWith =>
      __$$_DeckRefillFirstCopyWithImpl<_$_DeckRefillFirst>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(int? count) shuffle,
    required TResult Function(int? count) first,
  }) {
    return first(count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(int? count)? shuffle,
    TResult? Function(int? count)? first,
  }) {
    return first?.call(count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(int? count)? shuffle,
    TResult Function(int? count)? first,
    required TResult orElse(),
  }) {
    if (first != null) {
      return first(count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DeckRefillNone value) none,
    required TResult Function(_DeckRefillShuffle value) shuffle,
    required TResult Function(_DeckRefillFirst value) first,
  }) {
    return first(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DeckRefillNone value)? none,
    TResult? Function(_DeckRefillShuffle value)? shuffle,
    TResult? Function(_DeckRefillFirst value)? first,
  }) {
    return first?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DeckRefillNone value)? none,
    TResult Function(_DeckRefillShuffle value)? shuffle,
    TResult Function(_DeckRefillFirst value)? first,
    required TResult orElse(),
  }) {
    if (first != null) {
      return first(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeckRefillFirstToJson(
      this,
    );
  }
}

abstract class _DeckRefillFirst implements DeckRefill {
  const factory _DeckRefillFirst({final int? count}) = _$_DeckRefillFirst;

  factory _DeckRefillFirst.fromJson(Map<String, dynamic> json) =
      _$_DeckRefillFirst.fromJson;

  int? get count;
  @JsonKey(ignore: true)
  _$$_DeckRefillFirstCopyWith<_$_DeckRefillFirst> get copyWith =>
      throw _privateConstructorUsedError;
}

GameDeck _$GameDeckFromJson(Map<String, dynamic> json) {
  return _GameDeck.fromJson(json);
}

/// @nodoc
mixin _$GameDeck {
  String get name => throw _privateConstructorUsedError;
  DeckVisibility get visibility => throw _privateConstructorUsedError;
  List<GameCard> get cards => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameDeckCopyWith<GameDeck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameDeckCopyWith<$Res> {
  factory $GameDeckCopyWith(GameDeck value, $Res Function(GameDeck) then) =
      _$GameDeckCopyWithImpl<$Res, GameDeck>;
  @useResult
  $Res call({String name, DeckVisibility visibility, List<GameCard> cards});
}

/// @nodoc
class _$GameDeckCopyWithImpl<$Res, $Val extends GameDeck>
    implements $GameDeckCopyWith<$Res> {
  _$GameDeckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? visibility = null,
    Object? cards = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as DeckVisibility,
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<GameCard>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameDeckCopyWith<$Res> implements $GameDeckCopyWith<$Res> {
  factory _$$_GameDeckCopyWith(
          _$_GameDeck value, $Res Function(_$_GameDeck) then) =
      __$$_GameDeckCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, DeckVisibility visibility, List<GameCard> cards});
}

/// @nodoc
class __$$_GameDeckCopyWithImpl<$Res>
    extends _$GameDeckCopyWithImpl<$Res, _$_GameDeck>
    implements _$$_GameDeckCopyWith<$Res> {
  __$$_GameDeckCopyWithImpl(
      _$_GameDeck _value, $Res Function(_$_GameDeck) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? visibility = null,
    Object? cards = null,
  }) {
    return _then(_$_GameDeck(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as DeckVisibility,
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<GameCard>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameDeck implements _GameDeck {
  const _$_GameDeck(
      {this.name = '',
      this.visibility = DeckVisibility.hidden,
      final List<GameCard> cards = const []})
      : _cards = cards;

  factory _$_GameDeck.fromJson(Map<String, dynamic> json) =>
      _$$_GameDeckFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final DeckVisibility visibility;
  final List<GameCard> _cards;
  @override
  @JsonKey()
  List<GameCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'GameDeck(name: $name, visibility: $visibility, cards: $cards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameDeck &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, visibility,
      const DeepCollectionEquality().hash(_cards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameDeckCopyWith<_$_GameDeck> get copyWith =>
      __$$_GameDeckCopyWithImpl<_$_GameDeck>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameDeckToJson(
      this,
    );
  }
}

abstract class _GameDeck implements GameDeck {
  const factory _GameDeck(
      {final String name,
      final DeckVisibility visibility,
      final List<GameCard> cards}) = _$_GameDeck;

  factory _GameDeck.fromJson(Map<String, dynamic> json) = _$_GameDeck.fromJson;

  @override
  String get name;
  @override
  DeckVisibility get visibility;
  @override
  List<GameCard> get cards;
  @override
  @JsonKey(ignore: true)
  _$$_GameDeckCopyWith<_$_GameDeck> get copyWith =>
      throw _privateConstructorUsedError;
}
