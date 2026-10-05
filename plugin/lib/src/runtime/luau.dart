import 'package:meta/meta.dart';

import '../rust/api/plugin.dart' show EventResult, RustPlugin;
import 'callback.dart';
import 'native.dart' if (dart.library.js_interop) 'web.dart' as platform;

export 'callback.dart';

@internal
typedef LuauEvent = ({
  String eventType,
  String event,
  String? serverEvent,
  int source,
  bool cancelled,
  int target,
});

/// The common plugin API and lifecycle; transports implement only execution.
abstract class LuauPlugin implements RustPlugin {
  @protected
  final PluginCallback callbacks;
  bool _disposed = false;

  factory LuauPlugin({
    required String code,
    required PluginCallback callback,
  }) => platform.createPlugin(code, callback);

  @internal
  LuauPlugin.internal(this.callbacks) {
    checkActive();
  }

  @protected
  @nonVirtual
  void checkActive() {
    if (_disposed) throw StateError('Luau plugin has been disposed');
    callbacks.checkActive();
  }

  @override
  @nonVirtual
  Future<void> run() {
    checkActive();
    return executeScript();
  }

  @override
  @nonVirtual
  Future<EventResult> runEvent({
    required String eventType,
    required String event,
    String? serverEvent,
    required int source,
    required bool cancelled,
    required int target,
  }) {
    checkActive();
    return executeEvent((
      eventType: eventType,
      event: event,
      serverEvent: serverEvent,
      source: source,
      cancelled: cancelled,
      target: target,
    ));
  }

  @nonVirtual
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    release();
  }

  @protected
  Future<void> executeScript();

  @protected
  Future<EventResult> executeEvent(LuauEvent event);

  @protected
  void release();
}
