import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:quokka/bloc/board.dart';
import 'package:quokka/bloc/board_state.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/grid.dart';
import 'package:quokka/board/hand/view.dart';
import 'package:quokka/helpers/asset.dart';
import 'package:quokka/helpers/scroll.dart';
import 'package:quokka/services/file_system.dart';

class BoardGame extends FlameGame with ScrollDetector {
  final AssetManager assetManager;
  late final Sprite gridSprite, selectionSprite;
  late final GameHand _hand;
  late final BoardGrid grid;
  final BoardBloc bloc;

  BoardGame({
    QuokkaFileSystem? fileSystem,
    required this.bloc,
  }) : assetManager =
            AssetManager(fileSystem: fileSystem ?? QuokkaFileSystem());

  @override
  FutureOr<void> onLoad() async {
    final provider =
        FlameBlocProvider<BoardBloc, BoardState>.value(value: bloc);
    await add(provider);
    provider.addAll([camera, world]);
    const packName = '';
    await assetManager.loadPack(packName);
    final data = assetManager.getTexture('backgrounds/grid.png');
    if (data == null) {
      return;
    }
    final image = await decodeImageFromList(data);
    gridSprite = Sprite(image);
    selectionSprite = await Sprite.load('selection.png');
    _hand = GameHand();
    camera.viewport.add(_hand);
    grid = BoardGrid(cellSize: Vector2.all(128), createCell: GameCell.new);
    world.add(grid);
  }

  void clampZoom(double zoom) {
    camera.viewfinder.zoom = zoom.clamp(0.3, 3.0);
  }

  static const zoomPerScrollUnit = 0.02;

  @override
  void onScroll(PointerScrollInfo info) {
    final component = componentsAtPoint(info.eventPosition.global)
        .whereType<ScrollCallbacks>()
        .firstOrNull;
    component?.onScroll(info);
  }
}
