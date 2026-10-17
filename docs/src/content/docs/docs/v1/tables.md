---
title: Tables and waypoints
description: Organize a world into tables, set playing bounds, and bookmark locations.
---

## Tables

A world can contain several tables. Each table has its own cells, objects, background, and optional bounds. Open **Game menu → Table → Switch table** to enter a table name, or choose a listed table. The empty internal name identifies the **Default table**.

Use the Table controls to change the background or edit the current table's bounds. Modes can also supply multiple starting tables; see [mode definitions](/docs/v1/packs/modes/).

## Restrict a playing area

Open the edit control in **Game menu → Table** and set **Minimum cell** and **Maximum cell** to integer coordinates. Both corners are required for a restriction. The rectangle includes both corners; reversed corners are accepted.

For example, `(0, 0)` through `(7, 7)` describes an eight-by-eight area. Restrictions limit grid rendering, camera movement, object placement and moves, and cell layout spans. Remove both bounds to return to an unrestricted sandbox.

Bounds are saved with the world. A game mode can set and restore them itself; Blackjack uses bounds to keep the view around its playing area. On a server, changing the world's configuration requires the appropriate permissions.

## Waypoints

Waypoints bookmark table coordinates, so players can return to a hand, a score area, or another part of a large world.

1. Open a cell's context menu and select **Add waypoint**.
2. Give the waypoint a name, check its table and position, and choose **Public** or a team.
3. Open **Game menu → Waypoints** and select an entry to move the camera there.

Use a waypoint's edit or delete control to maintain the list. Public waypoints belong to the world; team waypoints are associated with that team. A waypoint changes your view, not the positions of pieces.

See [teams and visibility](/docs/v1/teams/) for private playing areas.
