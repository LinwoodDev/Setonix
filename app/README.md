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
