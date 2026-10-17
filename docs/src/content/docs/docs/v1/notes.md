---
title: Notes, chat, and dialogs
description: Write rules, follow live game notes, chat with players, and use mode actions.
---

## Read and manage notes

Open **Notes** from the game toolbar. On wide screens, the reader stays beside the board. On small screens, notes appear in a persistent bottom sheet; tap or swipe its handle to expand it. Turn **Notes** off to remove the reader.

Use **Manage notes** to create a named note, edit its Markdown content, rename it, or delete it. Set a note as the **Home page** to make it the world's starting note. Notes belong to the world and survive saving and reopening.

Modes can publish notes and update them as play progresses. Blackjack's note shows turns, scores, rules, and round controls. Editing can be disabled by the mode or your server permissions.

## Format a note

Notes support Markdown, including headings, emphasis, lists, and links. Link to another note with the `note:` scheme, and encode spaces in note names as `%20`:

```markdown
# Rules

Draw one card, then end your turn.

[Scoring](note:Scoring)
[Round history](note:Round%20history)
```

A missing target produces a note-not-found message. Keep links in sync when renaming notes.

## Action buttons in notes

A mode can use an `action:` link to render a game action button:

```markdown
[Hit](action:blackjack_hit)
[Stand](action:blackjack_stand)
```

The ID must match an enabled action in the player's current toolbar. Missing or disabled actions appear disabled; writing an action link alone does not grant permission or create a new command. Script authors can publish notes and toolbars through the [Luau API](/docs/v1/scripting/luau/).

## Chat

Open **Chat** from the toolbar or press **T** while the board has focus. Enter a message and send it to the world. Messages show their author, and the app indicates new messages while chat is closed.

Modes may register `/command` and `!command` handlers. For example, Blackjack accepts `/deal`, `/hit`, `/stand`, `/scores`, and `/help`. Available commands depend on the mode. Dedicated-server console commands are entered in the server's terminal.

## Server dialogs

Hosts and scripts can display dialogs containing text, images, links, text fields, checkboxes, and dropdowns, with action buttons. Responses are sent back to the host. These dialogs are server-provided content; only submit information you intend to share with that server.
