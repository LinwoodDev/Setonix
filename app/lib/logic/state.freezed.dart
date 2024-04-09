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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameCard _$GameCardFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'classic':
      return ClassicGameCard.fromJson(json);
    case 'background':
      return BackgroundGameCard.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'GameCard', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$GameCard {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ClassicGameCardColor color, int number) classic,
    required TResult Function() background,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ClassicGameCardColor color, int number)? classic,
    TResult? Function()? background,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ClassicGameCardColor color, int number)? classic,
    TResult Function()? background,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassicGameCard value) classic,
    required TResult Function(BackgroundGameCard value) background,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassicGameCard value)? classic,
    TResult? Function(BackgroundGameCard value)? background,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassicGameCard value)? classic,
    TResult Function(BackgroundGameCard value)? background,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCardCopyWith<$Res> {
  factory $GameCardCopyWith(GameCard value, $Res Function(GameCard) then) =
      _$GameCardCopyWithImpl<$Res, GameCard>;
}

/// @nodoc
class _$GameCardCopyWithImpl<$Res, $Val extends GameCard>
    implements $GameCardCopyWith<$Res> {
  _$GameCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ClassicGameCardImplCopyWith<$Res> {
  factory _$$ClassicGameCardImplCopyWith(_$ClassicGameCardImpl value,
          $Res Function(_$ClassicGameCardImpl) then) =
      __$$ClassicGameCardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClassicGameCardColor color, int number});
}

/// @nodoc
class __$$ClassicGameCardImplCopyWithImpl<$Res>
    extends _$GameCardCopyWithImpl<$Res, _$ClassicGameCardImpl>
    implements _$$ClassicGameCardImplCopyWith<$Res> {
  __$$ClassicGameCardImplCopyWithImpl(
      _$ClassicGameCardImpl _value, $Res Function(_$ClassicGameCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? number = null,
  }) {
    return _then(_$ClassicGameCardImpl(
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
class _$ClassicGameCardImpl implements ClassicGameCard {
  const _$ClassicGameCardImpl(
      {this.color = ClassicGameCardColor.heart,
      this.number = 1,
      final String? $type})
      : $type = $type ?? 'classic';

  factory _$ClassicGameCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassicGameCardImplFromJson(json);

  @override
  @JsonKey()
  final ClassicGameCardColor color;
  @override
  @JsonKey()
  final int number;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'GameCard.classic(color: $color, number: $number)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassicGameCardImpl &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.number, number) || other.number == number));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, color, number);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassicGameCardImplCopyWith<_$ClassicGameCardImpl> get copyWith =>
      __$$ClassicGameCardImplCopyWithImpl<_$ClassicGameCardImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ClassicGameCardColor color, int number) classic,
    required TResult Function() background,
  }) {
    return classic(color, number);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ClassicGameCardColor color, int number)? classic,
    TResult? Function()? background,
  }) {
    return classic?.call(color, number);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ClassicGameCardColor color, int number)? classic,
    TResult Function()? background,
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
    required TResult Function(BackgroundGameCard value) background,
  }) {
    return classic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassicGameCard value)? classic,
    TResult? Function(BackgroundGameCard value)? background,
  }) {
    return classic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassicGameCard value)? classic,
    TResult Function(BackgroundGameCard value)? background,
    required TResult orElse(),
  }) {
    if (classic != null) {
      return classic(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassicGameCardImplToJson(
      this,
    );
  }
}

abstract class ClassicGameCard implements GameCard {
  const factory ClassicGameCard(
      {final ClassicGameCardColor color,
      final int number}) = _$ClassicGameCardImpl;

  factory ClassicGameCard.fromJson(Map<String, dynamic> json) =
      _$ClassicGameCardImpl.fromJson;

  ClassicGameCardColor get color;
  int get number;
  @JsonKey(ignore: true)
  _$$ClassicGameCardImplCopyWith<_$ClassicGameCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BackgroundGameCardImplCopyWith<$Res> {
  factory _$$BackgroundGameCardImplCopyWith(_$BackgroundGameCardImpl value,
          $Res Function(_$BackgroundGameCardImpl) then) =
      __$$BackgroundGameCardImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackgroundGameCardImplCopyWithImpl<$Res>
    extends _$GameCardCopyWithImpl<$Res, _$BackgroundGameCardImpl>
    implements _$$BackgroundGameCardImplCopyWith<$Res> {
  __$$BackgroundGameCardImplCopyWithImpl(_$BackgroundGameCardImpl _value,
      $Res Function(_$BackgroundGameCardImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$BackgroundGameCardImpl implements BackgroundGameCard {
  const _$BackgroundGameCardImpl({final String? $type})
      : $type = $type ?? 'background';

  factory _$BackgroundGameCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$BackgroundGameCardImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'GameCard.background()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BackgroundGameCardImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ClassicGameCardColor color, int number) classic,
    required TResult Function() background,
  }) {
    return background();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ClassicGameCardColor color, int number)? classic,
    TResult? Function()? background,
  }) {
    return background?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ClassicGameCardColor color, int number)? classic,
    TResult Function()? background,
    required TResult orElse(),
  }) {
    if (background != null) {
      return background();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassicGameCard value) classic,
    required TResult Function(BackgroundGameCard value) background,
  }) {
    return background(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassicGameCard value)? classic,
    TResult? Function(BackgroundGameCard value)? background,
  }) {
    return background?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassicGameCard value)? classic,
    TResult Function(BackgroundGameCard value)? background,
    required TResult orElse(),
  }) {
    if (background != null) {
      return background(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BackgroundGameCardImplToJson(
      this,
    );
  }
}

abstract class BackgroundGameCard implements GameCard {
  const factory BackgroundGameCard() = _$BackgroundGameCardImpl;

  factory BackgroundGameCard.fromJson(Map<String, dynamic> json) =
      _$BackgroundGameCardImpl.fromJson;
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
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GameDeck> decks, List<GameSeat> seats});
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decks = null,
    Object? seats = null,
  }) {
    return _then(_$GameStateImpl(
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
class _$GameStateImpl extends _GameState {
  const _$GameStateImpl(
      {final List<GameDeck> decks = const [],
      final List<GameSeat> seats = const []})
      : _decks = decks,
        _seats = seats,
        super._();

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
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
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateImplToJson(
      this,
    );
  }
}

abstract class _GameState extends GameState {
  const factory _GameState(
      {final List<GameDeck> decks,
      final List<GameSeat> seats}) = _$GameStateImpl;
  const _GameState._() : super._();

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override
  List<GameDeck> get decks;
  @override
  List<GameSeat> get seats;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
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
abstract class _$$GameSeatImplCopyWith<$Res>
    implements $GameSeatCopyWith<$Res> {
  factory _$$GameSeatImplCopyWith(
          _$GameSeatImpl value, $Res Function(_$GameSeatImpl) then) =
      __$$GameSeatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      List<GameDeck> decks,
      List<int> players,
      DeckVisibility? ownDeckVisibility});
}

/// @nodoc
class __$$GameSeatImplCopyWithImpl<$Res>
    extends _$GameSeatCopyWithImpl<$Res, _$GameSeatImpl>
    implements _$$GameSeatImplCopyWith<$Res> {
  __$$GameSeatImplCopyWithImpl(
      _$GameSeatImpl _value, $Res Function(_$GameSeatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? decks = null,
    Object? players = null,
    Object? ownDeckVisibility = freezed,
  }) {
    return _then(_$GameSeatImpl(
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
class _$GameSeatImpl extends _GameSeat {
  const _$GameSeatImpl(
      {this.name = '',
      final List<GameDeck> decks = const [],
      final List<int> players = const [],
      this.ownDeckVisibility})
      : _decks = decks,
        _players = players,
        super._();

  factory _$GameSeatImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameSeatImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameSeatImpl &&
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
  _$$GameSeatImplCopyWith<_$GameSeatImpl> get copyWith =>
      __$$GameSeatImplCopyWithImpl<_$GameSeatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameSeatImplToJson(
      this,
    );
  }
}

abstract class _GameSeat extends GameSeat {
  const factory _GameSeat(
      {final String name,
      final List<GameDeck> decks,
      final List<int> players,
      final DeckVisibility? ownDeckVisibility}) = _$GameSeatImpl;
  const _GameSeat._() : super._();

  factory _GameSeat.fromJson(Map<String, dynamic> json) =
      _$GameSeatImpl.fromJson;

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
  _$$GameSeatImplCopyWith<_$GameSeatImpl> get copyWith =>
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
abstract class _$$DeckRefillNoneImplCopyWith<$Res> {
  factory _$$DeckRefillNoneImplCopyWith(_$DeckRefillNoneImpl value,
          $Res Function(_$DeckRefillNoneImpl) then) =
      __$$DeckRefillNoneImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeckRefillNoneImplCopyWithImpl<$Res>
    extends _$DeckRefillCopyWithImpl<$Res, _$DeckRefillNoneImpl>
    implements _$$DeckRefillNoneImplCopyWith<$Res> {
  __$$DeckRefillNoneImplCopyWithImpl(
      _$DeckRefillNoneImpl _value, $Res Function(_$DeckRefillNoneImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$DeckRefillNoneImpl extends _DeckRefillNone {
  const _$DeckRefillNoneImpl({final String? $type})
      : $type = $type ?? 'none',
        super._();

  factory _$DeckRefillNoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeckRefillNoneImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeckRefill.none()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeckRefillNoneImpl);
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
    return _$$DeckRefillNoneImplToJson(
      this,
    );
  }
}

abstract class _DeckRefillNone extends DeckRefill {
  const factory _DeckRefillNone() = _$DeckRefillNoneImpl;
  const _DeckRefillNone._() : super._();

  factory _DeckRefillNone.fromJson(Map<String, dynamic> json) =
      _$DeckRefillNoneImpl.fromJson;
}

/// @nodoc
abstract class _$$DeckRefillShuffleImplCopyWith<$Res> {
  factory _$$DeckRefillShuffleImplCopyWith(_$DeckRefillShuffleImpl value,
          $Res Function(_$DeckRefillShuffleImpl) then) =
      __$$DeckRefillShuffleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? count});
}

/// @nodoc
class __$$DeckRefillShuffleImplCopyWithImpl<$Res>
    extends _$DeckRefillCopyWithImpl<$Res, _$DeckRefillShuffleImpl>
    implements _$$DeckRefillShuffleImplCopyWith<$Res> {
  __$$DeckRefillShuffleImplCopyWithImpl(_$DeckRefillShuffleImpl _value,
      $Res Function(_$DeckRefillShuffleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
  }) {
    return _then(_$DeckRefillShuffleImpl(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeckRefillShuffleImpl extends _DeckRefillShuffle {
  const _$DeckRefillShuffleImpl({this.count, final String? $type})
      : $type = $type ?? 'shuffle',
        super._();

  factory _$DeckRefillShuffleImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeckRefillShuffleImplFromJson(json);

  @override
  final int? count;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeckRefill.shuffle(count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckRefillShuffleImpl &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckRefillShuffleImplCopyWith<_$DeckRefillShuffleImpl> get copyWith =>
      __$$DeckRefillShuffleImplCopyWithImpl<_$DeckRefillShuffleImpl>(
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
    return _$$DeckRefillShuffleImplToJson(
      this,
    );
  }
}

abstract class _DeckRefillShuffle extends DeckRefill {
  const factory _DeckRefillShuffle({final int? count}) =
      _$DeckRefillShuffleImpl;
  const _DeckRefillShuffle._() : super._();

  factory _DeckRefillShuffle.fromJson(Map<String, dynamic> json) =
      _$DeckRefillShuffleImpl.fromJson;

  int? get count;
  @JsonKey(ignore: true)
  _$$DeckRefillShuffleImplCopyWith<_$DeckRefillShuffleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeckRefillFirstImplCopyWith<$Res> {
  factory _$$DeckRefillFirstImplCopyWith(_$DeckRefillFirstImpl value,
          $Res Function(_$DeckRefillFirstImpl) then) =
      __$$DeckRefillFirstImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? count});
}

/// @nodoc
class __$$DeckRefillFirstImplCopyWithImpl<$Res>
    extends _$DeckRefillCopyWithImpl<$Res, _$DeckRefillFirstImpl>
    implements _$$DeckRefillFirstImplCopyWith<$Res> {
  __$$DeckRefillFirstImplCopyWithImpl(
      _$DeckRefillFirstImpl _value, $Res Function(_$DeckRefillFirstImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
  }) {
    return _then(_$DeckRefillFirstImpl(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeckRefillFirstImpl extends _DeckRefillFirst {
  const _$DeckRefillFirstImpl({this.count, final String? $type})
      : $type = $type ?? 'first',
        super._();

  factory _$DeckRefillFirstImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeckRefillFirstImplFromJson(json);

  @override
  final int? count;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeckRefill.first(count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckRefillFirstImpl &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckRefillFirstImplCopyWith<_$DeckRefillFirstImpl> get copyWith =>
      __$$DeckRefillFirstImplCopyWithImpl<_$DeckRefillFirstImpl>(
          this, _$identity);

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
    return _$$DeckRefillFirstImplToJson(
      this,
    );
  }
}

abstract class _DeckRefillFirst extends DeckRefill {
  const factory _DeckRefillFirst({final int? count}) = _$DeckRefillFirstImpl;
  const _DeckRefillFirst._() : super._();

  factory _DeckRefillFirst.fromJson(Map<String, dynamic> json) =
      _$DeckRefillFirstImpl.fromJson;

  int? get count;
  @JsonKey(ignore: true)
  _$$DeckRefillFirstImplCopyWith<_$DeckRefillFirstImpl> get copyWith =>
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
abstract class _$$CardsRemoveStateImplCopyWith<$Res>
    implements $CardsRemoveStateCopyWith<$Res> {
  factory _$$CardsRemoveStateImplCopyWith(_$CardsRemoveStateImpl value,
          $Res Function(_$CardsRemoveStateImpl) then) =
      __$$CardsRemoveStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GameDeck deck, List<GameCard> removedCards});

  @override
  $GameDeckCopyWith<$Res> get deck;
}

/// @nodoc
class __$$CardsRemoveStateImplCopyWithImpl<$Res>
    extends _$CardsRemoveStateCopyWithImpl<$Res, _$CardsRemoveStateImpl>
    implements _$$CardsRemoveStateImplCopyWith<$Res> {
  __$$CardsRemoveStateImplCopyWithImpl(_$CardsRemoveStateImpl _value,
      $Res Function(_$CardsRemoveStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deck = null,
    Object? removedCards = null,
  }) {
    return _then(_$CardsRemoveStateImpl(
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

class _$CardsRemoveStateImpl implements _CardsRemoveState {
  const _$CardsRemoveStateImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardsRemoveStateImpl &&
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
  _$$CardsRemoveStateImplCopyWith<_$CardsRemoveStateImpl> get copyWith =>
      __$$CardsRemoveStateImplCopyWithImpl<_$CardsRemoveStateImpl>(
          this, _$identity);
}

abstract class _CardsRemoveState implements CardsRemoveState {
  const factory _CardsRemoveState(
      {required final GameDeck deck,
      required final List<GameCard> removedCards}) = _$CardsRemoveStateImpl;

  @override
  GameDeck get deck;
  @override
  List<GameCard> get removedCards;
  @override
  @JsonKey(ignore: true)
  _$$CardsRemoveStateImplCopyWith<_$CardsRemoveStateImpl> get copyWith =>
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
abstract class _$$GameDeckImplCopyWith<$Res>
    implements $GameDeckCopyWith<$Res> {
  factory _$$GameDeckImplCopyWith(
          _$GameDeckImpl value, $Res Function(_$GameDeckImpl) then) =
      __$$GameDeckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      DeckVisibility visibility,
      DeckVisibility? ownVisibility,
      List<GameCard> cards});
}

/// @nodoc
class __$$GameDeckImplCopyWithImpl<$Res>
    extends _$GameDeckCopyWithImpl<$Res, _$GameDeckImpl>
    implements _$$GameDeckImplCopyWith<$Res> {
  __$$GameDeckImplCopyWithImpl(
      _$GameDeckImpl _value, $Res Function(_$GameDeckImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? visibility = null,
    Object? ownVisibility = freezed,
    Object? cards = null,
  }) {
    return _then(_$GameDeckImpl(
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
class _$GameDeckImpl extends _GameDeck {
  const _$GameDeckImpl(
      {this.name = '',
      this.visibility = DeckVisibility.hidden,
      this.ownVisibility,
      final List<GameCard> cards = const []})
      : _cards = cards,
        super._();

  factory _$GameDeckImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameDeckImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameDeckImpl &&
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
  _$$GameDeckImplCopyWith<_$GameDeckImpl> get copyWith =>
      __$$GameDeckImplCopyWithImpl<_$GameDeckImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameDeckImplToJson(
      this,
    );
  }
}

abstract class _GameDeck extends GameDeck {
  const factory _GameDeck(
      {final String name,
      final DeckVisibility visibility,
      final DeckVisibility? ownVisibility,
      final List<GameCard> cards}) = _$GameDeckImpl;
  const _GameDeck._() : super._();

  factory _GameDeck.fromJson(Map<String, dynamic> json) =
      _$GameDeckImpl.fromJson;

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
  _$$GameDeckImplCopyWith<_$GameDeckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
