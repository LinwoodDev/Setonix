---
title: Decks
description: Group figures and boards into arrangements players can place together.
---

A deck in `decks/<id>.json` is an arrangement of figures and boards. It can be a stack of playing cards, a collection of chips, or a complete board setup.

```json title="decks/starter.json"
{
  "figures": [
    { "name": "token", "variation": "front", "position": [0, 0] },
    { "name": "token", "variation": "front", "position": [1, 0] }
  ],
  "boards": [
    { "name": "board", "position": [0, 1] }
  ]
}
```

| Entry | Fields |
| --- | --- |
| Figure | Required `name`, optional `variation`, optional `position` |
| Board | Required `name`, optional `position` |

Both lists default to empty. Positions default to `[0, 0]` and are cell offsets from the drop location. Repeated figure entries at the same position create a stack; different positions spread the pieces across the table. A figure's variation must match a key in its definition.

Use local figure and board IDs from the containing pack. For the example above, provide `figures/token.json` and `boards/board.json`.

Dragging the deck from the library spawns its arrangement. Selecting it opens its figures for individual placement. A deck is not a script and does not enforce game rules. Use a [game mode](/docs/v1/packs/modes/) when turns or scoring should be automated.

The core pack includes standard Poker, Full, Skat, Doppelkopf, chips, dice, and chess arrangements. Localized labels belong under `decks` in the [translation file](/docs/v1/packs/translations/).
