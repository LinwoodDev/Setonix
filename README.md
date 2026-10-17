<div align="center">

<img src="https://raw.githubusercontent.com/LinwoodDev/Setonix/develop/app/images/logo.png" width="350px" />

# Setonix

> WIP: 🃏 Powerful, customizable, cross-platform, opensource table sandbox game 🃏

[![Latest release)](https://img.shields.io/github/v/release/LinwoodDev/Setonix?include_prereleases&color=A28DDB&style=for-the-badge&logo=github&logoColor=A28DDB)](https://github.com/LinwoodDev/Setonix/releases)
[![GitHub License badge](https://img.shields.io/github/license/LinwoodDev/Setonix?color=A28DDB&style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxOTIiIGhlaWdodD0iMTkyIiBmaWxsPSIjQTI4RERCIiB2aWV3Qm94PSIwIDAgMjU2IDI1NiI%2BPHJlY3Qgd2lkdGg9IjI1NiIgaGVpZ2h0PSIyNTYiIGZpbGw9Im5vbmUiPjwvcmVjdD48cmVjdCB4PSIzMiIgeT0iNDgiIHdpZHRoPSIxOTIiIGhlaWdodD0iMTYwIiByeD0iOCIgc3Ryb2tlLXdpZHRoPSIxNiIgc3Ryb2tlPSIjQTI4RERCIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGZpbGw9Im5vbmUiPjwvcmVjdD48bGluZSB4MT0iNzYiIHkxPSI5NiIgeDI9IjE4MCIgeTI9Ijk2IiBmaWxsPSJub25lIiBzdHJva2U9IiNBOThEREIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIxNiI%2BPC9saW5lPjxsaW5lIHgxPSI3NiIgeTE9IjEyOCIgeDI9IjE4MCIgeTI9IjEyOCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjQTI4RERCIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS13aWR0aD0iMTYiPjwvbGluZT48bGluZSB4MT0iNzYiIHkxPSIxNjAiIHgyPSIxODAiIHkyPSIxNjAiIGZpbGw9Im5vbmUiIHN0cm9rZT0iI0EyOEREQiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2Utd2lkdGg9IjE2Ij48L2xpbmU%2BPC9zdmc%2B)](https://github.com/LinwoodDev/Setonix/blob/main/LICENSE)
[![GitHub Repo stars](https://img.shields.io/github/stars/LinwoodDev/Setonix?color=A28DDB&logo=github&logoColor=A28DDB&style=for-the-badge)](https://github.com/LinwoodDev/Setonix)
[![Matrix badge](https://img.shields.io/matrix/linwood:matrix.org?style=for-the-badge&color=A28DDB&logo=matrix&logoColor=A28DDB&label=Matrix)](https://linwood.dev/matrix)
[![Discord badge](https://img.shields.io/discord/735424757142519848?style=for-the-badge&color=A28DDB&logo=discord&logoColor=A28DDB&label=Discord)](https://discord.linwood.dev)
[![Download](https://img.shields.io/github/downloads/LinwoodDev/Setonix/total?color=A28DDB&style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxOTIiIGhlaWdodD0iMTkyIiBmaWxsPSIjQTI4RERCIiB2aWV3Qm94PSIwIDAgMjU2IDI1NiI+PHJlY3Qgd2lkdGg9IjI1NiIgaGVpZ2h0PSIyNTYiIGZpbGw9Im5vbmUiPjwvcmVjdD48cG9seWxpbmUgcG9pbnRzPSI4NiAxMTAuMDExIDEyOCAxNTIgMTcwIDExMC4wMTEiIGZpbGw9Im5vbmUiIHN0cm9rZT0iI0EyOEREQiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2Utd2lkdGg9IjE2Ij48L3BvbHlsaW5lPjxsaW5lIHgxPSIxMjgiIHkxPSI0MCIgeDI9IjEyOCIgeTI9IjE1MS45NzA1NyIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjQTI4RERCIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS13aWR0aD0iMTYiPjwvbGluZT48cGF0aCBkPSJNMjE2LDE1MnY1NmE4LDgsMCwwLDEtOCw4SDQ4YTgsOCwwLDAsMS04LThWMTUyIiBmaWxsPSJub25lIiBzdHJva2U9IiNBOThEREIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIxNiI+PC9wYXRoPjwvc3ZnPg==)](https://setonix.world)
</div>

<p align="center">
    <a href="https://setonix.world"><b>Website</b></a> •
    <a href="https://setonix.world/downloads"><b>Download</b></a> •
    <a href="https://go.linwood.dev/matrix"><b>Matrix</b></a> •
    <a href="https://go.linwood.dev/discord"><b>Discord</b></a> •
    <a href="https://floss.social/@linwood"><b>Mastodon</b></a> •
    <a href="https://bsky.app/profile/linwood.dev"><b>Bluesky</b></a> •
    <a href="CONTRIBUTING.md"><b>Contribute</b></a>
</p>

---

Setonix is a table sandbox game where you can decide how to play. Spawn cards everywhere you like, add optional rules and play with your friends or alone without internet.

**This project is still in development and not ready for production use. Please join the matrix or discord server for updates!**

**Click [here](https://github.com/LinwoodDev/Setonix/discussions/26) to read about the concept and share your thoughts!**

## Features

- **Tabletop sandbox:** Place cards, dice, chips, and boards; move pieces, shuffle stacks, flip cards, and arrange hands with stacked or distributed cell layouts.
- **Games and templates:** Save and resume worlds, import and export `.stnx` files, and reuse a prepared setup as a template.
- **Tables and teams:** Organize multiple tables, restrict playing areas, bookmark waypoints, and use team-private cells for hidden hands.
- **Notes and chat:** Keep Markdown rules and live game actions beside the board, link between notes, and chat with other players.
- **Game modes:** Play a prepared Chess setup or scripted Blackjack with competitive and dealer rules. Add custom Luau rules on native platforms, the web, and dedicated servers.
- **Multiplayer:** Host from a native app through WebSockets or Swamp, join LAN games, or run a dedicated server with roles, moderation, and persistent bans.
- **Local identities:** Authenticate with public-key accounts and move identities between devices using passphrase-encrypted backups.
- **Custom packs:** Create figures, textures, decks, boards, backgrounds, translations, and modes in shareable content packs.
- **Cross platform:** Play on Android, Windows, Linux, macOS, and in the browser, with an iOS preview available.

Read the [getting-started guide](https://setonix.world/docs/v1/intro/), [feature documentation](https://setonix.world/docs/v1/playing/), [pack reference](https://setonix.world/docs/v1/packs/overview/), and [server guide](https://setonix.world/docs/v1/server/).

## Preview limitations

Setonix is still in development. Clients and servers negotiate protocol versions; use compatible builds. Multiplayer hosting from the browser is unavailable, and dedicated-server multi-world routing is incomplete. Some script and save failures still have limited user-facing diagnostics. See [troubleshooting](https://setonix.world/docs/v1/troubleshooting/) for known limitations and recovery steps.

Local games work offline after the app and packs are installed. LAN games can work without internet access; public directories and Swamp services require network access. Browser saves belong to the browser profile, so export important games separately.

---

## Contributing

We are happy to see that you are interested in contributing to Setonix.
To get started, visit [the contributing guide](CONTRIBUTING.md).

## License

The code is open source and licensed under the [AGPL-3.0](./LICENSE) license.
All images in `app/images/`, the core pack in `app/pack` and all images in `docs/` are licensed under the [CC-BY-SA-4.0](./BRANDING_LICENSE) license.
The files in `api` are licensed under the [Apache-2.0](./api/LICENSE) license instead of the AGPL-3.0 license to allow the use of the API without the need to open source the code (for example for extensions or other external services).
The server code in `server` is licensed under the [Apache-2.0](./server/LICENSE) license.
