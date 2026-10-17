---
title: Self-host the web app
description: Build and host the browser app with its Luau runtime and offline assets.
---

This guide hosts the Setonix browser client. To host multiplayer worlds, use the [dedicated game server](/docs/v1/server/). A static web server does not replace a multiplayer server.

## Build the client

Use the Flutter version specified in `app/pubspec.yaml`, the repository's pinned Rust toolchain, and the Emscripten version specified in `plugin/web/README.md`. Activate the Emscripten SDK before building the Luau runtime.

Run from the repository root:

```sh
dart pub get -C tools
dart run tools/generate.dart
rustup target add wasm32-unknown-emscripten
bash plugin/web/build.sh
cd app
flutter pub get
flutter build web --wasm --release --no-web-resources-cdn
dart run ../tools/build_web_service_worker.dart
```

The runtime step creates the JavaScript loader, Wasm module, and callback adapter under `app/web/pkg/`. The Flutter build copies these into `app/build/web/pkg/`. Include them in the deployment so local scripted modes such as Blackjack can run.

The final command generates the app's offline service worker. It is separate from the service worker used by this documentation website.

## Serve the build

Publish the complete `app/build/web/` directory to a static host. Configure:

- HTTPS for a public deployment and browser service-worker support.
- A navigation fallback to `index.html` for app routes such as games, settings, and the editor.
- Correct content types for JavaScript and `.wasm` files.
- Deployment of the whole output, including `pkg/`, assets, and service-worker files.

For a local smoke test, serve that output directory with a static server. A server without route fallback can load the home page but fail when a deep route is refreshed.

## Verify the deployment

Create a Blackjack game, choose **Deal**, draw with **Hit**, finish with **Stand**, leave, and reopen the save. Check that the runtime assets load without errors. Let the service worker install, then reopen the app offline to check cached loading.

Browser saves are stored by site origin and browser profile. Moving to a different domain does not move existing saves; export and import games to transfer them. For runtime build and smoke-test details, see [plugin/web/README.md](https://github.com/LinwoodDev/Setonix/blob/develop/plugin/web/README.md).
