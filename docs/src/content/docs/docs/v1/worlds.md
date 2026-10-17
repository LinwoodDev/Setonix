---
title: Games and templates
description: Create, resume, share, and back up worlds and reusable templates.
---

A game, also called a world, stores tables, placed objects, teams, notes, waypoints, the selected mode, and persistent script state. Packs supply the definitions and artwork those objects use.

## Create and resume games

Open **Games** on the home screen. Select a game mode to see its saved games, or **Sandbox** for sandbox games. Use the home screen’s **Create** action for the full mode/template picker under **Start** and pack/background selection under **Custom**. **Create** within a mode group starts from that mode. Enter a name and optional description, then create the game.

To continue, select a saved game to play. **Recent games** on the home screen provides shortcuts to games you have opened. Use the pencil beside the game's information in the game menu to change its name and description.

## Save, export, and import

Local changes are saved automatically. Return to **Home** through the game menu when you finish a session. A multiplayer server controls its own saves; joining one does not make its world a local game automatically.

Use a saved game's menu in **Games** to **Export** a `.stnx` file or **Delete** the game. Import a shared file with the import control and check the confirmation: Setonix distinguishes games, packs, templates, and account backups by their metadata, even though they share the `.stnx` extension.

Export important games before deleting them, changing devices, or clearing browser data. Native installations can also export saved worlds together from **Settings → Data → Export**. [Account backups](/docs/v1/accounts/) are separate and need a passphrase.

## Reuse a setup as a template

1. Prepare a local table with the pieces and notes you want to reuse.
2. Open **Game menu → Advanced options → Save as template**.
3. Give the template a name and save it.
4. When creating another game, select that template under **Start**.

Creating from a template copies its setup into a new game. Later changes to that game do not edit the template. Templates can be imported from `.stnx` files; the creation dialog also lets you delete saved templates.

## Game modes

A mode supplies starting tables and teams and may run a Luau script. The core pack provides **Chess**, a prepared sandbox setup, and [**Blackjack**](/docs/v1/blackjack/), which automates the round. Installed packs can add more modes.

Luau runs locally on native platforms and in web builds that include the browser runtime. In multiplayer, scripts run on the host or dedicated server. A script can restrict editing, set table bounds, publish notes, and supply toolbar actions.

For your own modes, see [pack modes and scripts](/docs/v1/packs/modes/) and the [Luau API](/docs/v1/scripting/luau/).
