import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:minigamesparty/services/gamemode.dart';

import 'game.dart';
import 'round.dart';
class StoneScissorPaper extends GameMode {
  StoneScissorPaperGame game;
  StoneScissorPaperRound round;
  
    @override
    Widget build() {
      return game.widget;
    }
  
    @override
    void initGame() {
      game = StoneScissorPaperGame();
    }
  }