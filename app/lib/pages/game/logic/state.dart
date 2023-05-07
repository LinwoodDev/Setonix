import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

enum GameCardColor {
  heart,
  diamond,
  spade,
  club,
}

@freezed
class GameCard with _$GameCard {
  const factory GameCard.classic({
    @Default(GameCardColor.heart) GameCardColor color,
    @Default(1) int number,
  }) = ClassicGameCard;

  factory GameCard.fromJson(Map<String, dynamic> json) =>
      _$GameCardFromJson(json);
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default([]) List<GameDeck> decks,
    @Default({}) Map<String, GameDeck> playerDecks,
  }) = _GameState;
}

enum DeckVisibility {
  hidden,
  onlyTop,
  visible,
}

@freezed
class DeckRefill with _$DeckRefill {
  const factory DeckRefill.none() = _DeckRefillNone;

  const factory DeckRefill.shuffle({
    int? count,
  }) = _DeckRefillShuffle;

  const factory DeckRefill.first({
    int? count,
  }) = _DeckRefillFirst;

  factory DeckRefill.fromJson(Map<String, dynamic> json) =>
      _$DeckRefillFromJson(json);
}

@freezed
class GameDeck with _$GameDeck {
  const factory GameDeck({
    @Default('') String name,
    @Default(DeckVisibility.hidden) DeckVisibility visibility,
    @Default([]) List<GameCard> cards,
  }) = _GameDeck;

  factory GameDeck.fromJson(Map<String, dynamic> json) =>
      _$GameDeckFromJson(json);
}
