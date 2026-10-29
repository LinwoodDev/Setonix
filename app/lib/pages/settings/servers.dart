import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/settings.dart';

Uri? _parseServerListUrl(String value) {
  var address = value.trim();
  if (address.isEmpty || RegExp(r'\s').hasMatch(address)) return null;
  if (address.startsWith('//')) address = 'https:$address';
  var uri = Uri.tryParse(address);
  if (uri == null) return null;
  if (!uri.hasScheme || RegExp(r'^[^/?#:]+:\d+(?:[/?#]|$)').hasMatch(address)) {
    uri = Uri.tryParse('https://$address');
  }
  if (uri == null ||
      !uri.hasAuthority ||
      uri.host.isEmpty ||
      (uri.scheme != 'http' && uri.scheme != 'https')) {
    return null;
  }
  return uri;
}

class ServersSettingsPage extends StatelessWidget {
  final bool inView;
  const ServersSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
        inView: inView,
        backgroundColor: inView ? Colors.transparent : null,
        title: Text(AppLocalizations.of(context).serverLists),
        actions: [
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.clockCounterClockwise),
            tooltip: AppLocalizations.of(context).loadDefaultServerList,
            onPressed: () async {
              final settingsCubit = context.read<SettingsCubit>();
              showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    AppLocalizations.of(context).loadDefaultServerList,
                  ),
                  content: Text(
                    AppLocalizations.of(context)
                        .loadDefaultServerListDescription,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(AppLocalizations.of(context).cancel),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        settingsCubit.addServersToList(
                          getDefaultServerList(),
                          true,
                        );
                        Navigator.of(context).pop(true);
                      },
                      child: Text(AppLocalizations.of(context).reset),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        settingsCubit.addServersToList(getDefaultServerList());
                        Navigator.of(context).pop(true);
                      },
                      child: Text(AppLocalizations.of(context).confirm),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<SettingsCubit, SetonixSettings>(
        buildWhen: (previous, current) =>
            previous.serverList != current.serverList,
        builder: (context, state) {
          final servers = state.serverList;
          if (servers.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context).noServerLists,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
          return ListView.builder(
            itemCount: servers.length,
            itemBuilder: (context, index) {
              final server = servers[index];

              void deleteServer() =>
                  context.read<SettingsCubit>().removeServerFromList(server);

              return Dismissible(
                key: Key(server),
                child: ContextRegion(
                  builder: (context, button, controller) =>
                      ListTile(title: Text(server), trailing: button),
                  menuChildren: [
                    MenuItemButton(
                      leadingIcon: const PhosphorIcon(PhosphorIconsLight.trash),
                      onPressed: deleteServer,
                      child: Text(AppLocalizations.of(context).delete),
                    ),
                  ],
                ),
                onDismissed: (direction) => deleteServer(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final settingsCubit = context.read<SettingsCubit>();
          final address = await showDialog<String>(
            context: context,
            builder: (context) => NameDialog(
              title: AppLocalizations.of(context).addServerList,
              hint: 'https://example.com/servers.json',
              button: AppLocalizations.of(context).add,
              validator: (_) =>
                  (value) => _parseServerListUrl(value ?? '') == null
                  ? AppLocalizations.of(context).invalidServerListUrl
                  : null,
            ),
          );
          if (address == null) return;
          final uri = _parseServerListUrl(address);
          if (uri == null) return;
          await settingsCubit.addServerToList(uri.toString());
        },
        label: Text(AppLocalizations.of(context).add),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }
}
