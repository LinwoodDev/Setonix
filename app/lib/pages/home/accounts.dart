import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/api/save.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix_api/setonix_api.dart';

class AccountsDialog extends StatefulWidget {
  final bool inView;
  const AccountsDialog({super.key, this.inView = false});

  @override
  State<AccountsDialog> createState() => _AccountsDialogState();
}

class _AccountsDialogState extends State<AccountsDialog> {
  late final KeyFileSystem _privateKeyFileSystem, _publicKeyFileSystem;
  Future<List<SetonixAccount>>? _keysFuture;
  late final SetonixFileSystem _fileSystem;

  @override
  void initState() {
    super.initState();
    _fileSystem = context.read<SetonixFileSystem>();
    _privateKeyFileSystem = _fileSystem.privateKeySystem;
    _publicKeyFileSystem = _fileSystem.publicKeySystem;
    _buildKeysFuture();
  }

  void _buildKeysFuture() {
    _keysFuture = _fileSystem.getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).accounts),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.medium,
        maxHeight: 500,
      ),
      leading: IconButton.outlined(
        onPressed: () => Navigator.of(context).pop(),
        icon: const PhosphorIcon(PhosphorIconsLight.x),
      ),
      headerActions: [
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.arrowSquareIn),
          tooltip: AppLocalizations.of(context).import,
          onPressed: () async {
            await importFile(context, _fileSystem);
            setState(() {
              _buildKeysFuture();
            });
          },
        ),
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.export),
          tooltip: AppLocalizations.of(context).backupAllKeys,
          onPressed: () async {
            final data = await _fileSystem.exportAccounts();
            if (!context.mounted) return;
            exportData(context, data, 'accounts');
          },
        ),
      ],
      content: Stack(
        children: [
          FutureBuilder<List<SetonixAccount>>(
            future: _keysFuture,
            builder: (context, state) {
              if (state.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.hasError) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context).error,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              final accounts = state.data ?? <SetonixAccount>[];
              if (accounts.isEmpty) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context).noAccount,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              return ListView.builder(
                itemCount: accounts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  final key = account.name;
                  final fingerprint = account.getFingerprint(
                    pretty: true,
                    short: true,
                  );
                  void deleteKey() {
                    _privateKeyFileSystem.deleteFile(key);
                    _publicKeyFileSystem.deleteFile(key);
                    setState(() {
                      accounts.removeAt(index);
                    });
                  }

                  return Dismissible(
                    key: Key(key),
                    child: ContextRegion(
                      builder: (context, button, controller) => ListTile(
                        title: Text(key.substring(1)),
                        subtitle: Text(fingerprint),
                        trailing: button,
                        onTap: () =>
                            saveToClipboard(context, account.getFingerprint()),
                      ),
                      menuChildren: [
                        MenuItemButton(
                          leadingIcon: const PhosphorIcon(
                            PhosphorIconsLight.export,
                          ),
                          onPressed: () async {
                            final data = await _fileSystem.exportAccounts([
                              key,
                            ]);
                            if (!context.mounted) return;
                            exportData(context, data, key);
                          },
                          child: Text(AppLocalizations.of(context).backupKey),
                        ),
                        MenuItemButton(
                          leadingIcon: const PhosphorIcon(
                            PhosphorIconsLight.trash,
                          ),
                          onPressed: deleteKey,
                          child: Text(AppLocalizations.of(context).delete),
                        ),
                      ],
                    ),
                    onDismissed: (direction) => deleteKey(),
                  );
                },
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: () async {
                final name = await showDialog(
                  context: context,
                  builder: (context) => NameDialog(),
                );
                if (name == null) return;
                await _fileSystem.generateKey(name);
                setState(() {
                  _buildKeysFuture();
                });
              },
              label: Text(AppLocalizations.of(context).add),
              icon: const PhosphorIcon(PhosphorIconsLight.plus),
            ),
          ),
        ],
      ),
    );
  }
}
