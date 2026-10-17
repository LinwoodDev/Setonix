---
title: Accounts and backups
description: Manage local multiplayer identities and encrypted private-key backups.
---

Accounts are local public-key identities used to authenticate to multiplayer servers. They are not needed for offline play. A server recognizes an account by its public-key fingerprint, so using the same display name does not recreate the same identity.

## Create and use an account

Open **Accounts** from the profile control on the home screen and choose **Create**. Give the identity a name. When a server requests authentication, select that account. If the server requires registration through an external service, follow its supplied account-linking instructions.

Accounts remain on the device until exported. To use the same identity on another device, import its backup there.

## Back up your keys

Use **Backup key** for an individual account or **Backup all keys** for every account. Enter and confirm a backup passphrase, then save the exported `.stnx` file.

Backups contain private keys and are encrypted with the passphrase. Keep the backup and passphrase safe: the passphrase cannot be recovered. A normal game export or data-directory world export is not an account backup.

## Restore accounts

Choose **Import accounts** or import the account backup file, confirm the import, and enter its passphrase. Setonix validates the imported key pairs. If a backup cannot be opened, check the passphrase and that the file is a complete account export.

## Server identity checks

Public account authentication requires an encrypted connection. Setonix accepts WSS, local loopback WebSockets for development, and secure end-to-end encrypted Swamp rooms. Challenges are short-lived and bound to the server origin and connection.

If the app reports an **authentication origin mismatch**, reconnect using the address supplied by the server owner. Operators should check [secure server setup](/docs/v1/server/#secure-server-setup).
