import 'package:minigamesparty/services/game/mode.dart';

abstract class GameSystem {
  GameSystem();
  GameMode _currentMode;
  set currentMode(GameMode mode) {
    _currentMode.stop();
    _currentMode = mode;
    _currentMode.start(this);
  }

  get currentMode => _currentMode;

  void send(String message);
  void start();
  void stop();
}
