---
title: Roles, permissions, and bans
description: Configure multiple server roles, moderation hierarchy, and registered-user access.
---

## Built-in roles

| Role ID | Priority | Permissions |
| --- | --- | --- |
| `spectator` | 0 | None |
| `player` | 0 | `play` |
| `moderator` | 50 | `play`, `manageWorld`, `kickPlayers`, `banPlayers` |
| `owner` | 100 | All five built-in permissions |

Accounts can have multiple roles. Effective permissions are the union of their role permissions, and hierarchy uses the highest assigned priority. The default `player` role is always retained. Adding `spectator` alone therefore does not remove the `play` permission granted by `player`.

## Permissions

| Permission | Purpose |
| --- | --- |
| `play` | Board interactions and ordinary game requests |
| `manageWorld` | Packs, modes, metadata, backgrounds, teams, table administration, and game-role changes |
| `kickPlayers` | Disconnect other players |
| `banPlayers` | Add and remove persistent bans |
| `manageRoles` | Change server-role assignments |

Authentication, chat, image requests, dialog responses, and permitted player-name requests have their own handling rather than requiring `play`. Modes may impose additional rules beyond these server permissions.

A client managing another user's server roles must outrank that user. It cannot assign a role above its own priority. Moderation also checks authority and target rules. The server console is the operator's administration interface.

## Bootstrap an administrator

Let the user connect and authenticate, then run:

```text
players
role add @Alex owner
```

Use `role list @Alex` to check the result. Users with appropriate permissions also get moderation and role controls in the in-game multiplayer panel.

## Customize definitions

Use the `roles` [console commands](/docs/v1/server/commands/#define-server-roles) or edit `serverRoles` in `config.json` while the server is stopped. For example, this map adds a referee alongside the mandatory player role:

```json
{
  "player": {
    "name": "Player",
    "priority": 0,
    "permissions": ["play"]
  },
  "referee": {
    "name": "Referee",
    "priority": 25,
    "permissions": ["play", "manageWorld"]
  }
}
```

This is the value of `serverRoles`, not a complete configuration file. Include every role you want to retain. `roles create referee 25 Referee`, followed by `roles permission add referee manageWorld`, is an alternative that preserves existing definitions.

Custom role and permission IDs can use `namespace:key` to avoid collisions. Built-in IDs are unqualified and resolve against the core pack for labels. A custom permission string must be checked by your custom server logic; adding it to a role does not create a game action by itself.

## Bans and whitelisting

A **kick** ends a connection. A **ban** records the account fingerprint and may be permanent or have an expiry time and reason. The multiplayer panel offers permanent, one-hour, one-day, and seven-day bans; the console accepts durations in minutes. Use the **Banned users** list or `bans`/`unban` to review and revoke them.

Enable `whitelistEnabled` to restrict admission to registered users whose whitelist flag is set. Add existing registered users with `whitelist add <User>`. Local registration data, roles, and bans are stored in `setonix.db` unless a remote user service is configured.

Teams control private cells and cooperative play; game roles are values used by a particular mode. Neither automatically grants server permissions. See [teams](/docs/v1/teams/) and [multiplayer](/docs/v1/multiplayer/).
