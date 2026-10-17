---
title: Server commands
description: Reference for every dedicated-server console command.
---

Enter these commands in the server terminal, without a slash. Square brackets indicate optional arguments; angle brackets indicate values to replace. In-game `/commands` are registered by game modes and are separate.

## Inspect and control the server

| Command | Effect |
| --- | --- |
| `worlds` | List loaded worlds, players, and modes |
| `packs` | List loaded pack namespaces and archive checksums |
| `modes` | List available game mode identifiers |
| `scripts [World]` | List loaded plugins/scripts for a world; defaults to the default world |
| `players [World]` | List connected users, optionally filtered by world |
| `save [World]` | Force-save one world, or all worlds if omitted |
| `say <Message...>` | Send a server message |
| `reset [World] [Mode\|sandbox]` | Replace a world's setup; defaults to the default world and sandbox |
| `stop` | Close connections, save, and stop the server |

`reset` discards the current setup. Keep a backup before using it. Supply the world first, even when you only want to select a mode; use `worlds` and `modes` to find valid names.

## Manage players

User references support `#ID` for a connected channel, `@Name` for a display name, and `*Fingerprint` for a registered identity. Use `players` to inspect them. Persistent actions such as bans and whitelisting require a registered fingerprint.

| Command | Effect |
| --- | --- |
| `name <User> <Name...>` | Rename a connected user; name must be non-empty, unique, and at most 256 characters |
| `kick <User> [Reason] [Link]` | Disconnect a player, optionally with a reason and link |
| `ban <User> [Minutes] [Reason...]` | Persist a ban, optionally expiring after a duration |
| `unban <User>` | Remove a persistent ban |
| `bans` | List active bans with expiry and reason |
| `whitelist add <User>` | Add a registered user to the whitelist |
| `whitelist remove <User>` | Remove a registered user from the whitelist |

A ban without a numeric duration is permanent. Whitelist entries affect admission only when `whitelistEnabled` is enabled.

```text
players
role add @Alex owner
ban @Alex 60 Repeated disruption
unban @Alex
```

## Assign user roles

| Command | Effect |
| --- | --- |
| `role list <User>` | Show assigned roles |
| `role add <User> <Roles...>` | Add roles |
| `role remove <User> <Roles...>` | Remove roles other than the mandatory default role |
| `role set <User> <Roles...>` | Replace the assigned set, retaining the default role |
| `role <User> <Roles...>` | Shorthand for `role set` |

Supply role IDs separated by spaces. Roles must exist. Every registered user's role set includes `player`.

## Define server roles

```text
roles list
roles show <Role>
roles create <Role> <Priority> <Display name...>
roles delete <Role> [Replacement]
roles rename <Role> <Display name...>
roles priority <Role> <Priority>
roles permission add <Role> <Permission>
roles permission remove <Role> <Permission>
```

Role-definition changes are written to `config.json`. Deleting a role replaces its assignments for connected users with the named replacement, or `player` by default. The default `player` role cannot be deleted. See [permissions](/docs/v1/server/permissions/) for the available permissions and hierarchy.
