import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/services/file_system.dart';

import '../../bloc/settings.dart';

class AccountsSettingsPage extends StatefulWidget {
  final bool inView;
  const AccountsSettingsPage({super.key, this.inView = false});

  @override
  State<AccountsSettingsPage> createState() => _AccountsSettingsPageState();
}

class _AccountsSettingsPageState extends State<AccountsSettingsPage> {
  late final KeyFileSystem _privateKeyFileSystem, _publicKeyFileSystem;
  Future<List<String>>? _keysFuture;
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
    _keysFuture = _privateKeyFileSystem.getKeys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
        inView: widget.inView,
        backgroundColor: widget.inView ? Colors.transparent : null,
        title: Text(AppLocalizations.of(context).accounts),
      ),
      body: FutureBuilder<List<String>>(
        future: _keysFuture,
        builder: (context, state) {
          final keys = state.data ?? <String>[];
          return ListView.builder(
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final key = keys[index];
              return Dismissible(
                key: Key(key),
                child: ListTile(
                  title: Text(key.substring(1)),
                ),
                onDismissed: (direction) {
                  _privateKeyFileSystem.deleteFile(key);
                  _publicKeyFileSystem.deleteFile(key);
                  setState(() {
                    keys.removeAt(index);
                  });
                },
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
