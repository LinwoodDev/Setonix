import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Player extends Equatable {
  final String name;
  final String id;

  Player({required this.name, required this.id});

  @override
  String toString() => 'Player($name, $id)';

  @override
  List<Object?> get props => [name, id];
}

abstract class GameState {
  final GameStateManager manager;

  GameState(this.manager);

  void dispose() {}

  bool onJoin(Player player) => false;
  void onLeave(Player player) {}
}

class GameStateManager {
  final List<Player> _players = [];
  late GameState _currentState;

  GameState get currentState => _currentState;

  set currentState(GameState state) {
    _currentState.dispose();
    _currentState = state;
  }

  List<Player> get players => List.unmodifiable(_players);

  GameStateManager() {
    _currentState = WaitingGameState(this);
  }

  Player? getPlayer(String id) =>
      _players.firstWhereOrNull((player) => player.id == id);

  Player? getPlayerByName(String name) =>
      _players.firstWhereOrNull((player) => player.name == name);

  String? getPlayerName(String id) =>
      _players.firstWhereOrNull((player) => player.id == id)?.name;

  String? getPlayerId(String name) =>
      _players.firstWhereOrNull((player) => player.name == name)?.id;

  String nextPlayer(String id) {
    final index = _players.indexWhere((player) => player.id == id);
    return _players[(index + 1) % _players.length].id;
  }

  bool join(Player player) {
    // Test if the player is already in the game
    if (getPlayer(player.id) != null) {
      return false;
    }
    if (getPlayerByName(player.name) != null) {
      return false;
    }
    if (_currentState.onJoin(player)) {
      _players.add(player);
      return true;
    }
    return false;
  }

  void leave(Player player) {
    _currentState.onLeave(player);
    _players.remove(player);
  }
}

class WaitingGameState extends GameState {
  WaitingGameState(super.manager);
}

class EndedGameState extends GameState {
  final List<Player> winners;

  EndedGameState(super.manager, this.winners);
}
