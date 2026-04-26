import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';

mixin LongDragCallbacks on DragCallbacks, TapCallbacks {
  int get longThresholdPixels => 8;
  Duration get longThresholdDuration => const Duration(milliseconds: 500);

  DateTime? _start;
  double _dragDistance = 0;
  bool _isPrecisePointer = false;
  bool? _isLongPressing;

  bool? get isLongPressing => _isLongPressing;
  bool get isPrecisePointer => _isPrecisePointer;
  bool get isLongPressCandidate =>
      _start != null && !_isPrecisePointer && _isLongPressing != false;
  bool? get isMouseOrLongPressing {
    if (_isPrecisePointer) return true;
    return _isLongPressing;
  }

  bool _isPrecisePointerKind(PointerDeviceKind kind) =>
      kind == PointerDeviceKind.mouse ||
      kind == PointerDeviceKind.stylus ||
      kind == PointerDeviceKind.invertedStylus;

  void _startPointer(PointerDeviceKind kind, {bool preserveUnknown = false}) {
    if (preserveUnknown &&
        kind == PointerDeviceKind.unknown &&
        _start != null) {
      _dragDistance = 0;
      _isLongPressing = null;
      return;
    }
    _start = DateTime.now();
    _dragDistance = 0;
    _isPrecisePointer = kind == PointerDeviceKind.unknown
        ? preserveUnknown
        : _isPrecisePointerKind(kind);
    _isLongPressing = null;
  }

  @override
  @mustCallSuper
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _startPointer(event.deviceKind);
  }

  @override
  @mustCallSuper
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _startPointer(event.deviceKind, preserveUnknown: _start != null);
  }

  @override
  @mustCallSuper
  void onDragUpdate(DragUpdateEvent event) {
    _dragDistance += event.localDelta.length;
    final start = _start;
    if (start == null) return;
    final duration = DateTime.now().difference(start);
    if (duration > longThresholdDuration) {
      _isLongPressing ??= true;
      return;
    }
    if (_dragDistance > longThresholdPixels) {
      _isLongPressing = false;
    }
  }

  @override
  @mustCallSuper
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _start = null;
    _dragDistance = 0;
    _isLongPressing = null;
  }

  @override
  @mustCallSuper
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _start = null;
    _dragDistance = 0;
    _isLongPressing = null;
  }
}
