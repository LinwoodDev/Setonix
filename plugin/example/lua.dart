import 'dart:async';

import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:setonix_plugin/setonix_plugin.dart';

const LUA_SCRIPT = '''
print("Hello World")
local table = State.Table
print('Hello '..table.key)
Events.schoo.Connect(function(_, details)
  details["cancelled"] = true
  print("schoo event")
end)

''';
Future<void> main() async {
  await initPluginSystem();
  final callback = PluginCallback(
    onPrint: (p0) {
      print("PLUGIN: ${p0}");
    },
    stateFieldAccess: (p0) {
      print("FIELD ACCESS: ${p0}");
      return '{"key": "value"}';
    },
    processEvent: (p0, p1) {
      print("PROCESS EVENT: ${p0}, force: ${p1}");
    },
    sendEvent: (p0, p1) {
      print("SEND EVENT: ${p0}, target: ${p1}");
    },
    tableAccess: (p0) {
      print("TABLE ACCESS: ${p0}");
      return '{"key": "value"}';
    },
  );
  final plugin = LuauPlugin(code: LUA_SCRIPT, callback: callback);
  try {
    await plugin.run();
  } catch (e) {
    if (e is AnyhowException) {
      print("Error while evaluating lua script: ${e.message}");
    }
  }
  var result = await plugin.runEvent(
    event: '{"key": "value"}',
    eventType: 'schoo',
    serverEvent: '{"key": "server-value"}',
    source: 0,
    target: 0,
    cancelled: false,
  );
  print("cancelled: ${result.serverEvent == null}");
  result = await plugin.runEvent(
    event: '{"key": "value"}',
    eventType: 'another',
    serverEvent: '{"key": "server-value"}',
    source: 0,
    target: 0,
    cancelled: false,
  );
  print("cancelled: ${result.serverEvent == null}");
  callback.dispose();
  print('end of main');
  disposePluginSystem();
}
