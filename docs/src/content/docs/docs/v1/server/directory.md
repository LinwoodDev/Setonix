---
title: Server lists and thumbnails
description: Publish discovery lists, provide server images, and inspect live status.
---

Players can save server addresses themselves, discover LAN hosts, or browse configured lists. Public discovery is optional: hosting a game does not automatically register it in a public directory.

## Provide a server list

An app server-list source returns an object with a `servers` array. Add its URL under **Settings → Server lists**. For the web directory, local entries live in `servers/src/data/servers.json` as an array; remote sources use the same object shape shown below.

```json
{
  "servers": [
    {
      "address": "play.example.com:28006",
      "secure": true,
      "highlighted": false
    }
  ]
}
```

Use a host and optional port in `address`, without `https://` or `wss://`. Set `secure` to `true` for TLS; it defaults to secure when omitted. The standard port is `28006`. Listing a server does not change the server's own bind address or authentication origin.

The web directory in the repository can combine local entries with comma-separated `REMOTE_URLS` sources. `USE_REMOTE_URLS_STATUS` chooses whether it uses status supplied by remote lists instead of probing each remote server. See the [directory source](https://github.com/LinwoodDev/Setonix/tree/develop/servers) for deployment configuration.

## Supply a thumbnail

Set `thumbnail` in the game server's `config.json`, or pass `--thumbnail path/to/image.png`. Relative paths resolve from the server directory. Supported server images are PNG, JPEG, and WebP, up to 512 KiB.

A web-directory list entry can override that live image:

```json
{
  "address": "play.example.com:28006",
  "secure": true,
  "thumbnail": "/thumbnails/my-table.webp"
}
```

For a bundled web-directory image, put the file under `servers/public/thumbnails/`. The override may also be an external image URL. When the directory has an override, it does not request the live thumbnail from the game server.

## Live status requests

The server exposes discovery information over HTTP or HTTPS on its WebSocket port. Send `X-Setonix-Method: info` for its description, capacity, player count, pack signatures, thumbnail availability, and protocol capabilities. Use `X-Setonix-Method: thumbnail` for the configured image.

```sh
curl -H 'X-Setonix-Method: info' http://127.0.0.1:28006
```

These endpoints describe a server; joining still uses the Setonix client and protocol negotiation. For connection problems, see [troubleshooting](/docs/v1/troubleshooting/).
