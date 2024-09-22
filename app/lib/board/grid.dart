import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:quokka/bloc/settings.dart';
import 'package:quokka/board/cell.dart';

class BoardGrid extends PositionComponent
    with HasGameRef, FlameBlocListenable<SettingsCubit, QuokkaSettings> {
  final Vector2 cellSize;
  static const _padding = 3.0;
  Rect? _lastViewport;
  double _zoom = 1.0;

  BoardGrid({
    required this.cellSize,
  });

  Rect get viewport {
    final Rect viewport = game.camera.visibleWorldRect;
    final currentSize = cellSizeWithZoom;
    return Rect.fromLTRB(
      (viewport.left / currentSize.x - _padding).floor() * currentSize.x,
      (viewport.top / currentSize.y - _padding).floor() * currentSize.y,
      (viewport.right / currentSize.x + _padding).ceil() * currentSize.x,
      (viewport.bottom / currentSize.y + _padding).ceil() * currentSize.y,
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
    final currentSize = cellSizeWithZoom;
    // Remove components that are out of the viewport
    removeAll(children.where((element) {
      if (element is! PositionComponent) return false;
      final Rect bounds = element.toRect();
      return !bounds.overlaps(viewport);
    }));
    final last = _lastViewport ?? Rect.zero;
    // Add components that are in the viewport
    // Top and bottom
    for (var x = viewport.left; x < viewport.right; x += currentSize.x) {
      for (var y = viewport.top; y < last.top; y += currentSize.y) {
        add(_createCell(
          position: Vector2(x, y),
          size: currentSize,
        ));
      }
      for (var y = last.bottom; y < viewport.bottom; y += currentSize.y) {
        add(_createCell(
          position: Vector2(x, y),
          size: currentSize,
        ));
      }
    }
    // Left and right
    for (var y = last.top; y < last.bottom; y += currentSize.y) {
      for (var x = viewport.left; x < last.left; x += currentSize.x) {
        add(_createCell(
          position: Vector2(x, y),
          size: currentSize,
        ));
      }
      for (var x = last.right; x < viewport.right; x += currentSize.x) {
        add(_createCell(
          position: Vector2(x, y),
          size: currentSize,
        ));
      }
    }
    _lastViewport = viewport;
  }

  Vector2 get cellSizeWithZoom => cellSize * _zoom;

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

  @override
  void onInitialState(QuokkaSettings state) {
    _zoom = state.zoom;
  }

  @override
  bool listenWhen(QuokkaSettings previousState, QuokkaSettings newState) =>
      previousState.zoom != newState.zoom;

  @override
  void onNewState(QuokkaSettings state) {
    if (_zoom != state.zoom) {
      _zoom = state.zoom;
      _lastViewport = null;
      removeAll(children);
    }
  }
}
