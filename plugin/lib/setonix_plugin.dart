import 'src/rust/frb_generated.dart';

export 'src/rust/api/simple.dart';
export 'src/rust/api/plugin.dart';
export 'src/rust/api/luau.dart';
export 'events.dart';

Future<void> initPluginSystem() {
  return Future.value();
}

void disposePluginSystem() {
  RustLib.dispose();
}
