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
  ClassicGameCardColor get color => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ClassicGameCardColor color, int number) classic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ClassicGameCardColor color, int number)? classic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ClassicGameCardColor color, int number)? classic,
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
  $Res call({ClassicGameCardColor color, int number});
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
              as ClassicGameCardColor,
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
  $Res call({ClassicGameCardColor color, int number});
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
              as ClassicGameCardColor,
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
  const _$ClassicGameCard(
      {this.color = ClassicGameCardColor.heart, this.number = 1});

  factory _$ClassicGameCard.fromJson(Map<String, dynamic> json) =>
      _$$ClassicGameCardFromJson(json);

  @override
  @JsonKey()
  final ClassicGameCardColor color;
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
    required TResult Function(ClassicGameCardColor color, int number) classic,
  }) {
    return classic(color, number);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ClassicGameCardColor color, int number)? classic,
  }) {
    return classic?.call(color, number);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ClassicGameCardColor color, int number)? classic,
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
  const factory ClassicGameCard(
      {final ClassicGameCardColor color, final int number}) = _$ClassicGameCard;

  factory ClassicGameCard.fromJson(Map<String, dynamic> json) =
      _$ClassicGameCard.fromJson;

  @override
  ClassicGameCardColor get color;
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
  List<GameSeat> get seats => throw _privateConstructorUsedError;

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
  $Res call({List<GameDeck> decks, List<GameSeat> seats});
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
    Object? seats = null,
  }) {
    return _then(_value.copyWith(
      decks: null == decks
          ? _value.decks
          : decks // ignore: cast_nullable_to_non_nullable
              as List<GameDeck>,
      seats: null == seats
          ? _value.seats
          : seats // ignore: cast_nullable_to_non_nullable
              as List<GameSeat>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$$_GameStateCopyWith(
          _$_GameState value, $Res Function(_$_GameState) then) =
      __$$_GameStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GameDeck> decks, List<GameSeat> seats});
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
    Object? seats = null,
  }) {
    return _then(_$_GameState(
      decks: null == decks
          ? _value._decks
          : decks // ignore: cast_nullable_to_non_nullable
              as List<GameDeck>,
      seats: null == seats
          ? _value._seats
          : seats // ignore: cast_nullable_to_non_nullable
              as List<GameSeat>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameState extends _GameState {
  const _$_GameState(
      {final List<GameDeck> decks = const [],
      final List<GameSeat> seats = const []})
      : _decks = decks,
        _seats = seats,
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

  final List<GameSeat> _seats;
  @override
  @JsonKey()
  List<GameSeat> get seats {
    if (_seats is EqualUnmodifiableListView) return _seats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seats);
  }

  @override
  String toString() {
    return 'GameState(decks: $decks, seats: $seats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameState &&
            const DeepCollectionEquality().equals(other._decks, _decks) &&
            const DeepCollectionEquality().equals(other._seats, _seats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_decks),
      const DeepCollectionEquality().hash(_seats));

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
      {final List<GameDeck> decks, final List<GameSeat> seats}) = _$_GameState;
  const _GameState._() : super._();

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$_GameState.fromJson;

  @override
  List<GameDeck> get decks;
  @override
  List<GameSeat> get seats;
  @override
  @JsonKey(ignore: true)
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

GameSeat _$GameSeatFromJson(Map<String, dynamic> json) {
  return _GameSeat.fromJson(json);
}

/// @nodoc
mixin _$GameSeat {
  String get name => throw _privateConstructorUsedError;
  List<GameDeck> get decks => throw _privateConstructorUsedError;
  List<int> get players => throw _privateConstructorUsedError;
  DeckVisibility? get ownDeckVisibility => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameSeatCopyWith<GameSeat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameSeatCopyWith<$Res> {
  factory $GameSeatCopyWith(GameSeat value, $Res Function(GameSeat) then) =
      _$GameSeatCopyWithImpl<$Res, GameSeat>;
  @useResult
  $Res call(
      {String name,
      List<GameDeck> decks,
      List<int> players,
      DeckVisibility? ownDeckVisibility});
}

/// @nodoc
class _$GameSeatCopyWithImpl<$Res, $Val extends GameSeat>
    implements $GameSeatCopyWith<$Res> {
  _$GameSeatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? decks = null,
    Object? players = null,
    Object? ownDeckVisibility = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      decks: null == decks
          ? _value.decks
          : decks // ignore: cast_nullable_to_non_nullable
              as List<GameDeck>,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<int>,
      ownDeckVisibility: freezed == ownDeckVisibility
          ? _value.ownDeckVisibility
          : ownDeckVisibility // ignore: cast_nullable_to_non_nullable
              as DeckVisibility?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameSeatCopyWith<$Res> implements $GameSeatCopyWith<$Res> {
  factory _$$_GameSeatCopyWith(
          _$_GameSeat value, $Res Function(_$_GameSeat) then) =
      __$$_GameSeatCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      List<GameDeck> decks,
      List<int> players,
      DeckVisibility? ownDeckVisibility});
}

/// @nodoc
class __$$_GameSeatCopyWithImpl<$Res>
    extends _$GameSeatCopyWithImpl<$Res, _$_GameSeat>
    implements _$$_GameSeatCopyWith<$Res> {
  __$$_GameSeatCopyWithImpl(
      _$_GameSeat _value, $Res Function(_$_GameSeat) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? decks = null,
    Object? players = null,
    Object? ownDeckVisibility = freezed,
  }) {
    return _then(_$_GameSeat(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      decks: null == decks
          ? _value._decks
          : decks // ignore: cast_nullable_to_non_nullable
              as List<GameDeck>,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<int>,
      ownDeckVisibility: freezed == ownDeckVisibility
          ? _value.ownDeckVisibility
          : ownDeckVisibility // ignore: cast_nullable_to_non_nullable
              as DeckVisibility?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameSeat extends _GameSeat {
  const _$_GameSeat(
      {this.name = '',
      final List<GameDeck> decks = const [],
      final List<int> players = const [],
      this.ownDeckVisibility})
      : _decks = decks,
        _players = players,
        super._();

  factory _$_GameSeat.fromJson(Map<String, dynamic> json) =>
      _$$_GameSeatFromJson(json);

  @override
  @JsonKey()
  final String name;
  final List<GameDeck> _decks;
  @override
  @JsonKey()
  List<GameDeck> get decks {
    if (_decks is EqualUnmodifiableListView) return _decks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_decks);
  }

  final List<int> _players;
  @override
  @JsonKey()
  List<int> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  final DeckVisibility? ownDeckVisibility;

  @override
  String toString() {
    return 'GameSeat(name: $name, decks: $decks, players: $players, ownDeckVisibility: $ownDeckVisibility)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameSeat &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._decks, _decks) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.ownDeckVisibility, ownDeckVisibility) ||
                other.ownDeckVisibility == ownDeckVisibility));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_decks),
      const DeepCollectionEquality().hash(_players),
      ownDeckVisibility);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameSeatCopyWith<_$_GameSeat> get copyWith =>
      __$$_GameSeatCopyWithImpl<_$_GameSeat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameSeatToJson(
      this,
    );
  }
}

abstract class _GameSeat extends GameSeat {
  const factory _GameSeat(
      {final String name,
      final List<GameDeck> decks,
      final List<int> players,
      final DeckVisibility? ownDeckVisibility}) = _$_GameSeat;
  const _GameSeat._() : super._();

  factory _GameSeat.fromJson(Map<String, dynamic> json) = _$_GameSeat.fromJson;

  @override
  String get name;
  @override
  List<GameDeck> get decks;
  @override
  List<int> get players;
  @override
  DeckVisibility? get ownDeckVisibility;
  @override
  @JsonKey(ignore: true)
  _$$_GameSeatCopyWith<_$_GameSeat> get copyWith =>
      throw _privateConstructorUsedError;
}

DeckRefill _$DeckRefillFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'none':
      return _DeckRefillNone.fromJson(json);
    case 'shuffle':
      return _DeckRefillShuffle.fromJson(json);
    case 'first':
      return _DeckRefillFirst.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'DeckRefill', 'Invalid union type "${json['type']}"!');
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
class _$_DeckRefillNone extends _DeckRefillNone {
  const _$_DeckRefillNone({final String? $type})
      : $type = $type ?? 'none',
        super._();

  factory _$_DeckRefillNone.fromJson(Map<String, dynamic> json) =>
      _$$_DeckRefillNoneFromJson(json);

  @JsonKey(name: 'type')
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

abstract class _DeckRefillNone extends DeckRefill {
  const factory _DeckRefillNone() = _$_DeckRefillNone;
  const _DeckRefillNone._() : super._();

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
class _$_DeckRefillShuffle extends _DeckRefillShuffle {
  const _$_DeckRefillShuffle({this.count, final String? $type})
      : $type = $type ?? 'shuffle',
        super._();

  factory _$_DeckRefillShuffle.fromJson(Map<String, dynamic> json) =>
      _$$_DeckRefillShuffleFromJson(json);

  @override
  final int? count;

  @JsonKey(name: 'type')
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

abstract class _DeckRefillShuffle extends DeckRefill {
  const factory _DeckRefillShuffle({final int? count}) = _$_DeckRefillShuffle;
  const _DeckRefillShuffle._() : super._();

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
class _$_DeckRefillFirst extends _DeckRefillFirst {
  const _$_DeckRefillFirst({this.count, final String? $type})
      : $type = $type ?? 'first',
        super._();

  factory _$_DeckRefillFirst.fromJson(Map<String, dynamic> json) =>
      _$$_DeckRefillFirstFromJson(json);

  @override
  final int? count;

  @JsonKey(name: 'type')
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

abstract class _DeckRefillFirst extends DeckRefill {
  const factory _DeckRefillFirst({final int? count}) = _$_DeckRefillFirst;
  const _DeckRefillFirst._() : super._();

  factory _DeckRefillFirst.fromJson(Map<String, dynamic> json) =
      _$_DeckRefillFirst.fromJson;

  int? get count;
  @JsonKey(ignore: true)
  _$$_DeckRefillFirstCopyWith<_$_DeckRefillFirst> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CardsRemoveState {
  GameDeck get deck => throw _privateConstructorUsedError;
  List<GameCard> get removedCards => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CardsRemoveStateCopyWith<CardsRemoveState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardsRemoveStateCopyWith<$Res> {
  factory $CardsRemoveStateCopyWith(
          CardsRemoveState value, $Res Function(CardsRemoveState) then) =
      _$CardsRemoveStateCopyWithImpl<$Res, CardsRemoveState>;
  @useResult
  $Res call({GameDeck deck, List<GameCard> removedCards});

  $GameDeckCopyWith<$Res> get deck;
}

/// @nodoc
class _$CardsRemoveStateCopyWithImpl<$Res, $Val extends CardsRemoveState>
    implements $CardsRemoveStateCopyWith<$Res> {
  _$CardsRemoveStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deck = null,
    Object? removedCards = null,
  }) {
    return _then(_value.copyWith(
      deck: null == deck
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as GameDeck,
      removedCards: null == removedCards
          ? _value.removedCards
          : removedCards // ignore: cast_nullable_to_non_nullable
              as List<GameCard>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameDeckCopyWith<$Res> get deck {
    return $GameDeckCopyWith<$Res>(_value.deck, (value) {
      return _then(_value.copyWith(deck: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CardsRemoveStateCopyWith<$Res>
    implements $CardsRemoveStateCopyWith<$Res> {
  factory _$$_CardsRemoveStateCopyWith(
          _$_CardsRemoveState value, $Res Function(_$_CardsRemoveState) then) =
      __$$_CardsRemoveStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GameDeck deck, List<GameCard> removedCards});

  @override
  $GameDeckCopyWith<$Res> get deck;
}

/// @nodoc
class __$$_CardsRemoveStateCopyWithImpl<$Res>
    extends _$CardsRemoveStateCopyWithImpl<$Res, _$_CardsRemoveState>
    implements _$$_CardsRemoveStateCopyWith<$Res> {
  __$$_CardsRemoveStateCopyWithImpl(
      _$_CardsRemoveState _value, $Res Function(_$_CardsRemoveState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deck = null,
    Object? removedCards = null,
  }) {
    return _then(_$_CardsRemoveState(
      deck: null == deck
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as GameDeck,
      removedCards: null == removedCards
          ? _value._removedCards
          : removedCards // ignore: cast_nullable_to_non_nullable
              as List<GameCard>,
    ));
  }
}

/// @nodoc

class _$_CardsRemoveState implements _CardsRemoveState {
  const _$_CardsRemoveState(
      {required this.deck, required final List<GameCard> removedCards})
      : _removedCards = removedCards;

  @override
  final GameDeck deck;
  final List<GameCard> _removedCards;
  @override
  List<GameCard> get removedCards {
    if (_removedCards is EqualUnmodifiableListView) return _removedCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_removedCards);
  }

  @override
  String toString() {
    return 'CardsRemoveState(deck: $deck, removedCards: $removedCards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CardsRemoveState &&
            (identical(other.deck, deck) || other.deck == deck) &&
            const DeepCollectionEquality()
                .equals(other._removedCards, _removedCards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, deck, const DeepCollectionEquality().hash(_removedCards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CardsRemoveStateCopyWith<_$_CardsRemoveState> get copyWith =>
      __$$_CardsRemoveStateCopyWithImpl<_$_CardsRemoveState>(this, _$identity);
}

abstract class _CardsRemoveState implements CardsRemoveState {
  const factory _CardsRemoveState(
      {required final GameDeck deck,
      required final List<GameCard> removedCards}) = _$_CardsRemoveState;

  @override
  GameDeck get deck;
  @override
  List<GameCard> get removedCards;
  @override
  @JsonKey(ignore: true)
  _$$_CardsRemoveStateCopyWith<_$_CardsRemoveState> get copyWith =>
      throw _privateConstructorUsedError;
}

GameDeck _$GameDeckFromJson(Map<String, dynamic> json) {
  return _GameDeck.fromJson(json);
}

/// @nodoc
mixin _$GameDeck {
  String get name => throw _privateConstructorUsedError;
  DeckVisibility get visibility => throw _privateConstructorUsedError;
  DeckVisibility? get ownVisibility => throw _privateConstructorUsedError;
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
  $Res call(
      {String name,
      DeckVisibility visibility,
      DeckVisibility? ownVisibility,
      List<GameCard> cards});
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
    Object? ownVisibility = freezed,
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
      ownVisibility: freezed == ownVisibility
          ? _value.ownVisibility
          : ownVisibility // ignore: cast_nullable_to_non_nullable
              as DeckVisibility?,
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
  $Res call(
      {String name,
      DeckVisibility visibility,
      DeckVisibility? ownVisibility,
      List<GameCard> cards});
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
    Object? ownVisibility = freezed,
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
      ownVisibility: freezed == ownVisibility
          ? _value.ownVisibility
          : ownVisibility // ignore: cast_nullable_to_non_nullable
              as DeckVisibility?,
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<GameCard>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameDeck extends _GameDeck {
  const _$_GameDeck(
      {this.name = '',
      this.visibility = DeckVisibility.hidden,
      this.ownVisibility,
      final List<GameCard> cards = const []})
      : _cards = cards,
        super._();

  factory _$_GameDeck.fromJson(Map<String, dynamic> json) =>
      _$$_GameDeckFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final DeckVisibility visibility;
  @override
  final DeckVisibility? ownVisibility;
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
    return 'GameDeck(name: $name, visibility: $visibility, ownVisibility: $ownVisibility, cards: $cards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameDeck &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.ownVisibility, ownVisibility) ||
                other.ownVisibility == ownVisibility) &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, visibility, ownVisibility,
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

abstract class _GameDeck extends GameDeck {
  const factory _GameDeck(
      {final String name,
      final DeckVisibility visibility,
      final DeckVisibility? ownVisibility,
      final List<GameCard> cards}) = _$_GameDeck;
  const _GameDeck._() : super._();

  factory _GameDeck.fromJson(Map<String, dynamic> json) = _$_GameDeck.fromJson;

  @override
  String get name;
  @override
  DeckVisibility get visibility;
  @override
  DeckVisibility? get ownVisibility;
  @override
  List<GameCard> get cards;
  @override
  @JsonKey(ignore: true)
  _$$_GameDeckCopyWith<_$_GameDeck> get copyWith =>
      throw _privateConstructorUsedError;
}
