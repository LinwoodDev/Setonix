---
title: Dedicated server
description: Run a persistent Setonix host, configure secure connections, and extend it with Dart.
---

The dedicated server hosts worlds independently of a player's app. Download a server build from the [project releases](https://github.com/LinwoodDev/Setonix/releases), unpack it, and run the executable from the directory where you want its data stored. The examples below call the executable `server`; use the filename included in your build.

```sh
./server --help
./server
```

The default bind is `127.0.0.1:28006`, suitable for local testing. In the app, add `ws://127.0.0.1:28006`, select **Play**, and choose an account if requested. Use matching client and server builds with compatible protocol versions.

## Server directory

| Path | Contents |
| --- | --- |
| `config.json` | Server configuration; created on first start |
| `packs/` | Content packs, including the bundled core pack |
| `worlds/` | Saved worlds as `.stnx` archives |
| `scripts/` | Additional server scripts with the `.lua` extension |
| `setonix.db` | Local registered users, roles, whitelist entries, and bans |
| `certs/server.crt`, `certs/server.key` | Optional certificate and private key for direct TLS |

Add custom pack archives to `packs/` before starting the server. Mode scripts live inside their packs; loose server scripts go in `scripts/`. World files use the same archive format as singleplayer games. Back up `worlds/`, packs, configuration, and the user database together while the server is stopped.

Use `worlds`, `packs`, `modes`, and `scripts` in the terminal to inspect what was loaded. Use `save` to save all worlds and `stop` for an orderly shutdown. See the [console command reference](/docs/v1/server/commands/) and [server lists and thumbnails](/docs/v1/server/directory/).

## Secure server setup

For local play, connect to `ws://127.0.0.1:28006`. Account authentication over plaintext WebSockets is accepted only on loopback.

For a directly exposed public server, provide `certs/server.crt` and `certs/server.key`. If `--host` is the exact address players use, it becomes the authentication identity:

```sh
./server --host play.example.com
```

For a wildcard bind, NAT, container, or reverse proxy, specify the public address:

```sh
./server --host 0.0.0.0 --public-address wss://play.example.com:28006
```

Use the actual public port, including `443` if that is where the proxy accepts clients. The value can also be stored as `publicAddress` in `config.json`. When no certificate is installed locally, a `wss://` public address requires TLS to terminate at a trusted reverse proxy. Configure WebSocket forwarding and protect the proxy-to-server connection.

Authentication uses short-lived, connection-bound Ed25519 challenges containing the canonical origin, protocol version, timestamps, channel, and nonce. The server rejects public plaintext account authentication, closes unauthenticated connections after 45 seconds, and closes a connection after three failed attempts. Clients sign only over WSS, loopback, or secure end-to-end encrypted Swamp rooms. TLS certificates remain responsible for hostname validation.

See [accounts](/docs/v1/accounts/) for the player's workflow and [configuration](/docs/v1/server/configuration/) for all server options.

### nginx reverse proxy

For nginx on the same machine, keep Setonix bound to loopback and add these fields to `config.json`:

```json
{
  "host": "127.0.0.1",
  "port": 28006,
  "publicAddress": "wss://play.example.com:443",
  "trustedProxies": ["127.0.0.1"]
}
```

The equivalent CLI options are `--host 127.0.0.1 --port 28006 --public-address wss://play.example.com:443 --trusted-proxy 127.0.0.1`. TLS terminates at nginx; the backend does not need certificates in `certs/` for this setup.

Place the following inside nginx's `http` context, replacing the domain and certificate paths with your own:

```nginx
map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}

server {
    listen 443 ssl;
    server_name play.example.com;

    ssl_certificate /etc/letsencrypt/live/play.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/play.example.com/privkey.pem;

    location / {
        proxy_pass http://127.0.0.1:28006;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_read_timeout 3600s;
        proxy_send_timeout 3600s;
    }
}
```

This forwards both WebSockets and HTTP status/thumbnail requests, preserving paths and query parameters. The example overwrites `X-Forwarded-For` with nginx's connecting client address. For multiple proxies, configure each hop to append the actual peer address and list every trusted proxy in `trustedProxies`. Only those addresses may supply client IPs for logging and authentication rate limits. The authentication origin remains the explicit `publicAddress`.

To preserve an existing proxy chain, use `proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;` instead. This appends nginx's connecting peer to the existing comma-separated list. Setonix checks that list from right to left through the trusted proxies. `proxy_set_header X-Real-IP $remote_addr;` sends a single address for backends that use that header; Setonix uses `X-Forwarded-For`, so `X-Real-IP` is optional and is not read.

Check nginx configuration with `nginx -t`, then reload nginx and connect using `wss://play.example.com:443`. See nginx's [WebSocket proxying guide](https://nginx.org/en/docs/http/websocket.html) for upgrade headers and idle timeouts.

## Worlds and game modes

The server loads `.stnx` saves from `worlds/`. Use `--game-mode core:blackjack` to select the mode for a new default world. Existing saves keep their saved state. `modes` lists available identifiers.

`worlds` lists loaded names and their player counts. Commands such as `save`, `players`, `scripts`, and `reset` accept a world argument. Use the names printed by `worlds` when administering a session.

Multi-world support is incomplete: the executable accepts `--multi-world` and loads the world directory, but connected users are currently assigned to the default world. Do not rely on a URL path to select an independent play session.

`reset <World> <Mode>` replaces that world's contents. Save a backup before using it. `reset <World> sandbox` returns it to a blank sandbox.

## Roles and users

The default account role is `player`. To give an authenticated user administrative controls, enter `role add @Name owner` in the server terminal. Use `players` to inspect names, IDs, fingerprints, and roles. See [permissions](/docs/v1/server/permissions/) for multiple roles, priorities, bans, and whitelists.

## Dart library

The server can also be embedded in a Dart application. Add the `setonix_server` package from this repository, selecting a release tag compatible with your client:

```yaml
dependencies:
  setonix_server:
    git:
      url: https://github.com/LinwoodDev/Setonix.git
      path: server
      ref: <release-tag>
```

```dart
import 'package:setonix_server/setonix_server.dart';

Future<void> main(List<String> arguments) => runServer(arguments, onLoad);

Future<void> onLoad(SetonixServer server) async {
  server.log('Custom server loaded');
}
```

Use `onLoad` for custom startup logic and `server.eventSystem` for event handlers. Handlers can inspect requests, cancel an event, and send replacement or scheduled events. For detailed types, see the [API reference](https://api.setonix.world/) and [server examples](https://github.com/LinwoodDev/Setonix/tree/develop/server/example). Pack-level rules can usually use [Luau](/docs/v1/scripting/luau/) instead.

Hosting the browser app is a separate deployment; see [web app self-hosting](/downloads/selfhosting/).
