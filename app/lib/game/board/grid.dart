import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class BoardGrid extends Component with HasGameRef {
  final Vector2 cellSize;
  static const _padding = 16.0;
  Rect? _lastViewport;
  final PositionComponent Function(
      {required Vector2 position, required Vector2 size}) createCell;

  BoardGrid({
    required this.cellSize,
    required this.createCell,
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
    for (var x = viewport.left + cellSize.x;
        x < viewport.right - cellSize.x;
        x += cellSize.x) {
      for (var y = viewport.top; y < last.top; y += cellSize.y) {
        add(createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
      for (var y = last.bottom; y < viewport.bottom; y += cellSize.y) {
        add(createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
    }
    // Left and right
    for (var y = last.top + cellSize.y;
        y < last.bottom - cellSize.y;
        y += cellSize.y) {
      for (var x = viewport.left; x < last.left; x += cellSize.x) {
        add(createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
      for (var x = last.right; x < viewport.right; x += cellSize.x) {
        add(createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
    }
    // Corner
    if (last.left != viewport.left || last.top != viewport.top) {
      add(createCell(
        position: Vector2(viewport.left, viewport.top),
        size: cellSize,
      ));
    }
    if (last.right != viewport.right || last.top != viewport.top) {
      add(createCell(
        position: Vector2(viewport.right - cellSize.x, viewport.top),
        size: cellSize,
      ));
    }
    if (last.left != viewport.left || last.bottom != viewport.bottom) {
      add(createCell(
        position: Vector2(viewport.left, viewport.bottom - cellSize.y),
        size: cellSize,
      ));
    }
    if (last.right != viewport.right || last.bottom != viewport.bottom) {
      add(createCell(
        position:
            Vector2(viewport.right - cellSize.x, viewport.bottom - cellSize.y),
        size: cellSize,
      ));
    }
    _lastViewport = viewport;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _updateGrid();
  }
}
