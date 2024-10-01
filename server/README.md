# Quokka Server

This is the standalone server part of the Quokka game.
Read more [here](../README.md).

## Use as a library

You can use the server as a library in your own project.
Put the following in your `pubspec.yaml`:

```yaml
dependencies:
  quokka_server:
    git:
      url: git://github.com/QuokkaGame/quokka_server.git
      ref: <last commit or tag>
```

And then you can use the server in your code:

```dart
import 'package:quokka_server/quokka_server.dart';

Future<void> main(List<String> arguments) {
  return runServer(arguments);
}
```

## Configure

You can configure the server by providing an onLoad function that will be called before the server starts.

```dart
import 'package:quokka_server/quokka_server.dart';

Future<void> main(List<String> arguments) {
  return runServer(arguments, onLoad);
}

Future<void> onLoad(QuokkaServer server) async {
  server.eventSystem.addListener(ObjectsMoved, 
    (serverEvent,target,clientEvent,source,server) {
      print("Listener was called");
      return (serverEvent, target);
  });
}
```
