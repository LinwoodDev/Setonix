import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/settings.dart';

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
        title: Text(AppLocalizations.of(context).servers),
        actions: [
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.clockCounterClockwise),
            tooltip: AppLocalizations.of(context).loadDefaultServerList,
            onPressed: () async {
              context
                  .read<SettingsCubit>()
                  .addServersToList(kDefaultServerList);
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
                AppLocalizations.of(context).noServers,
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
                  builder: (context, button, controller) => ListTile(
                    title: Text(server),
                    trailing: button,
                  ),
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
          final name = await showDialog(
              context: context, builder: (context) => NameDialog());
          if (name == null) return;
          var uri = Uri.tryParse(name);
          if (uri == null) return;
          if (!uri.hasScheme) {
            uri = uri.replace(scheme: 'https');
          }
          settingsCubit.addServerToList(name);
        },
        label: Text(AppLocalizations.of(context).add),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }
}
