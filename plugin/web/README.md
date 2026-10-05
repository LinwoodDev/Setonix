# Luau in the web app

Native and web builds use one Rust crate in `plugin/rust`, with one Cargo
manifest and lockfile. Its browser executable uses the same mlua/Luau engine,
Setonix prelude, event registry, state access and storage as the native library.
This directory contains only the browser loader and build script.

The public Dart `LuauPlugin` owns validation and disposal for both transports;
its factory selects native flutter_rust_bridge or browser JS interop. Only
transport-specific execution and callback handling live in separate files.

## Build

Use the repository's Rust toolchain, Flutter 3.47.6 and Emscripten 6.0.11:

```sh
rustup target add wasm32-unknown-emscripten
# Install and activate 6.0.11 using the official emsdk, then:
source /path/to/emsdk/emsdk_env.sh
bash plugin/web/build.sh
cd app
flutter pub get
flutter build web --wasm --release --no-web-resources-cdn
```

The runtime build writes its loader, Wasm module and callback adapter to
`app/web/pkg/`. Flutter includes these in `app/build/web/`; serve that directory
with a static server supporting the app's route fallback. The deployment
workflow performs these steps automatically. Generated bundles and Cargo's
target directory are ignored.

The browser adapter awaits Dart state/table/storage callbacks before starting
Lua and after async server callbacks. Lua's synchronous getters read that
snapshot. Storage writes and print callbacks are flushed in order; Process
and Send suspend the Lua coroutine while their Dart futures run. This keeps
the browser event loop available, including when server processing invokes
another Lua event. Events, cancellation, scheduled events and per-plugin
storage use the shared native implementation.

## Verify and regenerate

```sh
cd plugin
flutter_rust_bridge_codegen generate --config-file flutter_rust_bridge.yaml
cargo build --release --manifest-path rust/Cargo.toml
dart run example/runtime_smoke.dart
dart compile js example/runtime_smoke.dart -o /tmp/runtime_smoke.js
```

For the browser smoke test, serve an HTML page that loads `runtime_smoke.js`
with the generated runtime files in a sibling `pkg/` directory. The test
checks async Dart callbacks, refreshed state, storage, handler disconnection,
event changes, cancellation, scheduled events, callback/script errors,
plugin isolation, disposal and reinitialization. Also test the release app:
create Blackjack, draw with Hit, finish with Stand, then reopen the saved game.

Release event dispatch uses the JSON `type` discriminator, so Dart class-name
minification does not change the names of Lua subscriptions. The smoke test
also exercises this dispatch through `RustSetonixPlugin`; compile with `-O4`
to cover minified JavaScript.
