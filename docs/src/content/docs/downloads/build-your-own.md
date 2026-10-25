---
title: Build your own
description: Prepare the source tree and build the Flutter client for your platform.
---

## Prepare the repository

Install Git, the Flutter version specified in `app/pubspec.yaml`, and the Rust toolchain pinned in `rust-toolchain.toml`. Install Flutter's platform build dependencies for your target. The native Luau plugin is built through Flutter's native asset hooks.

```sh
git clone https://github.com/LinwoodDev/Setonix.git
cd Setonix
dart pub get -C tools
dart run tools/generate.dart
cd app
flutter pub get
```

The generation step prepares the bundled core pack and other generated assets. See [CONTRIBUTING.md](https://github.com/LinwoodDev/Setonix/blob/develop/CONTRIBUTING.md) for native dependencies, Windows symbolic-link setup, code generation, and checks.

## Build a platform target

Run the command appropriate for your target from `app/`:

| Target | Command |
| --- | --- |
| Android APK | `flutter build apk` |
| Android app bundle | `flutter build appbundle` |
| Linux | `flutter build linux` |
| Windows | `flutter build windows` |
| macOS | `flutter build macos` |
| iOS without signing | `flutter build ios --release --no-codesign` |

Build desktop and Apple targets on a supported host OS with its required toolchain. iOS distribution needs a suitable signing or sideloading workflow. Outputs are under `app/build/`.

For the browser build, also compile the Luau Wasm runtime and generate offline assets. Follow [web app self-hosting](/downloads/selfhosting/) for the complete build steps.

To run during development, use `flutter run` after preparing the repository. For the separate Dart game server, see [server documentation](/docs/v1/server/) and the server package's source.
