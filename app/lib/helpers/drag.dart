import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';

mixin LongDragCallbacks on DragCallbacks {
  int get longThresholdPixels => 12;
  Duration get longThresholdDuration => const Duration(seconds: 1);

  DateTime? _start;
  bool _isLongPressing = false;

  bool get isLongPressing => _isLongPressing;

  @override
  @mustCallSuper
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _start = DateTime.now();
    _isLongPressing = false;
  }

  @override
  @mustCallSuper
  void onDragUpdate(DragUpdateEvent event) {
    final delta = event.localDelta.length;
    final start = _start;
    if (start == null) return;
    final duration = DateTime.now().difference(start);
    if (duration > longThresholdDuration) return;
    if (delta > longThresholdPixels) {
      _start = null;
    } else {
      _isLongPressing = true;
    }
  }

  @override
  @mustCallSuper
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _start = null;
  }

  @override
  @mustCallSuper
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _start = null;
  }
}
