---
title: Server configuration
description: Configure networking, worlds, users, thumbnails, and server roles.
---

The server reads `config.json` from its working directory and merges it with Dart environment declarations and command-line arguments. Later values override earlier ones. Restart the server after editing the file, except for role definitions updated through console commands, which are applied and saved at runtime.

## Configuration fields

| Field | Model default | Purpose |
| --- | --- | --- |
| `host` | `"127.0.0.1"` | Bind address |
| `port` | `28006` | WebSocket/status port |
| `publicAddress` | `""` | Canonical address used for authentication |
| `trustedProxies` | `[]` | Proxy IP addresses or CIDR networks allowed to supply `X-Forwarded-For` |
| `description` | `"A server for Setonix."` | Text shown in server lists |
| `thumbnail` | `""` | Image path, absolute or relative to the server directory |
| `autosave` | `true` | Save changes automatically |
| `multiWorld` | `false` | Reserved for multi-world connections; routing is incomplete |
| `maxPlayers` | `-1` | Player limit; negative means unlimited |
| `gameMode` | `""` | Mode for a new default world; empty means sandbox |
| `guestPrefix` | `"Guest "` | Prefix for guest names |
| `accountRequired` | `true` | Require account authentication |
| `whitelistEnabled` | `false` | Restrict access to whitelisted registered users |
| `apiEndpoint` | `""` | Optional remote user-service base URL |
| `endpointSecret` | `""` | Bearer secret for that service |
| `serverRoles` | Built-in roles | Role definition map |
| `worldFile` | `"world.stnx"` | Legacy model field; current world loading uses `worlds/*.stnx` |

The executable currently supplies `autosave: false`, `maxPlayers: 10`, and `multiWorld: false` to the configuration merge when their options are absent. These override the model/file values. In embedded servers, the model defaults apply unless the caller supplies overrides.

## Command-line options

| Option | Short | Meaning |
| --- | --- | --- |
| `--help` | `-h` | Show usage |
| `--version` | `-V` | Show executable version |
| `--verbose` | `-v` | Additional output |
| `--host <address>` | `-H` | Bind address |
| `--port <number>` | `-p` | Listen port |
| `--description <text>` | `-d` | Server-list description |
| `--thumbnail <path>` | `-t` | Server-list image |
| `--max-players <number>` | `-m` | Player limit |
| `--multi-world` | `-w` | Set the multi-world option; routing is incomplete |
| `--public-address <url>` | | Canonical public URL |
| `--trusted-proxy <ip-or-cidr>` | | Trust a reverse proxy; repeat or separate entries with commas |
| `--game-mode <namespace:id>` | `-g` | Initial mode |
| `--autosave <value>` | `-a` | Current parser requires a value and enables autosave when the option is present |

The current `--autosave` implementation checks whether the option was supplied, not its value; `--autosave false` also enables it. Use `--autosave true` to enable automatic saving. Without it, use `save` and an orderly `stop` to persist your session. The help text for this option does not match that behavior.

```sh
./server --host 127.0.0.1 --port 28006 --autosave true --max-players 8 --game-mode core:blackjack
```

For public access, configure TLS and the public origin as described in [server setup](/docs/v1/server/#secure-server-setup).

## Dart environment declarations

The `SETONIX_*` names are read using Dart's `String.fromEnvironment`, `bool.fromEnvironment`, and `int.fromEnvironment`. These are compilation/environment declarations, not ordinary process environment variables read through `Platform.environment`.

Available names are `SETONIX_HOST`, `SETONIX_PORT`, `SETONIX_WORLD_FILE`, `SETONIX_AUTOSAVE`, `SETONIX_MULTI_WORLD`, `SETONIX_MAX_PLAYERS`, `SETONIX_DESCRIPTION`, `SETONIX_THUMBNAIL`, `SETONIX_GUEST_PREFIX`, `SETONIX_WHITELIST_ENABLED`, `SETONIX_ACCOUNT_REQUIRED`, `SETONIX_PUBLIC_ADDRESS`, `SETONIX_TRUSTED_PROXIES`, `SETONIX_API_ENDPOINT`, `SETONIX_ENDPOINT_SECRET`, and `SETONIX_GAME_MODE`. `SETONIX_TRUSTED_PROXIES` is a comma-separated list of IP addresses or CIDR networks; an empty value disables proxy trust. Use `config.json` or CLI options to configure a downloaded executable.

## Trusted reverse proxies

No proxies are trusted by default. Set `trustedProxies` to the source IP addresses or CIDR networks of your proxies, for example `["127.0.0.1", "::1"]` for nginx on the same machine. IPv4 and IPv6 are supported; hostnames and wildcards are rejected. Invalid entries prevent startup. Lists supplied by environment declarations or CLI replace earlier lists.

For WebSocket connections from a trusted peer, the server reads `X-Forwarded-For` from right to left, skips trusted proxy hops, and uses the first untrusted address as the client IP. This address is used for logs, player listings, plugins, and authentication rate limits. Headers from untrusted peers are ignored. Missing or malformed forwarding headers fall back to the socket peer address.

Trust only proxies you control, and configure them to overwrite forwarding headers or append the actual connecting client's address. Keep the backend listener on loopback or restrict access to it. `trustedProxies` controls forwarded IP handling; it does not restrict connections to the listener or enable TLS. Authentication continues to use the configured `publicAddress`, so set it to the public `wss://` URL when TLS terminates at the proxy. See the [nginx example](/docs/v1/server/#nginx-reverse-proxy).

## Roles and registration services

Each `serverRoles` entry has a `name`, integer `priority`, and `permissions` array. See [roles and permissions](/docs/v1/server/permissions/) for a complete example.

By default users are stored in `setonix.db`. A non-empty `apiEndpoint` selects a remote user service instead. It must use HTTPS, except for localhost HTTP. Requests include `Authorization: Bearer <endpointSecret>` when a secret is set. The service handles user lookup and updates for names, roles, whitelisting, bans, and login times. The implementation is documented by [RemoteUserService](https://github.com/LinwoodDev/Setonix/blob/develop/server/lib/src/services/user/remote.dart).
