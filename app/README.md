# Linwood Setonix

Read more about it [here](../README.md).

## Android release checks

Android uses AGP 9, Kotlin 2.4, and the Gradle wrapper committed in
`android/gradle/wrapper`. Build with the Flutter version in `pubspec.yaml`
and the Rust version in the repository's `rust-toolchain.toml`. Built-in
Kotlin remains disabled because `cryptography_flutter_plus` applies the
Kotlin Gradle plugin itself.

CI checks universal and split APKs, legacy APKs, and the Play bundle for
16 KB ELF alignment and native-library packaging. To check a local build:

```sh
dart pub get -C tools
dart run tools/check_android_page_sizes.dart app/build/app/outputs/flutter-apk/app-production-release.apk
```

Run those commands from the repository root. A 32-bit-only APK has no
64-bit libraries to check.

For native nightly packages, apply branding from a clean checkout before
building (replace `linux` with `windows`, `macos`, or `ios` as needed):

```sh
dart run tools/apply_branding.dart nightly linux
```

The script edits platform files in place. Production builds keep the
checked-in branding.

## Offline web builds

Build the plugin bundle with `bash plugin/web/build.sh` first (see the plugin
web toolchain instructions), then build and generate the offline cache from
the repository root:

```bash
dart pub get -C tools
cd app
flutter build web --wasm --release --no-web-resources-cdn
cd ..
dart run tools/build_web_service_worker.dart
```

Run the generator after all build files have been written, then deploy all of
`app/build/web` over HTTPS (localhost also works). The deployment workflow does
this for both stable and nightly. It replaces Flutter's cleanup stub at
`flutter_service_worker.js` with Butterfly's own worker. Custom output directories
can be passed as the generator's first argument; subpath hosting uses Flutter's
`--base-href` as usual.

After one online visit and successful cache installation, the app can reload
offline, including deep links, rendering engines, fonts, and bundled import
libraries. Local worlds stay in browser storage; multiplayer and network imports
still need a connection. The first download caches the entire build, so leave
the app online until the worker activates (visible in browser developer tools).
New builds wait until all app tabs close before activating, preserving open
editing sessions. Serve the worker with revalidation enabled rather than
immutable caching. The worker only caches bundled files, never API responses.
