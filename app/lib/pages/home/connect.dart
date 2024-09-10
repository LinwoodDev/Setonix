import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/bloc/settings.dart';
import 'package:quokka/widgets/search.dart';
import 'package:quokka_api/quokka_api.dart';

class ConnectEditDialog extends StatelessWidget {
  final ListGameServer? initialValue;
  final int? index;

  const ConnectEditDialog({
    super.key,
    this.initialValue,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    String address = initialValue?.address ?? '';
    String name = initialValue?.name ?? '';
    bool secure = initialValue?.secure ?? true;
    void connect() {
      Navigator.of(context).pop();
      GoRouter.of(context).goNamed('connect', queryParameters: {
        'address': address,
        'secure': secure.toString(),
      });
    }

    final secureSwitchEnabled = !kIsWeb || Uri.base.isScheme('HTTP');

    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).connect),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
      ),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context).connectNote),
          const SizedBox(height: 16),
          if (index != null) ...[
            TextFormField(
              initialValue: name,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name,
                filled: true,
              ),
              onChanged: (value) => name = value,
            ),
            const SizedBox(height: 8),
          ],
          TextFormField(
            initialValue: address,
            onChanged: (value) => address = value,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).address,
              filled: true,
            ),
            onFieldSubmitted: index == null ? (_) => connect() : null,
          ),
          const SizedBox(height: 8),
          if (secureSwitchEnabled)
            StatefulBuilder(
              builder: (context, setState) => SwitchListTile(
                title: Text(AppLocalizations.of(context).secure),
                value: secure,
                onChanged: (value) => setState(() => secure = value),
              ),
            ),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            final cubit = context.read<SettingsCubit>();
            var updated = initialValue ?? ListGameServer(address: '');
            updated = updated.copyWith(
              address: address,
              secure: secure,
              name: name,
            );
            if (index != null) {
              cubit.updateServer(index!, updated);
            } else {
              cubit.addServer(updated);
            }
            Navigator.of(context).pop();
          },
          label: Text(AppLocalizations.of(context).save),
          icon: const Icon(PhosphorIconsLight.floppyDisk),
        ),
        if (index == null)
          FilledButton.icon(
            onPressed: connect,
            label: Text(AppLocalizations.of(context).connect),
            icon: const Icon(PhosphorIconsLight.link),
          ),
      ],
    );
  }
}

class ServersDialog extends StatefulWidget {
  const ServersDialog({super.key});

  @override
  State<ServersDialog> createState() => _ServersDialogState();
}

class _ServersDialogState extends State<ServersDialog> {
  bool _isMobileOpen = false;
  int? _selected;

  String _search = '';

  _buildDetailsChildren(GameServer server) => [
        const ListTile(
          title: Text('Description'),
          subtitle: Text(
            '''Labore commodo amet nisi ad ad aliquip minim. Do minim eiusmod sunt pariatur ullamco mollit nulla consequat enim Lorem deserunt amet. Velit cupidatat officia elit consectetur cillum culpa sunt pariatur magna cupidatat culpa. Occaecat ad mollit qui laboris do nostrud.
      
      Ad id adipisicing sunt laboris mollit deserunt id adipisicing culpa. Consequat amet ea velit culpa quis nostrud ullamco ipsum aliquip nostrud labore ipsum irure. Proident aliquip nulla labore aliquip tempor minim velit excepteur ipsum incididunt. Dolore tempor officia voluptate ipsum. Et occaecat deserunt sint id incididunt nisi duis commodo elit pariatur magna voluptate. Id incididunt minim consequat irure laboris culpa laborum ipsum. Dolor fugiat laborum dolor sint adipisicing fugiat.
      
      Lorem ullamco laboris do proident occaecat mollit aliquip minim. Do irure consectetur ut do laborum deserunt aliquip dolore consectetur eu. Cupidatat consequat ea occaecat reprehenderit minim voluptate fugiat cillum do labore in. Ullamco eiusmod occaecat eu voluptate elit cupidatat non proident. Reprehenderit Lorem elit est commodo in duis Lorem sunt esse.
      
      Nisi sunt irure consectetur officia occaecat. Elit do consequat sit laboris laboris sunt est ex. Amet laboris aliqua nisi anim incididunt pariatur ex. Duis eiusmod Lorem aliqua minim eiusmod laborum sit nulla. Officia eu cupidatat veniam ad mollit sint consectetur laboris elit ipsum. Laborum officia non in aute ut voluptate Lorem culpa id labore qui ea minim ex.''',
          ),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, QuokkaSettings>(
        buildWhen: (previous, current) =>
            previous.showConnectYour != current.showConnectYour ||
            previous.showConnectNetwork != current.showConnectNetwork ||
            previous.servers != current.servers,
        builder: (context, settings) {
          final servers = settings.servers
              .where((server) => server.display.toLowerCase().contains(_search))
              .toList();
          final isMobile =
              MediaQuery.sizeOf(context).width < LeapBreakpoints.medium;
          final server = _selected == null
              ? ListGameServer(address: '')
              : settings.servers[_selected!];
          final playButton = SizedBox(
            height: 48,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(PhosphorIconsLight.play),
                    label: Text(AppLocalizations.of(context).play),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    IconButton.outlined(
                      icon: const Icon(PhosphorIconsLight.pencil),
                      tooltip: AppLocalizations.of(context).edit,
                      onPressed: () => showDialog<bool>(
                        context: context,
                        builder: (context) => ConnectEditDialog(
                          initialValue: server,
                          index: _selected,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.outlined(
                      icon: const Icon(PhosphorIconsLight.trash),
                      tooltip: AppLocalizations.of(context).delete,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title:
                              Text(AppLocalizations.of(context).deleteServer),
                          content: Text(
                              AppLocalizations.of(context).deleteServerMessage),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(AppLocalizations.of(context).cancel),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_selected != null) {
                                  context
                                      .read<SettingsCubit>()
                                      .removeServer(_selected!);
                                }
                                Navigator.of(context).pop();
                                if (_isMobileOpen) Navigator.of(context).pop();
                                _selected = null;
                              },
                              child: Text(AppLocalizations.of(context).delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
          final listView = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: servers.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(servers[index].display),
                    onTap: () {
                      setState(() {
                        _selected = index;
                        _isMobileOpen = isMobile;
                      });
                      final server = servers[index];
                      if (isMobile) {
                        showLeapBottomSheet(
                          context: context,
                          titleBuilder: (context) => Text(server.display),
                          childrenBuilder: (context) => [
                            ..._buildDetailsChildren(server),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: playButton,
                            ),
                          ],
                        ).then((_) {
                          if (mounted) setState(() => _isMobileOpen = false);
                        });
                      }
                    },
                    selected:
                        _selected == index && (!isMobile || _isMobileOpen),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  icon: const Icon(PhosphorIconsLight.plus),
                  label: Text(AppLocalizations.of(context).create),
                  onPressed: () => showDialog<bool>(
                    context: context,
                    builder: (context) => const ConnectEditDialog(),
                  ),
                ),
              ),
            ],
          );
          final details = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  server.display,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ListView(
                  children: _buildDetailsChildren(server),
                ),
              ),
              const SizedBox(height: 16),
              playButton,
            ],
          );
          return ResponsiveAlertDialog(
            title: Text(AppLocalizations.of(context).connect),
            leading: IconButton.outlined(
              icon: const Icon(PhosphorIconsLight.x),
              onPressed: () => Navigator.of(context).pop(),
            ),
            constraints: const BoxConstraints(
              maxWidth: LeapBreakpoints.expanded,
              maxHeight: 700,
            ),
            content: Column(
              children: [
                RowSearchView(
                    onSearchChanged: (value) => setState(() {
                          _search = value;
                        }),
                    children: const [
                      /*  InputChip(
                        label: Text(AppLocalizations.of(context).yourServers),
                        avatar: const Icon(PhosphorIconsLight.puzzlePiece),
                        showCheckmark: false,
                        selected: settings.showConnectYour,
                        onPressed: () => context
                            .read<SettingsCubit>()
                            .changeShowConnectYour(!settings.showConnectYour),
                      ),
                      InputChip(
                        label: Text(AppLocalizations.of(context).inNetwork),
                        avatar: const Icon(PhosphorIconsLight.globe),
                        showCheckmark: false,
                        selected: settings.showConnectNetwork,
                        onPressed: () => context
                            .read<SettingsCubit>()
                            .changeShowConnectNetwork(
                                !settings.showConnectNetwork),
                      ), */
                    ]),
                const SizedBox(height: 8),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: listView),
                      if (!isMobile) ...[
                        const VerticalDivider(),
                        Expanded(
                            child: _selected == null
                                ? Center(
                                    child: Text(AppLocalizations.of(context)
                                        .selectServer),
                                  )
                                : details),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
