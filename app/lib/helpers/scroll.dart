import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/widgets.dart';

mixin ScrollCallbacks on Component {
  bool onScroll(PointerScrollInfo info) => false;
}

class _ScrollViewport extends PositionComponent {
  ScrollViewComponent get scrollParent => parent as ScrollViewComponent;
  @override
  void onParentResize(Vector2 maxSize) {
    super.onParentResize(maxSize);
    size = maxSize;
    for (final child in children) {
      if (child is! PositionComponent) {
        continue;
      }
      if (scrollParent.direction == Axis.horizontal) {
        child.height = maxSize.y;
      } else {
        child.width = maxSize.x;
      }
    }
  }
}

class ScrollViewComponent extends PositionComponent with ScrollCallbacks {
  final Axis direction;
  final double spacing;
  final _ScrollViewport _view = _ScrollViewport();
  double _nextItemPos = 0;

  ScrollViewComponent({
    required this.direction,
    super.position,
    super.size,
    this.spacing = 0,
  });

  @override
  void onLoad() {
    add(_view);
  }

  void addChild(PositionComponent child, {double? size, double? spacing}) {
    child.position = direction == Axis.horizontal
        ? Vector2(_nextItemPos, 0)
        : Vector2(0, _nextItemPos);
    size ??= direction == Axis.horizontal ? child.size.x : child.size.y;
    child.size = direction == Axis.horizontal
        ? Vector2(size, height)
        : Vector2(width, size);
    _view.add(child);
    _nextItemPos += size + (spacing ?? this.spacing);
  }

  void clearChildren() {
    for (final child in _view.children) {
      child.removeFromParent();
    }
    _nextItemPos = 0;
    _view.position = Vector2.zero();
  }

  void scroll(double delta) {
    final current =
        direction == Axis.horizontal ? _view.position.x : _view.position.y;
    final double next =
        (delta + current).clamp(min(_view.width - _nextItemPos, 0), 0);
    if (direction == Axis.horizontal) {
      _view.x = next;
    } else {
      _view.y = next;
    }
  }

  @override
  bool onScroll(PointerScrollInfo info) {
    var delta = direction == Axis.horizontal
        ? info.scrollDelta.global.x
        : info.scrollDelta.global.y;
    if (delta == 0) {
      delta = direction == Axis.horizontal
          ? info.scrollDelta.global.y
          : info.scrollDelta.global.x;
    }
    final scrollDelta = delta / 4;
    scroll(-scrollDelta);
    return true;
  }
}
