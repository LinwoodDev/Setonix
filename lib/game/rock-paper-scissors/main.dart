import 'package:flutter/material.dart';
import 'package:minigamesparty/services/game/mode.dart';
import 'package:minigamesparty/services/game/player.dart';
import 'package:minigamesparty/services/game/system.dart';

import 'game.dart';
import 'round.dart';

class RockPaperScissors extends GameMode {
  RockPaperScissorsGame game;
  RockPaperScissorsRound round;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void join(Player player) {
    // TODO: implement join
  }

  @override
  void leave(Player player) {
    // TODO: implement leave
  }

  @override
  void start(GameSystem game) {
    // TODO: implement start
  }

  @override
  void stop() {
    // TODO: implement stop
  }
}
