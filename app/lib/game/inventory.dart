import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:qeck/game/board.dart';

class HudSpriteSheet {
  final SpacedSpriteSheet _spriteSheet;
  HudSpriteSheet(this._spriteSheet);
  HudSpriteSheet.fromImage(Image image)
      : _spriteSheet = SpacedSpriteSheet(
          image: image,
          srcSize: Vector2.all(16),
          spacing: Vector2.all(2),
          margin: Vector2.all(1),
        );

  Sprite get normalSlot => _spriteSheet.getSprite(0, 0);
  Sprite get normalHoveredSlot => _spriteSheet.getSprite(1, 0);
  Sprite get selectedSlot => _spriteSheet.getSprite(2, 0);
  Sprite get selectedHoveredSlot => _spriteSheet.getSprite(3, 0);
  Sprite get inventorySlot => _spriteSheet.getSprite(4, 0);
  Sprite get inventoryHoveredSlot => _spriteSheet.getSprite(5, 0);
}

class InventoryHud extends Component {
  late final HudSpriteSheet _spriteSheet;

  @override
  Future<void> onLoad() async {
    _spriteSheet = HudSpriteSheet.fromImage(await Flame.images.load('hud.png'));
    add(QuickHud(_spriteSheet));
  }
}

class QuickHud extends Component with HasGameRef {
  static const int _hudItems = 5, _hudMargin = 4, _hudSpacing = 0;
  final HudSpriteSheet _spriteSheet;

  QuickHud(this._spriteSheet);

  @override
  FutureOr<void> onLoad() {
    final y = gameRef.size.y - _hudMargin.toDouble();
    double x = gameRef.size.x - _hudMargin.toDouble();
    for (var i = -1; i < _hudItems; i++) {
      final item = InventoryItem(
        position: Vector2(x, y),
        anchor: Anchor.bottomRight,
        spriteSheet: _spriteSheet,
        isInventory: i == -1,
      );
      add(item);
      x -= item.size.x + _hudSpacing;
    }
  }
}

class InventoryScreen extends Component {
  @override
  Future<void> onLoad() async {}
}

class InventoryItem extends SpriteComponent with HoverCallbacks {
  final HudSpriteSheet _spriteSheet;
  final bool isInventory;
  bool _hovered = false;

  InventoryItem({
    required super.position,
    required super.anchor,
    required HudSpriteSheet spriteSheet,
    this.isInventory = false,
  })  : _spriteSheet = spriteSheet,
        super(size: Vector2.all(64));

  @override
  FutureOr<void> onLoad() async {
    _updateSprite();
  }

  void _updateSprite() => sprite = isInventory
      ? (_hovered
          ? _spriteSheet.inventoryHoveredSlot
          : _spriteSheet.inventorySlot)
      : (_hovered ? _spriteSheet.normalHoveredSlot : _spriteSheet.normalSlot);
  @override
  void onHoverEnter() {
    _hovered = true;
    _updateSprite();
  }

  @override
  void onHoverExit() {
    _hovered = false;
    _updateSprite();
  }
}
