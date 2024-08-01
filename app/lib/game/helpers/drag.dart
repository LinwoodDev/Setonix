import 'package:flame/events.dart';

mixin LongDragCallbacks implements DragCallbacks {
  int get longThresholdPixels => 8;
  Duration get longThresholdDuration => const Duration(milliseconds: 800);

  DateTime? _start;
  bool _isLongPressing = false;

  bool get isLongPressing => _isLongPressing;

  @override
  void onDragStart(DragStartEvent event) {
    _start = DateTime.now();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final delta = event.localDelta.length;
    if (longThresholdPixels > delta) {
      _start = null;
    }
    final start = _start;
    if (start != null && !_isLongPressing) {
      final duration = DateTime.now().difference(start);
      _isLongPressing = duration >= longThresholdDuration;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _start = null;
    _isLongPressing = false;
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    _start = null;
    _isLongPressing = false;
  }
}
