# Contribution guide

There are many ways to contribute to this project.
Thanks to everyone who has contributed!
If you have any questions, please contact me at [contact@linwood.dev](mailto:contact@linwood.dev).

There is a matrix server for this project [here](https://linwood.dev/matrix) and a discord server [here](https://discord.linwood.dev).

Please follow the [Code of Conduct](https://setonix.world/code-of-conduct).

## Give feedback

The best way to give feedback is to open an issue on GitHub.
Please report any bug you find [here](https://github.com/LinwoodDev/Qeck/issues/new?assignees=CodeDoctorDE&labels=bug%2Ctriage&template=bug_report.yml&title=%5BBug%5D%3A+).

If you have a feature that you would like to see added, please open an issue [here](https://github.com/LinwoodDev/Setonix/issues/new?assignees=CodeDoctorDE&labels=enhancement%2Ctriage&template=feature_request.yml&title=%5BFeature+request%5D%3A+).

## Test nightly builds

Nightly builds are not production ready and need to be tested.
Please report any bugs in the github issues section.

Read more about it [here](https://setonix.world/nightly).

## Write documentation

Documentation is important for users to understand the program and its features.
The documentation is written in markdown, a simple markup language. It can be found in the `docs` folder.

To start, please install [pnpm](https://pnpm.io/installation).

Get started by running:

```bash
cd docs
pnpm install
pnpm start
```

All stable documentation can be found in the `versioned_docs` folder.

Fork the project and create a pull request to add your documentation to the `develop` branch.

## Translate

Crowdin is a service that allows you to translate the documentation and the app.
Click [here](https://translate.linwood.dev/qeck) to see the project and start translating.
If you have a new language to add, please contact me.

## Code

This project is written in [Dart](https://dart.dev/) and was built with [Flutter](https://flutter.dev/).
The app source code can be found in the `app` folder.

Please install the dependencies first:

- libsecret-1-dev
- libjsoncpp-dev

On windows, please install visual studio build tools (or visual studio) and all flutter dependencies. Additionally install the atl library.

To get started, run:

```bash
cd app
flutter pub get
flutter run
```

The repository contains five Dart packages: `app` (Flutter client), `api`
(shared models and protocol), `plugin` (Dart/Rust bridge), `server` (game
server), and `tools` (generation and release scripts). `docs` and `servers`
are separate Astro projects, each with its own pnpm manifest and lockfile.

Use the Flutter version in `app/pubspec.yaml`, the Rust toolchain pinned at
the repository root, and each website's pinned `packageManager` version.
Generate the core pack from the repository root before running the client:

```bash
dart pub get -C tools
dart run tools/generate.dart
```

CI checks formatting, strict analysis, generated files, Flutter tests in
`app`, Dart tests in `api` and `server`, and the Rust plugin. When changing
models, run `dart run build_runner build` in each affected package and
format its generated files before committing.

All subdirectories are documented in the `app/README.md` file.

Fork the project and create a pull request to add your code to the `develop` branch.

## Windows development

This repository contains symbolic links, including the Rust toolchain file used by the Setonix plugin. On Windows, Git may check out symbolic links as plain text files when symbolic link support is disabled. This can cause the Flutter Windows build to fail because `plugin/rust/rust-toolchain.toml` is read as link text instead of as a real symbolic link.

Before cloning the repository on Windows, enable symbolic link support in Git:

```powershell
git config --global core.symlinks true
```

Then clone the repository again:

```powershell
git clone <repository-url>
```

If the repository was already cloned, enable symbolic links locally and restore the symlink:

```powershell
git config core.symlinks true
git restore --source=HEAD --staged --worktree plugin/rust/rust-toolchain.toml
```

If the file is still restored as plain text, remove it and check it out again:

```powershell
Remove-Item plugin\rust\rust-toolchain.toml
git checkout -f HEAD -- plugin/rust/rust-toolchain.toml
```

You can verify that Git created a real symbolic link with:

```powershell
Get-Item plugin\rust\rust-toolchain.toml | Format-List LinkType,Target,FullName
```

The `LinkType` should be `SymbolicLink`.

If Windows does not allow creating symbolic links, enable Developer Mode in Windows settings or run the terminal as Administrator.
