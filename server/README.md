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

### Custom roles and permissions

Role and permission identifiers are open strings. Use `namespace:key` for
values owned by a custom server or pack. Built-in identifiers remain
unqualified for compatibility and resolve against the `core` pack.

```json
{
  "serverRoles": {
    "blackjack:dealer": {
      "name": "Dealer",
      "priority": 25,
      "permissions": ["play", "blackjack:deal", "blackjack:shuffle"]
    }
  }
}
```

Custom server code can check effective user permissions with
`rolesAllowPermission(user.roles, 'blackjack:deal', roles)`.

Users may have multiple roles. Their effective permissions are the union of
all assigned roles, and their highest role priority is used for moderation
hierarchy checks. The `player` role is always retained.

Role assignments can be managed from the server console:

```text
role list <user>
role add <user> <role>
role remove <user> <role>
role set <user> <role...>
```

Role definitions are managed persistently with `roles`:

```text
roles list
roles show <role>
roles create <role> <priority> <display name...>
roles delete <role> [replacement]
roles rename <role> <display name...>
roles priority <role> <priority>
roles permission add <role> <namespace:key>
roles permission remove <role> <namespace:key>
```

Deleting a role replaces it with `player` unless another replacement is
provided. The default `player` role cannot be deleted.

Role and permission labels use the regular pack translation files. For the
example above, add this to `translations/en.json` in the `blackjack` pack:

```json
{
  "roles": {
    "dealer": { "name": "Dealer" }
  },
  "permissions": {
    "deal": { "name": "Deal cards" },
    "shuffle": { "name": "Shuffle cards" }
  }
}
```

## Console commands

The server console exposes the following runtime management commands:

```text
players [world]
bans
ban <user> [minutes] [reason...]
unban <user>
kick <user> [reason] [link]
worlds
modes
reset [world] [game-mode|sandbox]
save [world]
scripts [world]
packs
say <message...>
whitelist <add|remove> <user>
role <list|add|remove|set> <user> [roles...]
roles <list|show|create|delete|rename|priority|permission> ...
stop
```

User references may use a channel (`#2`), name (`@Player`), fingerprint
(`*fingerprint`), or the unprefixed forms accepted by the individual command.
