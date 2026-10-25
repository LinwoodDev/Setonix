# Luau in the web app

Native and web use the same Rust crate, generated flutter_rust_bridge bindings,
Dart adapter, Luau engine, prelude, event registry and storage implementation.
There is no hand-written JavaScript transport or separate Dart web runtime.
This directory contains the browser build script.

## Build

Use Flutter as specified in [app/pubspec.yaml](../../app/pubspec.yaml) and the
Rust toolchain pinned in [rust-toolchain.toml](../../rust-toolchain.toml).
Install the WASI SDK required by [build.sh](build.sh) and wasm-bindgen-cli
matching [rust/Cargo.lock](../rust/Cargo.lock). The
[deployment workflow](../../.github/workflows/deploy.yml) contains the tool
installation commands.

```sh
rustup target add wasm32-unknown-unknown
# Download and extract the WASI SDK archive for your host, then:
export WASI_SDK_PATH=/absolute/path/to/wasi-sdk
bash plugin/web/build.sh
cd app
flutter pub get
flutter build web --wasm --release --no-web-resources-cdn
```

The build generates `setonix_plugin.js` and `setonix_plugin_bg.wasm` in
`app/web/pkg/`. flutter_rust_bridge loads these directly. Flutter includes them
in `app/build/web/`; serve that directory with the app's route fallback. The
deployment workflow installs both pinned tools and builds these automatically.
Generated bundles and Cargo's target directory are ignored. `WASM_BINDGEN` can
point to a CLI binary outside PATH.

The Rust target is `wasm32-unknown-unknown`; Luau's C++ code links WASI
Preview 1 libc and the SDK's standard Wasm exception runtime. The small
`rust/src/wasm.rs` adapter provides clocks, console output and an empty
environment using wasm-bindgen. Rust and libc share an allocator, and the
bridge initializer runs C++ constructors once. Browsers must support standard
WebAssembly exception handling (`exnref`). The pinned mlua Git revision
includes this target support ahead of a release.

## Shared callback behavior

Lua's synchronous state/table/storage getters read a Rust snapshot populated
by the common Dart adapter before execution. Print and storage effects are
flushed in order before asynchronous server callbacks and when execution ends.
Process and Send suspend the Lua coroutine while Dart futures run, then refresh
the snapshot before resuming. Both platforms use this same flow, including
nested events, cancellation, scheduled events and per-plugin storage.

## Verify and regenerate

```sh
cd plugin
flutter_rust_bridge_codegen generate --config-file flutter_rust_bridge.yaml
cargo build --release --manifest-path rust/Cargo.toml
```

The normal regression suites cover scripting and game behavior:

```sh
cd ../server
FRB_DART_LOAD_EXTERNAL_LIBRARY_NATIVE_LIB_DIR="$PWD/../plugin/rust/target/release" \
  dart test test/scripting_test.dart test/blackjack_test.dart test/chess_test.dart
```

Also verify the release app in a browser: create Blackjack, Deal, Hit, Stand,
then leave and reopen the saved game. Check that the round and score persist.
Release event dispatch uses the JSON `type` discriminator, so Dart class-name
minification does not change Lua subscriptions.
