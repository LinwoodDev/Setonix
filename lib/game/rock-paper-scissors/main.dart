import 'package:flutter/material.dart';
import 'package:minigamesparty/services/gamemode.dart';

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
    void initGame() {
      game = RockPaperScissorsGame();
    }
  }