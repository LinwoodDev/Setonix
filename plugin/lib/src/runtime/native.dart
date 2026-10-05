import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

import '../rust/frb_generated.dart';
import '../rust/api/luau.dart' as native;
import '../rust/api/plugin.dart' as native;
import 'luau.dart';

Future<void> initialize({ExternalLibrary? externalLibrary}) =>
    RustLib.init(externalLibrary: externalLibrary);

void disposeSystem() => RustLib.dispose();

LuauPlugin createPlugin(String code, PluginCallback callback) =>
    _NativeLuauPlugin(code, callback);

class _NativeLuauPlugin extends LuauPlugin {
  late final native.PluginCallback _callback;
  late final native.LuauPlugin _plugin;

  _NativeLuauPlugin(String code, PluginCallback callback)
    : super.internal(callback) {
    _callback = native.PluginCallback(
      onPrint: callbacks.onPrint,
      processEvent: callbacks.processEvent,
      sendEvent: callbacks.sendEvent,
      stateFieldAccess: callbacks.stateFieldAccess,
      tableAccess: callbacks.tableAccess,
      storageRead: callbacks.storageRead,
      storageWrite: callbacks.storageWrite,
    );
    _plugin = native.LuauPlugin(code: code, callback: _callback);
  }

  @override
  Future<void> executeScript() => _plugin.run();

  @override
  Future<native.EventResult> executeEvent(LuauEvent event) => _plugin.runEvent(
    eventType: event.eventType,
    event: event.event,
    serverEvent: event.serverEvent,
    source: event.source,
    cancelled: event.cancelled,
    target: event.target,
  );

  @override
  void release() {
    _plugin.dispose();
    _callback.dispose();
  }
}
