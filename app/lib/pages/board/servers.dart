import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/models/info.dart';

const ServersInfo serversInfo = ServersInfo(
  official: [
    ServerInfo(
      name: 'Official Server',
      description: 'The official Qeck server',
      address: 'qeck.linwood.dev',
    ),
  ],
  community: [
    ServerInfo(
      name: 'Community Server',
      description: 'The community Qeck server',
      address: 'qeck.linwood.dev',
    ),
  ],
);

class GameServersDialog extends StatefulWidget {
  const GameServersDialog({super.key});

  @override
  State<GameServersDialog> createState() => _GameServersDialogState();
}

enum _ServerType { official, community }

class _GameServersDialogState extends State<GameServersDialog> {
  Set<_ServerType> _selected = _ServerType.values.toSet();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: Text(AppLocalizations.of(context).servers)),
              IconButton(
                icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          SegmentedButton(
            segments: _ServerType.values
                .map(
                  (type) => ButtonSegment(
                    label: Text(switch (type) {
                      _ServerType.official =>
                        AppLocalizations.of(context).official,
                      _ServerType.community =>
                        AppLocalizations.of(context).community,
                    }),
                    value: type,
                  ),
                )
                .toList(),
            selected: _selected,
            multiSelectionEnabled: true,
            emptySelectionAllowed: true,
            onSelectionChanged: (value) => setState(() => _selected = value),
          ),
        ],
      ),
      scrollable: true,
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selected.contains(_ServerType.official))
              for (final server in serversInfo.official)
                ListTile(
                  title: Text(server.name),
                  subtitle: Text(server.description),
                  onTap: () {
                    Navigator.of(context).pop(server);
                  },
                ),
            if (_selected.contains(_ServerType.community))
              for (final server in serversInfo.community)
                ListTile(
                  title: Text(server.name),
                  subtitle: Text(server.description),
                  onTap: () {
                    Navigator.of(context).pop(server);
                  },
                ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).close),
        ),
      ],
    );
  }
}
