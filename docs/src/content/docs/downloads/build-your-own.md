---
title: "Build your own"
---

1. Install git and flutter (beta)
2. Clone the repository
3. Navigate to the app directory
4. Generate necessary files by navigating to `tools` and then run `dart pub get` go back and run `dart run tools/generate.dart`
5. Use the flutter tool to compile the application in `app`
   * `flutter build apk`
   * `flutter build appbundle`
   * `flutter build web`
   * `flutter build linux`
   * `flutter build windows`
   * `flutter build ios --release --no-codesign`\
   after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
6. The compiled files are in the build directory
