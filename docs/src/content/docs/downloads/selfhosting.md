---
title: Selfhosting
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FQuokka%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

It is very easy to host your own quokka web server.

## Simple server

Install flutter and build the app using:

```bash
cd tools
dart pub get
cd ..
dart run tools/generate.dart
cd app
flutter pub get
flutter build web
```

All the files are in the `app/build/web` directory.
