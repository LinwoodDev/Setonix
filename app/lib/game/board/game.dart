import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';
import 'package:quokka/game/board/cell.dart';
import 'package:quokka/game/board/grid.dart';
import 'package:quokka/game/board/hand/view.dart';
import 'package:quokka/game/helpers/asset.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/services/pack.dart';

class BoardGame extends FlameGame with ScrollDetector {
  final AssetManager assetManager;
  final GameTable table;
  Vector2? selectedCell;
  late final Sprite gridSprite, selectionSprite;
  late final GameHand _hand;

  BoardGame({
    required PackService packService,
    this.table = const GameTable(),
  }) : assetManager = AssetManager(packService: packService);

  @override
  FutureOr<void> onLoad() async {
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
    world.add(BoardGrid(cellSize: Vector2.all(128), createCell: GameCell.new));
  }

  void clampZoom(double zoom) {
    camera.viewfinder.zoom = zoom.clamp(0.3, 3.0);
  }

  static const zoomPerScrollUnit = 0.02;

  @override
  void onScroll(PointerScrollInfo info) {
    clampZoom(camera.viewfinder.zoom +
        info.scrollDelta.global.y.sign * zoomPerScrollUnit);
  }

  void showAdd() {
    selectedCell = null;
    _hand.show();
  }
}
