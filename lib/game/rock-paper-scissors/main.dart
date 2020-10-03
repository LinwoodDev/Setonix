import 'package:flutter/material.dart';
import 'package:minigamesparty/services/game.dart';
import 'package:minigamesparty/services/gamemode.dart';
import 'package:minigamesparty/services/player.dart';

import 'game.dart';
import 'round.dart';

class RockPaperScissors extends GameMode {
  RockPaperScissorsGame game;
  RockPaperScissorsRound round;

  @override
  Widget build() {
    return game.widget;
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
  void start(Game game) {}

  @override
  void stop() {
    // TODO: implement stop
  }
}
