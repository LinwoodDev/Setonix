---
title: Boards and backgrounds
description: Create tiled playing boards and table backgrounds from your artwork.
---

## Boards

A board in `boards/<id>.json` maps an image region to a grid of tiles:

```json title="boards/board.json"
{
  "texture": "boards/board.png",
  "offset": [0, 0],
  "size": [256, 256],
  "tiles": [8, 8]
}
```

`texture`, `offset`, and `size` describe the image region in pixels. `tiles` describes the number of table cells across and down, defaulting to `[1, 1]`. In this example, each of the eight-by-eight tiles uses a 32-by-32 part of the image.

Place a board from the library, include it in a [deck](/docs/v1/packs/decks/), or define its tiles in a [mode's starting table](/docs/v1/packs/modes/). Board artwork does not set legal moves or limit the camera; table bounds are configured separately.

## Backgrounds

A background in `backgrounds/<id>.json` supplies a repeating table surface:

```json title="backgrounds/felt.json"
{
  "texture": "backgrounds/felt.png",
  "offset": [0, 0],
  "priority": 0
}
```

Backgrounds use the same texture-region fields. `priority` defaults to `0` and controls drawing order. Select a background when creating a custom game or from the in-game Table controls. A mode can also set a background reference for each starting table.

Keep artwork under `textures/`, and use paths relative to that folder. A background is a surface; a board is a tiled object arrangement on that surface.
