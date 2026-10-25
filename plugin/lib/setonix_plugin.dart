import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

import 'src/rust/frb_generated.dart';

export 'src/rust/api/plugin.dart'
    show EventResult, RustPlugin, StateFieldAccess;
export 'src/runtime/luau.dart' show LuauPlugin, PluginCallback;
export 'events.dart';

bool _isInitialized = false;

bool get isPluginSystemInitialized => _isInitialized;

Future<void> initPluginSystem({ExternalLibrary? externalLibrary}) async {
  if (_isInitialized) return;
  await RustLib.init(externalLibrary: externalLibrary);
  _isInitialized = true;
}

void disposePluginSystem() {
  if (!_isInitialized) return;
  _isInitialized = false;
  RustLib.dispose();
}
