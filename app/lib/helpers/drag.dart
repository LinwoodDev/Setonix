import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';

mixin LongDragCallbacks on DragCallbacks, TapCallbacks {
  int get longThresholdPixels => 8;
  Duration get longThresholdDuration => const Duration(milliseconds: 500);

  DateTime? _start;
  bool _isMouse = false;
  bool? _isLongPressing;

  bool? get isLongPressing => _isLongPressing;
  bool? get isMouseOrLongPressing {
    if (_isMouse) return true;
    return _isLongPressing;
  }

  @override
  @mustCallSuper
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _start = DateTime.now();
    _isMouse = event.deviceKind == PointerDeviceKind.mouse;
    _isLongPressing = null;
  }

  @override
  @mustCallSuper
  void onDragUpdate(DragUpdateEvent event) {
    final delta = event.localDelta.length;
    final start = _start;
    if (start == null) return;
    final duration = DateTime.now().difference(start);
    if (duration > longThresholdDuration) {
      _isLongPressing ??= true;
      return;
    }
    if (delta > longThresholdPixels) {
      _isLongPressing = false;
    }
  }

  @override
  @mustCallSuper
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _start = null;
    _isLongPressing = null;
  }

  @override
  @mustCallSuper
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _start = null;
  }
}
