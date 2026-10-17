---
title: Figures and textures
description: Define cards, tokens, and dice with image regions and named variations.
---

A figure is a reusable piece definition in `figures/<id>.json`. Objects on the table refer to that figure and optionally one of its variations. A card's variations can be its ranks and suits; a die's variations can be its faces.

## Texture regions

Visual definitions use these fields:

| Field | Meaning |
| --- | --- |
| `texture` | Image path relative to `textures/` |
| `offset` | Top-left pixel coordinate, default `[0, 0]` |
| `size` | Pixel width and height of the region; omit or use `null` for the whole image |

Use sprite sheets to keep several faces in one image. Coordinates are pixels, not board cells. Setonix vectors accept two-integer arrays such as `[32, 0]`; serialized files may use the string form `"(32, 0)"`.

## A two-sided token

This example expects a 64-by-32 image at `textures/figures/token.png`, with two 32-by-32 regions:

```json title="figures/token.json"
{
  "back": {
    "texture": "figures/token.png",
    "offset": [0, 0],
    "size": [32, 32]
  },
  "rollable": true,
  "variations": {
    "front": {
      "texture": "figures/token.png",
      "offset": [32, 0],
      "size": [32, 32],
      "category": "tokens"
    }
  }
}
```

`back` is required. `variations` maps stable IDs to visual definitions; each may have an optional `category`. `rollable` defaults to `false`. When enabled, **Roll** chooses among the named variations. For a useful coin or die, define one variation per possible outcome rather than treating the back as an outcome.

Use **Toggle hide** to show the back. A hidden card and a team-private cell serve different purposes; see [visibility](/docs/v1/teams/).

## Cards and dice

The core pack's `cards.json` supplies playing-card faces and a common back. `d6.json` uses `rollable: true` and six variations named `1` through `6`. You can follow the same pattern for custom dice, character tokens, counters, or alternate card decks.

Give the figure and each variation a localized name in [translations](/docs/v1/packs/translations/), then include them in a [deck](/docs/v1/packs/decks/) to create a convenient starting arrangement.
