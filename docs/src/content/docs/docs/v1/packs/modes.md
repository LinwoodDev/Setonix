---
title: Game modes and scripts
description: Bundle starting tables, teams, preview artwork, and Luau rules into a mode.
---

A mode in `modes/<id>.json` is a starting setup. It can provide a static board, as Chess does, or run rules through a script, as Blackjack does.

```json title="modes/example.json"
{
  "script": "example.luau",
  "preview": "textures/games/example.png",
  "tables": {
    "": {
      "background": "core:grid",
      "minCell": [0, 0],
      "maxCell": [7, 7],
      "cells": {
        "(0, 0)": {
          "objects": [
            { "asset": "token", "variation": "front" }
          ]
        }
      }
    }
  },
  "teams": {
    "blue": { "description": "Blue team", "color": "blue" }
  }
}
```

This example expects the token figure, `scripts/example.luau`, and preview artwork to exist in the pack. Remove optional references you do not need.

| Field | Meaning |
| --- | --- |
| `script` | Filename in `scripts/`, including `.lua` or `.luau`; optional |
| `preview` | Image path from the archive root; optional |
| `tables` | Map of table names to table definitions; defaults to `{}` |
| `teams` | Map of team IDs to team definitions; defaults to `{}` |

The empty table name is the default table. Tables may specify `background`, `cells`, and inclusive `minCell`/`maxCell` bounds. Cell keys use coordinate strings. Cells can contain `objects`, board `tiles`, and layout information. See the [core Chess setup](https://github.com/LinwoodDev/Setonix/blob/develop/app/pack/modes/chess.json) for a complete tiled example.

Team colors are `pink`, `red`, `orange`, `yellow`, `green`, `blue`, `indigo`, `purple`, `brown`, `white`, or `black`. Teams can also define claimed cells and waypoints. Players choose their membership during play.

## Attach a script

Creating a script file alone does not run it as a mode. Set the mode's `script` field, or select the script in **Editor → Game Modes → General**. The editor creates `.lua` filenames; packaged modes can also reference `.luau` files.

```lua title="scripts/example.luau"
Setonix.events.on("player_join", function(event)
  event.player:sendMessage("Welcome to the table!")
end)
```

Scripts execute on the local host for singleplayer and app-hosted games, or on the dedicated server for its clients. Native and browser runtimes share the Luau engine and high-level API. Custom web builds must include the [browser runtime](/downloads/selfhosting/).

Use [the Luau guide](/docs/v1/scripting/luau/) for event cancellation, chat commands, toolbar buttons, interactive notes, tables, storage, and raw requests. The [type declarations](https://github.com/LinwoodDev/Setonix/blob/develop/plugin/definitions/setonix.d.luau) provide an API reference for editors.

## Save and close lifecycle

Keep authoritative progress in script state and persist JSON-compatible values with `Setonix.storage`. Use `world_saving` to collect derived values before a save, and `world_closing` to clean up mode-specific state such as temporary bounds. Do not rely on Lua globals alone surviving a restart.

Install the pack, create a game with the mode, exercise its actions, then save and reopen it. The [Blackjack guide](/docs/v1/blackjack/) describes a complete built-in example with persistent rounds.
