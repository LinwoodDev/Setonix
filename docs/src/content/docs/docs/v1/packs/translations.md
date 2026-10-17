---
title: Translations
description: Localize pack items, variations, modes, roles, and permissions.
---

Place locale files in `translations/<locale>.json`, such as `translations/en.json`. Keys refer to definition IDs, not display names:

```json title="translations/en.json"
{
  "figures": {
    "token": {
      "name": "Token",
      "description": "A marker for the board",
      "variations": {
        "front": { "name": "Front" }
      }
    }
  },
  "decks": {
    "starter": { "name": "Starter set", "description": "Two tokens and a board" }
  },
  "boards": {
    "board": { "name": "Playing board" }
  },
  "backgrounds": {
    "felt": { "name": "Felt" }
  },
  "modes": {
    "example": { "name": "Example game", "description": "A custom table" }
  },
  "roles": {
    "referee": { "name": "Referee" }
  },
  "permissions": {
    "manageWorld": { "name": "Manage world" }
  }
}
```

Setonix looks for the selected locale, then falls back to English (`en`). Missing item names fall back to their IDs, or a supplied role/permission name. Include `en.json` so the pack has useful labels even without a matching translation.

Add more locale files with the same stable keys. Translating a label does not rename an asset or change its references. The app's own interface language is separate and is configured in **Settings → Personalization → Locale**.

The editor's Translations destination is currently a placeholder; edit translation JSON in the archive directly.
