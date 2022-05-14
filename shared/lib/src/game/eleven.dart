import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/src/game/states.dart';

enum ElevenCardColor { red, yellow, green, blue }

class ElevenCard extends Equatable {
  final int number;
  final ElevenCardColor color;

  const ElevenCard({required this.number, required this.color});

  static final List<ElevenCard> allCards = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ]
      .expand((number) => ElevenCardColor.values
          .map((color) => ElevenCard(number: number, color: color)))
      .toList();

  @override
  List<Object?> get props => [number, color];
}

class ElevenCardCollection {
  final List<int> _red = [];
  final List<int> _yellow = [];
  final List<int> _green = [];
  final List<int> _blue = [];

  List<int> get red => List.unmodifiable(_red);
  List<int> get yellow => List.unmodifiable(_yellow);
  List<int> get green => List.unmodifiable(_green);
  List<int> get blue => List.unmodifiable(_blue);

  List<int> getCollectionByColor(ElevenCardColor color) {
    switch (color) {
      case ElevenCardColor.red:
        return _red;
      case ElevenCardColor.yellow:
        return _yellow;
      case ElevenCardColor.green:
        return _green;
      case ElevenCardColor.blue:
        return _blue;
    }
  }

  bool hasCard(ElevenCard card) {
    return getCollectionByColor(card.color).contains(card.number);
  }

  void _addCard(ElevenCard card) {
    getCollectionByColor(card.color).add(card.number);
  }
}

class ElevenGameState extends GameState {
  final Map<String, List<ElevenCard>> _hands = {};
  final List<ElevenCard> _decks = [];
  final ElevenCardCollection collection = ElevenCardCollection();
  late String _currentPlayer;
  bool _hasPlayed = false;

  bool get hasPlayed => _hasPlayed;
  String get currentPlayer => _currentPlayer;
  List<ElevenCard> get decks => _decks;

  ElevenGameState(super.manager) {
    _decks.addAll(ElevenCard.allCards);

    if (_hands.length / 5 < manager.players.length) {
      manager.currentState = EndedGameState(manager, []);
    }

    final random = Random();

    // Give 5 cards to each player
    for (final player in manager.players) {
      _hands[player.id] = _decks.sublist(0, 5);
      _decks.removeRange(0, 5);
    }

    var firstPlayer = manager.players
        .firstWhereOrNull((player) =>
            _hands[player.id]?.any((card) =>
                card.number == 11 && card.color == ElevenCardColor.red) ??
            false)
        ?.id;
    firstPlayer ??= manager.players
        .firstWhereOrNull((player) =>
            _hands[player.id]?.any((card) =>
                card.number == 11 && card.color == ElevenCardColor.yellow) ??
            false)
        ?.id;
    firstPlayer ??= manager.players
        .firstWhereOrNull((player) =>
            _hands[player.id]?.any((card) =>
                card.number == 11 && card.color == ElevenCardColor.green) ??
            false)
        ?.id;
    firstPlayer ??= manager.players
        .firstWhereOrNull((player) =>
            _hands[player.id]?.any((card) =>
                card.number == 11 && card.color == ElevenCardColor.blue) ??
            false)
        ?.id;

    // If no player has a card with number 11, a random player will start
    firstPlayer ??= manager.players[random.nextInt(manager.players.length)].id;
  }

  List<ElevenCard>? getHand([String? playerId]) {
    final cards = _hands[playerId ?? _currentPlayer];
    if (cards == null) {
      return null;
    }
    return List.unmodifiable(cards);
  }

  bool hasCard(ElevenCard card, [String? playerId]) {
    final cards = _hands[playerId ?? _currentPlayer];
    return cards?.contains(card) ?? false;
  }

  void sortHand(String? playerId) {
    final cards = _hands[playerId ?? _currentPlayer];
    // Sort by number and color
    cards?.sort((a, b) {
      if (a.number == b.number) {
        return a.color.index.compareTo(b.color.index);
      }
      return a.number.compareTo(b.number);
    });
  }

  void sortHands() {
    _hands.forEach((playerId, cards) {
      sortHand(playerId);
    });
  }

  void _removeCard(String playerId, ElevenCard card) {
    final cards = _hands[playerId];
    cards?.remove(card);
  }

  void _addCard(String playerId, ElevenCard card) {
    final cards = _hands[playerId];
    cards?.add(card);
  }

  bool playCard(ElevenCard card) {
    if (!(getHand(_currentPlayer)?.contains(card) ?? false)) return false;
    _removeCard(_currentPlayer, card);
    _hasPlayed = true;
    _putCardOnTable(card);
    return true;
  }

  void _putCardOnTable(ElevenCard card) {
    collection._addCard(card);
  }

  bool endTurn() {
    if (!_hasPlayed) return false;
    _hasPlayed = false;
    _currentPlayer = manager.nextPlayer(_currentPlayer);
    return true;
  }

  bool takeCardFromDeck() {
    if (_hasPlayed) return false;
    endTurn();
    if (_decks.isEmpty) return true;
    _addCard(_currentPlayer, _decks.removeLast());
    return true;
  }
}
