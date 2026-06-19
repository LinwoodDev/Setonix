import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

import 'src/rust/frb_generated.dart';

export 'src/rust/api/simple.dart';
export 'src/rust/api/plugin.dart';
export 'src/rust/api/luau.dart';
export 'events.dart';

bool _isInitialized = false;

bool get isPluginSystemInitialized => _isInitialized;

Future<void> initPluginSystem({ExternalLibrary? externalLibrary}) async {
  await RustLib.init(externalLibrary: externalLibrary);
  _isInitialized = true;
}

void disposePluginSystem() {
  _isInitialized = false;
  RustLib.dispose();
}
