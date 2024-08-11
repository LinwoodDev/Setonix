import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:quokka/bloc/board.dart';
import 'package:quokka/bloc/board_state.dart';
import 'package:quokka/board/game.dart';

class GameBoardBackground extends SpriteComponent
    with
        HasGameReference<BoardGame>,
        FlameBlocListenable<BoardBloc, BoardState> {
  GameBoardBackground({super.size})
      : super(paint: Paint()..isAntiAlias = false);

  @override
  void onLoad() {
    sprite = game.selectionSprite;
  }

  @override
  void onInitialState(BoardState state) => updateBackground(state);

  @override
  void onNewState(BoardState state) => updateBackground(state);

  Future<void> updateBackground(BoardState state) async {
    final backgroundLocation = state.table.background;
    var background = backgroundLocation == null
        ? null
        : (await game.assetManager.loadPack(backgroundLocation.namespace))
            ?.getBackgroundItem(backgroundLocation.id);
    background ??= game.assetManager.packs
        .map((pack) => pack.value.getBackgroundItems(pack.key).firstOrNull)
        .nonNulls
        .firstOrNull;
    if (background == null) return;
    sprite = await game.assetManager.loadSprite(background.item.texture);
  }
}
