import 'dart:async';

import '../rust/api/plugin.dart' show StateFieldAccess;

/// Callbacks shared by the native and browser Luau transports.
class PluginCallback {
  final FutureOr<void> Function(String) onPrint;
  final FutureOr<void> Function(String, bool?) processEvent;
  final FutureOr<void> Function(String, int?) sendEvent;
  final FutureOr<String> Function(StateFieldAccess) stateFieldAccess;
  final FutureOr<String> Function(String?) tableAccess;
  final FutureOr<String> Function() storageRead;
  final FutureOr<void> Function(String) storageWrite;
  bool _disposed = false;

  PluginCallback({
    required this.onPrint,
    required this.processEvent,
    required this.sendEvent,
    required this.stateFieldAccess,
    required this.tableAccess,
    required this.storageRead,
    required this.storageWrite,
  });

  void checkActive() {
    if (_disposed) throw StateError('Plugin callbacks have been disposed');
  }

  void dispose() => _disposed = true;
}
