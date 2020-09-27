import 'package:minigamesparty/services/player.dart';

import 'game.dart';

abstract class GameMode {
  void join(Player player);
  void leave(Player player);
  void stop();
  void start(Game game);
}
