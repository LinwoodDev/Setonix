# Setonix Servers

Public Setonix server directory built with Astro.

## Server list

Local entries live in `src/data/servers.json`. Remote lists can provide the
same server object shape.

```json
[
  {
    "address": "127.0.0.1",
    "secure": false,
    "thumbnail": "/thumbnails/local.webp"
  }
]
```

## Thumbnails

Put bundled server-list thumbnails in `public/thumbnails/`. Files in this
folder are served from `/thumbnails/...`, for example:

```json
{
  "thumbnail": "/thumbnails/my-server.webp"
}
```

The thumbnail field can also be an external URL. If a server-list thumbnail is
set, it overrides the live server thumbnail endpoint and no thumbnail fetch is
made from the Setonix server.

## Commands

| Command | Action |
| :-- | :-- |
| `pnpm dev` | Start local dev server |
| `pnpm build` | Build production server |
| `pnpm preview` | Preview the build |
