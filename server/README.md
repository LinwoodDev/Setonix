# Setonix Server

This is the standalone server part of the Setonix game.
Read more [here](../README.md).

## Use as a library

You can use the server as a library in your own project.
Put the following in your `pubspec.yaml`:

```yaml
dependencies:
  setonix_server:
    git:
      url: git://github.com/LinwoodDev/Setonix.git
      ref: <last commit or tag>
      path: server
```

And then you can use the server in your code:

```dart
import 'package:setonix_server/setonix_server.dart';

Future<void> main(List<String> arguments) {
  return runServer(arguments);
}
```

## Configure

You can configure the server by providing an onLoad function that will be called before the server starts.

```dart
import 'package:setonix_server/setonix_server.dart';

Future<void> main(List<String> arguments) {
  return runServer(arguments, onLoad);
}

Future<void> onLoad(SetonixServer server) async {
  print("on load was called");
  // Add your custom code here
  bool toggleCancel = false;
  // Put the event you want to listen to in the brackets
  server.eventSystem.on<ObjectsMoved>().listen((e) {
    print("Listener was called, cancel: $toggleCancel");
    // Cancel the event every second time and duplicate the objects instead
    if (toggleCancel) {
      final event = e.clientEvent;
      final table = e.getTableOrDefault(event.table);
      final cell = table.getCell(event.from);
      final objects = List<GameObject>.from(table.getCell(event.to).objects);
      for (final index in event.objects) {
        final object = cell.objects[index];
        objects.add(object);
      }
      // Send the event to all clients
      e.sendEvent(ObjectsSpawned(e.clientEvent.table, {event.to: objects}));
      // Cancel the event
      e.cancel();
    }
    toggleCancel = !toggleCancel;
  });
}
```
