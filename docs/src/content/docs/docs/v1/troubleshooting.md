---
title: Troubleshooting
description: Resolve missing packs, connection problems, authentication errors, and browser storage issues.
---

## A server cannot be reached

Check the host address, port, **Secure** setting, and that the host is still running. For LAN play, use the host's network address rather than `127.0.0.1`, which refers to your own device. A dedicated server binds to loopback by default; its owner must deliberately configure an externally reachable host.

For remote connections, check the firewall, router, or reverse proxy. An HTTPS web app generally needs a secure WebSocket server. See [multiplayer](/docs/v1/multiplayer/) and [server setup](/docs/v1/server/).

## Protocol unavailable or protocol mismatch

Update the client and server to compatible builds. Older servers may not advertise a protocol version at all. App versions and protocol versions are distinct; the connection error lists supported protocols when available.

## Authentication fails

- **Authentication required:** create or select a local account.
- **Origin mismatch:** join the server's canonical public address. The owner must configure `publicAddress` for a proxy, NAT, or wildcard bind.
- **Not registered / Please link:** follow the server's registration link.
- **Not whitelisted / Banned:** contact the server owner if you believe this is a mistake.
- **Challenge failed:** reconnect and retry. Unauthenticated connections time out and repeated failed attempts close the connection.

Public account authentication uses WSS. Plaintext account authentication is accepted only on local loopback. [Backups](/docs/v1/accounts/) restore an existing identity; creating another account with the same name does not.

## Missing or invalid packs

Download the requested packs, then reconnect. If no source exists, import the exact pack supplied by the host. A matching name and version are not enough: identifiers depend on the archive's bytes. An invalid-identifier message means the downloaded file differs from the requested pack.

For your own pack, check its [archive structure](/docs/v1/packs/overview/), JSON definitions, and texture paths. `pack.json` must be at the archive root.

## Pieces, notes, or actions cannot be edited

Check the mode, server permissions, and team visibility. Blackjack deliberately disables sandbox editing. A note action is enabled only if it exists in your current toolbar and is enabled for you. To try unrestricted editing, create a separate Custom game.

## A browser game does not load or resume

Allow the site's required browser storage and JavaScript/Wasm resources. Try reloading after an update. Aggressive anti-fingerprinting settings can prevent loading; adjust those settings for this site if necessary.

Browser saves belong to that browser profile and site origin. Clearing site data or using another browser does not carry games across. Import a previously exported `.stnx` backup to restore a game. For self-hosted builds, include the Luau runtime and configure navigation fallback as described in [web hosting](/downloads/selfhosting/).

## Report a problem

Include the Setonix versions on both ends, platform/browser, chosen mode, transport, exact error, and steps to reproduce. Share a minimal game or pack when possible, with private content removed. Use [GitHub issues](https://github.com/LinwoodDev/Setonix/issues) or the [community](/community/).
