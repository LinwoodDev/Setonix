import 'src/rust/frb_generated.dart';

export 'src/rust/api/simple.dart';
export 'src/rust/api/plugin.dart';
export 'src/rust/api/luau.dart';
export 'events.dart';

bool _isInitialized = false;

bool get isPluginSystemInitialized => _isInitialized;

Future<void> initPluginSystem() {
  _isInitialized = true;
  return RustLib.init();
}

void disposePluginSystem() {
  _isInitialized = false;
  RustLib.dispose();
}
