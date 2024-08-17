import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:quokka/board/cell.dart';

class BoardGrid extends PositionComponent with HasGameRef {
  final Vector2 cellSize;
  static const _padding = 3.0;
  Rect? _lastViewport;

  BoardGrid({
    required this.cellSize,
  });

  Rect get viewport {
    final Rect viewport = game.camera.visibleWorldRect;
    return Rect.fromLTRB(
      (viewport.left / cellSize.x - _padding).floor() * cellSize.x,
      (viewport.top / cellSize.y - _padding).floor() * cellSize.y,
      (viewport.right / cellSize.x + _padding).ceil() * cellSize.x,
      (viewport.bottom / cellSize.y + _padding).ceil() * cellSize.y,
    );
  }

  bool shouldReset() {
    // Check if the viewport is different by one pixel
    final Rect viewport = this.viewport;
    final Rect lastViewport = _lastViewport ?? Rect.zero;
    final bool shouldReset = viewport != lastViewport;
    return shouldReset;
  }

  void _updateGrid() {
    if (!shouldReset()) return;
    final viewport = this.viewport;
    // Remove components that are out of the viewport
    removeAll(children.where((element) {
      if (element is! PositionComponent) return false;
      final Rect bounds = element.toRect();
      return !bounds.overlaps(viewport);
    }));
    final last = _lastViewport ?? Rect.zero;
    // Add components that are in the viewport
    // Top and bottom
    for (var x = viewport.left; x < viewport.right; x += cellSize.x) {
      for (var y = viewport.top; y < last.top; y += cellSize.y) {
        add(_createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
      for (var y = last.bottom; y < viewport.bottom; y += cellSize.y) {
        add(_createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
    }
    // Left and right
    for (var y = last.top; y < last.bottom; y += cellSize.y) {
      for (var x = viewport.left; x < last.left; x += cellSize.x) {
        add(_createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
      for (var x = last.right; x < viewport.right; x += cellSize.x) {
        add(_createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
    }
    _lastViewport = viewport;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _updateGrid();
  }

  @override
  void onParentResize(Vector2 maxSize) {
    super.onParentResize(maxSize);
    _lastViewport = null;
  }

  Component _createCell({required Vector2 position, required Vector2 size}) =>
      GameCell(
        position: position,
        size: size,
      );
}
