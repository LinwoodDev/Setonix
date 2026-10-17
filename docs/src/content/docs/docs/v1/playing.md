---
title: Playing at the table
description: Navigate the board, place pieces, handle cards, roll dice, and arrange cells.
---

## Move around

Drag an empty part of the table to pan. Pinch to zoom on touch devices, or open **Game menu → Zoom** to set the zoom level. Mouse scrolling moves the camera; hold **Left Shift** to swap the scroll axes. Adjust scrolling under **Settings → Inputs**.

| Key | Action while the board has focus |
| --- | --- |
| **W / A / S / D** | Move the camera |
| **Tab** | Show or hide the library/hand view |
| **Escape** | Close the hand view, or open the game menu |
| **T** | Open chat |
| **Left / Right arrow** | Scroll through the hand view when it is open |

A restricted table keeps the camera inside its playing area. See [tables and waypoints](/docs/v1/tables/).

## Add decks, figures, and boards

Open the library with **+** or **Tab**. Search by name or asset identifier and use **Show duplicates** to include repeated entries from packs.

- **Decks** are arrangements of figures and boards. Drag one onto the table to place the whole arrangement. Select a deck in the library to browse its figures.
- **Figures** include cards, chips, dice, and chess pieces. Drag a figure or variation onto a cell to create an object.
- **Boards** place a tiled playing surface across several cells.

If something is missing, check that its pack is installed and enabled in the world. The core pack supplies the standard pieces; [custom packs](/docs/v1/packs/overview/) add more.

## Move and inspect objects

Select a cell to show its objects in the hand view. Drag an item from that view onto another cell to move it. Creating a figure from the library makes a new object; moving an existing object transfers that object.

**Game menu → Switch cell on move** makes the destination cell become selected after a move. Turn it off to keep working from the original cell.

Right-click a cell or object, or long-press on touch devices, to open its context menu. An object's menu offers **Toggle hide**, **Remove**, and **Roll** when its figure is rollable. A cell's menu can act on the whole cell:

| Action | Effect |
| --- | --- |
| Toggle hide | Toggle whether objects show their face or back |
| Shuffle | Randomize the order of objects in the cell |
| Roll | Choose new variations for rollable figures in the cell |
| Remove | Remove the cell's objects |
| Merge | Configure how the cell's objects use neighboring space |
| Add waypoint | Bookmark this position |
| Teams | Assign the cell to teams for private visibility |

Hiding a face is different from making a cell private. Use [teams and visibility](/docs/v1/teams/) for private hands. Game modes and server roles may reject actions that their rules do not allow.

## Arrange a hand or stack

Open a cell's **Merge** dialog to choose a layout:

- **None** uses the normal cell layout.
- **Stacked** overlaps cards. **Visible percentage** controls how much of each card is exposed.
- **Distribute** spreads cards across the available area. **Max cards** controls the layout's card count, and **Fill variable space** changes how it uses spare space.

Set **Span** to reserve neighboring cells, choose **Horizontal** or **Vertical**, and use **Reverse** to reverse the display order. The dialog offers spans from 1 to 10 cells. A layout cannot extend outside a restricted table. Change the layout back to **None** to return to an ordinary cell.

The **Stacked cards** option in personalization changes the hand view's presentation; cell merge settings change the layout on the shared table.
