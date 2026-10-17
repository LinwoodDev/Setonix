---
title: Multiplayer
description: Join a server, host friends, share a world, and manage players.
---

Multiplayer shares a world between clients. Use compatible Setonix versions on the host and clients. The connection negotiates a protocol version; update the client or server if there is no compatible version.

## Join a game

1. Open **Servers** on the home screen.
2. Choose a saved server under **Your servers**, a nearby **LAN** game, or an entry from **Browse**. Use **Add** to enter an address yourself.
3. Select the server to inspect its description and players, then choose **Play**.
4. If requested, choose a local [account](/docs/v1/accounts/) to authenticate.

An address can identify a WebSocket server or a Swamp room. For direct connections, the usual port is `28006`. Use **Secure**/`wss://` for a public server with TLS. Browsers may block plaintext connections from an HTTPS page.

The public directory is also available at [servers.setonix.world](https://servers.setonix.world). Configure directory sources under **Settings → Server lists**. Loading the default list is optional; manually added servers do not require it.

## Host from the app

Open a local game, then open its **Multiplayer** controls and choose **Start**. Native apps offer:

| Transport | Setup |
| --- | --- |
| Web Socket | Choose a port. Friends on the same network connect to your machine's address. Remote access also needs suitable firewall and router configuration. |
| Swamp | Enter the Swamp service address, start the room, and share the generated session URL. |

Copy the connection URL from the multiplayer panel. The host must keep the app and world open. Use **Stop** to end the hosted session. The browser app can join games, but starting an app-hosted session is disabled there. For an independent host, use the [dedicated server](/docs/v1/server/).

## Required packs

If a server uses packs that are not installed locally, Setonix shows the missing packs and any available download sources. Choose **Download selected** or **Download all**, then reconnect. Pack identifiers are checked against the downloaded archive; a different build is not interchangeable simply because its name matches.

If no download is offered, ask the host for the exact `.stnx` pack and import it from **Library**. Only download content from sources you trust.

## Players and moderation

The in-game multiplayer panel lists connections and players. Depending on your permissions, you can rename players, kick them, ban them with a reason and duration, manage game or server roles, and inspect or remove active bans. A kick ends a connection; a ban prevents the registered identity from reconnecting until it expires or is removed.

Dedicated servers support multiple roles per account and enforce role priorities for moderation. See [roles and permissions](/docs/v1/server/permissions/). Game roles are separate, mode-defined values.

## Disconnect and recover

Use **Disconnect** or return **Home** to leave. After an unexpected disconnect, use **Reconnect** or select the server again. An origin-mismatch message means the server's configured identity differs from the address you joined; ask its owner to correct the public address. See [troubleshooting](/docs/v1/troubleshooting/) for connection, pack, and authentication errors.
