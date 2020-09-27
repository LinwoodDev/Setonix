import 'package:minigamesparty/services/gamemode.dart';
import 'package:minigamesparty/services/player.dart';

abstract class Game {
  GameMode _currentGameMode;
  void send(String message);
  GameMode get currentGameMode => _currentGameMode;
  set currentGameMode(GameMode gameMode) {
    _currentGameMode.stop();
    _currentGameMode = gameMode;
    _currentGameMode.start(this);
  }

  List<Player> get players;
}
