---
title: Server
---

Servers can easily be started by running the executable in the console. The server listens only on `127.0.0.1:28006` by default, which is suitable for secure local testing.
You can find all available options by running the executable with the `--help` flag.

## Directory

When starting the server, it will create a directory called `packs` in the current working directory. This directory will contain all the packs that are loaded into the server.
There should be a core pack already installed in the directory. This pack contains all the default cards, boards, and dice.
Put your custom packs in this directory to load them into the server.

## Secure server setup

For local play, start the server without additional options and connect to `ws://127.0.0.1:28006`. Account authentication over plaintext WebSockets is accepted only on loopback.

For a directly exposed public server, create a `certs` directory in the current working directory and provide the certificate as `server.crt` and its private key as `server.key`. If `--host` is the exact address players use, it automatically becomes the authentication identity:

```bash
server --host play.example.com
```

For Docker, wildcard binds, NAT, or a reverse proxy, specify the public address once:

```bash
server --host 0.0.0.0 --public-address wss://play.example.com:28006
```

The same value can be stored as `publicAddress` in `config.json` or provided as `SETONIX_PUBLIC_ADDRESS`. When no certificate is installed locally, a `wss://` public address means TLS must terminate at a trusted reverse proxy. Protect the connection between that proxy and the Setonix server.

The server refuses public plaintext account authentication. Use loopback for local development.

Authentication uses a short-lived, connection-bound Ed25519 transcript containing the canonical server origin, protocol version, timestamps, channel, and random nonce. Unauthenticated connections time out after 45 seconds, and three failed attempts close the connection.

Clients only sign authentication challenges over WSS, local loopback, or secure end-to-end encrypted Swamp rooms. The signed challenge is bound to the fixed public server address, similar to a passkey RP ID, so a challenge relayed through another domain is rejected before signing. The certificate remains responsible for normal TLS hostname validation; Setonix does not parse or duplicate its hostname rules.

The world will be saved in the current working directory in a file called `world.stnx`. This file will contain all the data of the world, including the packs that are loaded into the server. This file is compatible with the single player world file.

## Library

The server software can also be used as a library. This allows you to create custom server software with your own logic. The server software is written in Dart.

To create a new project with the server software, you can use the following command:

```bash
dart create server
cd server
```

Now go to the `pubspec.yaml` file and add the following dependency:

```yaml
dependencies:
  setonix_server:
    git:
      url: https://github.com/LinwoodDev/Setonix.git
      path: server
      ref: <version>
```

Replace `<version>` with the version you want to use (for example `v0.1.0`). It's recommended to use the latest version.

Now go to the `bin/main.dart` file and add the following code:

```dart
import 'package:setonix_server/setonix_server.dart';

Future<void> main(List<String> arguments) {
  return runServer(arguments);
}
```

Now you can run the server software with the following command:

```bash
dart run
```

You will have the same setup as the server software, but you can now customize it to your needs.

### Customization

To further customize the server software, you can pass an `onLoad` function to the `runServer` function. This function will be called when the server loads. You can use this function to add custom logic to the server software.

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
  server.eventSystem.on<ObjectsMoved>((e) {
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

See the [API documentation](https://api.setonix.world/) for more information about the server software.

There are examples, you can find [here](https://github.com/LinwoodDev/Setonix/blob/develop/server/example).
