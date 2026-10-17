---
title: Pack editor
description: Build custom content in Setonix and install or share your finished pack.
---

## Create an editable pack

Open **Library → Editor → Add** on the home screen. Create a blank pack, copy an installed pack, or import an archive into the editor. Select the editable pack to open it. Installed packs and editor copies are separate: edits are saved to the editor copy.

## Work through the editor

| Section | What to edit |
| --- | --- |
| General | Name, author, version, and description |
| Textures | Import artwork and choose image regions |
| Figures | Card backs, named variations, categories, and the rollable flag |
| Boards | Texture region and tile dimensions |
| Decks | Figures, variations, boards, and their starting positions |
| Backgrounds | A table surface's texture region |
| Scripts | Create and edit Luau source |
| Game Modes | Choose a script and configure starting teams, tables, backgrounds, and bounds |

Changes are saved to the editable pack as you work. Dialogs have their own **Save** controls. Deleting a definition does not automatically repair references from other definitions.

The **Translations** destination is currently a placeholder. Author `translations/<locale>.json` in an unpacked archive for localized names; see the [translation format](/docs/v1/packs/translations/).

## Install and export

Return to **Library → Editor** and open the pack's context menu. **Install** adds the current archive to installed packs; **Export** writes a shareable `.stnx` file. To use the content, enable the installed pack in a new or existing world.

After changing an editable pack, install the new revision and update the world's pack selection. The old installation has a different identifier. Export the final archive once and share that exact file with other players.

## Check the result

Create a temporary Custom game with your pack enabled. Place every deck and board, inspect figure variations and backs, roll dice, and start each mode. For scripted modes, also save, leave, and reopen the game to check persistent state. Follow the [format reference](/docs/v1/packs/overview/) when an asset does not load.
