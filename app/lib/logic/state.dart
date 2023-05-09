import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

enum ClassicGameCardColor {
  heart,
  diamond,
  spade,
  club,
}

@freezed
class GameCard with _$GameCard {
  const factory GameCard.classic({
    @Default(ClassicGameCardColor.heart) ClassicGameCardColor color,
    @Default(1) int number,
  }) = ClassicGameCard;

  const factory GameCard.background() = BackgroundGameCard;

  factory GameCard.fromJson(Map<String, dynamic> json) =>
      _$GameCardFromJson(json);

  static List<ClassicGameCard> getClassicDeck() {
    final cards = <ClassicGameCard>[];
    for (final color in ClassicGameCardColor.values) {
      for (var i = 1; i <= 13; i++) {
        cards.add(ClassicGameCard(color: color, number: i));
      }
    }
    return cards;
  }
}

@freezed
class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    @Default([]) List<GameDeck> decks,
    @Default([]) List<GameSeat> seats,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);

  Map<String, dynamic> toSaveJson() =>
      copyWith(seats: seats.map((e) => e.copyWith(players: [])).toList())
          .toJson();

  GameState onPlayer(int player) {
    final sentDecks = decks.map((e) => e.hideOutside()).toList();
    final sentSeats = seats.map((e) => e.forPlayer(player)).toList();
    return copyWith(decks: sentDecks, seats: sentSeats);
  }
}

@freezed
class GameSeat with _$GameSeat {
  const GameSeat._();
  const factory GameSeat({
    @Default('') String name,
    @Default([]) List<GameDeck> decks,
    @Default([]) List<int> players,
    DeckVisibility? ownDeckVisibility,
  }) = _GameSeat;

  factory GameSeat.fromJson(Map<String, dynamic> json) =>
      _$GameSeatFromJson(json);

  GameSeat forPlayer(int player) {
    if (players.contains(player)) {
      return copyWith(
        decks: decks.map((e) => e.hideOwn()).toList(),
      );
    } else {
      return copyWith(
        decks: decks.map((e) => e.hideOutside()).toList(),
      );
    }
  }
}

enum DeckVisibility {
  hidden,
  onlyTop,
  visible,
}

@freezed
class DeckRefill with _$DeckRefill {
  const DeckRefill._();

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

enum PickLocation { top, bottom, random }

@freezed
class CardsRemoveState with _$CardsRemoveState {
  const factory CardsRemoveState({
    required GameDeck deck,
    required List<GameCard> removedCards,
  }) = _CardsRemoveState;
}

@freezed
class GameDeck with _$GameDeck {
  const GameDeck._();
  const factory GameDeck({
    @Default('') String name,
    @Default(DeckVisibility.hidden) DeckVisibility visibility,
    DeckVisibility? ownVisibility,
    @Default([]) List<GameCard> cards,
  }) = _GameDeck;

  factory GameDeck.fromJson(Map<String, dynamic> json) =>
      _$GameDeckFromJson(json);

  GameDeck hideOutside() => hide(visibility);

  GameDeck hideOwn() => hide(getOwnVisibility());

  GameDeck hide(DeckVisibility visibility) {
    switch (visibility) {
      case DeckVisibility.visible:
        return this;
      case DeckVisibility.onlyTop:
        if (cards.isEmpty) {
          return this;
        }
        return copyWith(
          cards: [
            cards.first,
            ...cards.map((e) => const BackgroundGameCard()).toList(),
          ],
        );
      case DeckVisibility.hidden:
        return copyWith(
          cards: cards.map((e) => const BackgroundGameCard()).toList(),
        );
    }
  }

  DeckVisibility getOwnVisibility() => ownVisibility ?? visibility;

  GameDeck shuffle() {
    final newCards = List<GameCard>.from(cards)..shuffle();
    return copyWith(cards: newCards);
  }

  GameDeck putCards(List<GameCard> cards,
      [PickLocation location = PickLocation.bottom]) {
    final newCards = List<GameCard>.from(cards);
    switch (location) {
      case PickLocation.top:
        newCards.insertAll(0, cards);
        break;
      case PickLocation.bottom:
        newCards.addAll(cards);
        break;
      case PickLocation.random:
        newCards.insertAll(Random().nextInt(newCards.length + 1), cards);
        break;
    }
    return copyWith(cards: newCards);
  }

  CardsRemoveState removeCards(
      [int count = 1, PickLocation location = PickLocation.top]) {
    final newCards = List<GameCard>.from(cards);
    final removedCards = <GameCard>[];
    switch (location) {
      case PickLocation.top:
        removedCards.addAll(newCards.getRange(0, count));
        newCards.removeRange(0, count);
        break;
      case PickLocation.bottom:
        removedCards.addAll(
            newCards.getRange(newCards.length - count, newCards.length));
        newCards.removeRange(newCards.length - count, newCards.length);
        break;
      case PickLocation.random:
        final random = Random();
        for (var i = 0; i < count; i++) {
          removedCards.add(newCards.removeAt(random.nextInt(newCards.length)));
        }
        break;
    }
    return CardsRemoveState(
        deck: copyWith(cards: newCards), removedCards: removedCards);
  }
}
