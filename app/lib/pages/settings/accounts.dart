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

import '../../bloc/settings.dart';

class AccountsSettingsPage extends StatefulWidget {
  final bool inView;
  const AccountsSettingsPage({super.key, this.inView = false});

  @override
  State<AccountsSettingsPage> createState() => _AccountsSettingsPageState();
}

class _AccountsSettingsPageState extends State<AccountsSettingsPage> {
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
    return Scaffold(
      backgroundColor: widget.inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
        inView: widget.inView,
        backgroundColor: widget.inView ? Colors.transparent : null,
        title: Text(AppLocalizations.of(context).accounts),
        actions: [
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.arrowSquareIn),
            tooltip: AppLocalizations.of(context).import,
            onPressed: () async {
              await importFile(
                context,
                _fileSystem,
              );
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
      ),
      body: FutureBuilder<List<SetonixAccount>>(
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
            itemBuilder: (context, index) {
              final account = accounts[index];
              final key = account.name;
              final fingerprint = account.getFingerprint(true);
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
                  ),
                  menuChildren: [
                    MenuItemButton(
                      leadingIcon:
                          const PhosphorIcon(PhosphorIconsLight.export),
                      onPressed: () async {
                        final data = await _fileSystem.exportAccounts([key]);
                        if (!context.mounted) return;
                        exportData(context, data, key);
                      },
                      child: Text(AppLocalizations.of(context).backupKey),
                    ),
                    MenuItemButton(
                      leadingIcon: const PhosphorIcon(PhosphorIconsLight.trash),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final name = await showDialog(
              context: context, builder: (context) => NameDialog());
          if (name == null) return;
          await _fileSystem.generateKey(name);
          setState(() {
            _buildKeysFuture();
          });
        },
        label: Text(AppLocalizations.of(context).add),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }
}
