import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/board/game.dart';
import 'package:setonix/pages/game/waypoint.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/settings.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/helpers/visualizer.dart';
import 'package:setonix/pages/game/info.dart';
import 'package:setonix/pages/game/team.dart';
import 'package:setonix/pages/packs/dialog.dart';
import 'package:setonix_api/setonix_api.dart';

class GameMenuDialog extends StatefulWidget {
  final BoardGame game;
  final Future<void> Function() onHome;

  const GameMenuDialog({super.key, required this.game, required this.onHome});

  @override
  State<GameMenuDialog> createState() => _GameMenuDialogState();
}

class _GameMenuDialogState extends State<GameMenuDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Dialog(
      backgroundColor: scheme.surfaceContainerHigh,
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 520,
          maxHeight: MediaQuery.sizeOf(context).height - 64,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            BlocBuilder<WorldBloc, ClientWorldState>(
              buildWhen: (previous, current) =>
                  previous.name != current.name ||
                  previous.metadata != current.metadata,
              builder: (context, state) {
                final metadata = state.metadata;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 12, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              metadata.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (metadata.description.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                metadata.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: AppLocalizations.of(context).editInfo,
                        icon: const Icon(PhosphorIconsLight.pencilSimple),
                        onPressed: () async {
                          final bloc = context.read<WorldBloc>();
                          final newInfo = await showDialog<FileMetadata>(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: bloc,
                              child: EditInfoDialog(value: metadata),
                            ),
                          );
                          if (newInfo == null) return;
                          bloc.process(
                            MetadataChanged(
                              newInfo.copyWith(type: metadata.type),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        tooltip: AppLocalizations.of(context).close,
                        icon: const Icon(PhosphorIconsLight.x),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            BlocBuilder<MultiplayerCubit, MultiplayerState>(
              builder: (context, state) {
                return BlocBuilder<WorldBloc, ClientWorldState>(
                  buildWhen: (previous, current) =>
                      previous.world.serverState != current.world.serverState,
                  builder: (context, worldState) {
                    Future<String> address;
                    final link = worldState.world.serverState.link;
                    if (link != null) {
                      address = Future.value(link);
                    } else if (state is MultiplayerConnectedState) {
                      address = state.getShareAddress().then((value) {
                        return value.toString();
                      });
                    } else {
                      return const SizedBox.shrink();
                    }
                    return FutureBuilder<String>(
                      future: address,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.only(left: 14),
                          decoration: BoxDecoration(
                            color: scheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                PhosphorIconsLight.broadcast,
                                size: 18,
                                color: scheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  snapshot.data!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                              IconButton(
                                tooltip: LeapLocalizations.of(context)
                                    .copyMessage,
                                icon: const Icon(PhosphorIconsLight.copy),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(text: snapshot.data!),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        LeapLocalizations.of(context)
                                            .copyMessage,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FilledButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(PhosphorIconsLight.play),
                  label: Text(
                    MaterialLocalizations.of(context).backButtonTooltip,
                  ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<WorldBloc, ClientWorldState>(
                buildWhen: (previous, current) =>
                    previous.switchCellOnMove != current.switchCellOnMove,
                builder: (context, state) => _TableMenuCard(
                  emphasized: true,
                  child: SwitchListTile(
                    value: state.switchCellOnMove,
                    title: Text(
                      AppLocalizations.of(context).switchCellOnMove,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    secondary: const Icon(PhosphorIconsLight.selectionPlus),
                    onChanged: (value) => context.read<WorldBloc>().process(
                      SwitchCellOnMoveChanged(value),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final buttonWidth = (constraints.maxWidth - 10) / 2;
                    final isClient = context
                        .read<WorldBloc>()
                        .state
                        .multiplayer
                        .isClient;
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _GameMenuOption(
                          width: buttonWidth,
                          icon: PhosphorIconsLight.gridFour,
                          label: AppLocalizations.of(context).table,
                          onPressed: () {
                            final state = context.read<WorldBloc>().state;
                            _showTableDialog(context, state);
                          },
                        ),
                        _GameMenuOption(
                          width: buttonWidth,
                          icon: PhosphorIconsLight.mapPin,
                          label: AppLocalizations.of(context).waypoints,
                          onPressed: () => _showWaypointsDialog(context),
                        ),
                        _GameMenuOption(
                          width: buttonWidth,
                          icon: PhosphorIconsLight.magnifyingGlass,
                          label: AppLocalizations.of(context).zoom,
                          onPressed: () => _showZoomSheet(context),
                        ),
                        _GameMenuOption(
                          width: buttonWidth,
                          icon: PhosphorIconsLight.usersThree,
                          label: AppLocalizations.of(context).teams,
                          onPressed: () => _showTeamsDialog(context),
                        ),
                        _GameMenuOption(
                          width: isClient ? constraints.maxWidth : buttonWidth,
                          icon: PhosphorIconsLight.gear,
                          label: AppLocalizations.of(context).settings,
                          onPressed: () => openSettings(context),
                        ),
                        if (!isClient)
                          _GameMenuOption(
                            width: buttonWidth,
                            icon: PhosphorIconsLight.slidersHorizontal,
                            label: AppLocalizations.of(context).advancedOptions,
                            onPressed: () => _showAdvancedOptions(context),
                          ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                child: ElevatedButton.icon(
                  onPressed: widget.onHome,
                  icon: const Icon(PhosphorIconsLight.door),
                  label: Text(AppLocalizations.of(context).home),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: scheme.error,
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showZoomSheet(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).zoom),
      childrenBuilder: (context) => [
        BlocBuilder<SettingsCubit, SetonixSettings>(
          bloc: settingsCubit,
          buildWhen: (previous, current) => previous.zoom != current.zoom,
          builder: (context, state) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ExactSlider(
              value: state.zoom * 100,
              onChangeEnd: (value) => settingsCubit.resetZoom(value / 100),
              min: 40,
              max: 200,
              fractionDigits: 0,
            ),
          ),
        ),
      ],
    );
  }

  void _showAdvancedOptions(BuildContext context) {
    final bloc = context.read<WorldBloc>();
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) =>
          Text(AppLocalizations.of(context).advancedOptions),
      childrenBuilder: (context) => [
        ListTile(
          leading: const Icon(PhosphorIconsLight.package),
          title: Text(AppLocalizations.of(context).packs),
          trailing: const Icon(PhosphorIconsLight.caretRight),
          onTap: () => showDialog<void>(
            context: context,
            builder: (context) => PacksDialog(bloc: bloc),
          ),
        ),
        ListTile(
          leading: const Icon(PhosphorIconsLight.fileArchive),
          title: Text(AppLocalizations.of(context).saveAsTemplate),
          trailing: const Icon(PhosphorIconsLight.caretRight),
          onTap: () => _saveAsTemplate(context, bloc),
        ),
      ],
    );
  }

  Future<void> _saveAsTemplate(BuildContext context, WorldBloc bloc) async {
    String name = '';
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).saveAsTemplate),
        content: TextField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).name,
            hintText: AppLocalizations.of(context).enterName,
            filled: true,
          ),
          autofocus: true,
          onChanged: (value) => name = value,
          onSubmitted: (_) => Navigator.of(context).pop(true),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context).save),
          ),
        ],
      ),
    );
    if (!(result ?? false) || name.trim().isEmpty) return;
    final state = bloc.state;
    var data = state.world.save();
    data = data.setMetadata(
      data.getMetadataOrDefault().copyWith(
        name: name.trim(),
        type: SetonixFileType.template,
      ),
    );
    state.fileSystem.templateSystem.createFile(name.trim(), data);
  }

  void _showTableDialog(BuildContext context, ClientWorldState state) {
    final bloc = context.read<WorldBloc>();
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).table),
      actionsBuilder: (context) => [
        IconButton(
          icon: const Icon(PhosphorIconsLight.pencil),
          tooltip: AppLocalizations.of(context).edit,
          onPressed: () => _showTableBoundsDialog(context, bloc),
        ),
        IconButton(
          icon: const Icon(PhosphorIconsLight.arrowsLeftRight),
          tooltip: AppLocalizations.of(context).switchTable,
          onPressed: () async {
            String name = '';
            final result = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(AppLocalizations.of(context).switchTable),
                content: TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).name,
                    hintText: AppLocalizations.of(context).enterName,
                    filled: true,
                  ),
                  onChanged: (value) => name = value,
                  onSubmitted: (value) => Navigator.of(context).pop(true),
                  autofocus: true,
                ),
                actions: [
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(false),
                    label: Text(AppLocalizations.of(context).cancel),
                    icon: const Icon(PhosphorIconsLight.prohibit),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(true),
                    label: Text(AppLocalizations.of(context).change),
                    icon: const Icon(PhosphorIconsLight.check),
                  ),
                ],
              ),
            );
            if (!(result ?? false)) return;
            bloc.process(TableSwitched(name));
          },
        ),
      ],
      childrenBuilder: (context) => [
        BlocBuilder<WorldBloc, ClientWorldState>(
          bloc: bloc,
          buildWhen: (previous, current) =>
              previous.tableName != current.tableName ||
              previous.data != current.data,
          builder: (context, state) {
            final other = {
              ...state.data.getTables(),
              state.tableName,
            }.where((e) => e.isNotEmpty).toList();
            return Column(
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).defaultTable),
                  selected: state.tableName == '',
                  onTap: () => bloc.process(TableSwitched()),
                ),
                if (other.isNotEmpty) const Divider(),
                ...other.map(
                  (e) => ListTile(
                    title: Text(e),
                    selected: state.tableName == e,
                    onTap: () => bloc.process(TableSwitched(e)),
                    trailing: MenuAnchor(
                      builder: defaultMenuButton(),
                      menuChildren: [
                        MenuItemButton(
                          leadingIcon: const Icon(PhosphorIconsLight.pencil),
                          child: Text(AppLocalizations.of(context).edit),
                          onPressed: () async {
                            String name = e;
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(AppLocalizations.of(context).table),
                                content: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)
                                        .name,
                                    hintText: AppLocalizations.of(context)
                                        .enterName,
                                    filled: true,
                                  ),
                                  initialValue: name,
                                  onChanged: (value) => name = value,
                                  onFieldSubmitted: (value) =>
                                      Navigator.of(context).pop(true),
                                  autofocus: true,
                                ),
                                actions: [
                                  TextButton.icon(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    label: Text(
                                      AppLocalizations.of(context).cancel,
                                    ),
                                    icon: const Icon(
                                      PhosphorIconsLight.prohibit,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    label: Text(
                                      AppLocalizations.of(context).rename,
                                    ),
                                    icon: const Icon(PhosphorIconsLight.check),
                                  ),
                                ],
                              ),
                            );
                            if (!(result ?? false)) return;
                            bloc.process(TableRenamed(e, name));
                          },
                        ),
                        MenuItemButton(
                          leadingIcon: const Icon(PhosphorIconsLight.trash),
                          child: Text(AppLocalizations.of(context).delete),
                          onPressed: () {
                            bloc.process(TableRemoved(e));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Future<void> _showTableBoundsDialog(
    BuildContext context,
    WorldBloc bloc,
  ) async {
    final table = bloc.state.table;
    VectorDefinition? minCell = table.minCell;
    VectorDefinition? maxCell = table.maxCell;
    final minController = TextEditingController(
      text: minCell?.toDisplayString(),
    );
    final maxController = TextEditingController(
      text: maxCell?.toDisplayString(),
    );
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).table),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: minController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).minCell,
                helperText: '(x, y)',
                filled: true,
              ),
              onChanged: (value) {
                final parsed = _parseCell(value);
                if (value.trim().isEmpty || parsed != null) {
                  minCell = parsed;
                }
              },
            ),
            const SizedBox(height: 8),
            TextField(
              controller: maxController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).maxCell,
                helperText: '(x, y)',
                filled: true,
              ),
              onChanged: (value) {
                final parsed = _parseCell(value);
                if (value.trim().isEmpty || parsed != null) {
                  maxCell = parsed;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context).save),
          ),
        ],
      ),
    );
    minController.dispose();
    maxController.dispose();
    if (!(result ?? false)) return;
    bloc.process(
      TableBoundsChanged(
        bloc.state.tableName,
        minCell: minCell,
        maxCell: maxCell,
      ),
    );
  }

  VectorDefinition? _parseCell(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    try {
      return VectorDefinition.fromDisplay(trimmed);
    } on FormatException {
      return null;
    } on RangeError {
      return null;
    }
  }

  void _showWaypointsDialog(BuildContext context) {
    final bloc = context.read<WorldBloc>();
    Widget buildWaypointTile(Waypoint waypoint, {String? team}) {
      final gameTeam = bloc.state.info.teams[team];
      return ContextRegion(
        builder: (ctx, button, controller) => ListTile(
          title: Text(waypoint.name),
          leading: Icon(
            team != null ? PhosphorIconsLight.users : PhosphorIconsLight.mapPin,
            color: gameTeam?.color?.color,
          ),
          trailing: button,
          onTap: () {
            Navigator.of(ctx).pop();
            widget.game.teleport(waypoint.position);
          },
        ),
        menuChildren: [
          MenuItemButton(
            leadingIcon: const Icon(PhosphorIconsLight.pencil),
            child: Text(AppLocalizations.of(context).edit),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: WaypointDialog(waypoint: waypoint, team: team),
              ),
            ),
          ),
          MenuItemButton(
            leadingIcon: const Icon(PhosphorIconsLight.trash),
            child: Text(AppLocalizations.of(context).delete),
            onPressed: () {
              bloc.add(WaypointRemoved(name: waypoint.name, team: team));
            },
          ),
        ],
      );
    }

    bool showPublic = true, showTeams = true;

    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).waypoints),
      childrenBuilder: (context) => [
        BlocBuilder<WorldBloc, ClientWorldState>(
          bloc: bloc,
          buildWhen: (previous, current) =>
              previous.showWaypoints != current.showWaypoints,
          builder: (context, state) => SwitchListTile(
            value: state.showWaypoints,
            title: Text(AppLocalizations.of(context).waypoints),
            secondary: const Icon(PhosphorIconsLight.mapPin),
            onChanged: (value) =>
                bloc.process(WaypointVisibilityChanged(value)),
          ),
        ),
        const Divider(),
        StatefulBuilder(
          builder: (context, setLocalState) {
            return BlocBuilder<WorldBloc, ClientWorldState>(
              bloc: bloc,
              buildWhen: (previous, current) =>
                  previous.info.waypoints != current.info.waypoints ||
                  previous.info.teams != current.info.teams ||
                  previous.teamMembers != current.teamMembers,
              builder: (context, state) {
                final List<Widget> waypointTiles = [];

                if (showTeams) {
                  waypointTiles.addAll(
                    state.world.getTeams().expand(
                      (e) =>
                          state.info.teams[e]?.waypoints.map(
                            (waypoint) => buildWaypointTile(waypoint, team: e),
                          ) ??
                          <Widget>[],
                    ),
                  );
                }

                if (showPublic) {
                  waypointTiles.addAll(
                    state.info.waypoints.map((e) => buildWaypointTile(e)),
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        FilterChip(
                          label: Text(AppLocalizations.of(context).teams),
                          selected: showTeams,
                          onSelected: (v) => setLocalState(() => showTeams = v),
                        ),
                        FilterChip(
                          label: const Text('Public'),
                          selected: showPublic,
                          onSelected: (v) =>
                              setLocalState(() => showPublic = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (waypointTiles.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(AppLocalizations.of(context).noWaypoints),
                        ),
                      )
                    else
                      ...waypointTiles,
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _showTeamsDialog(BuildContext context) {
    final bloc = context.read<WorldBloc>();
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).teams),
      actionsBuilder: (context) => [
        IconButton(
          icon: const Icon(PhosphorIconsLight.plusCircle),
          onPressed: () => showDialog(
            context: context,
            builder: (context) =>
                BlocProvider.value(value: bloc, child: const TeamDialog()),
          ),
        ),
      ],
      childrenBuilder: (context) => [
        BlocBuilder<WorldBloc, ClientWorldState>(
          bloc: bloc,
          buildWhen: (previous, current) =>
              previous.info.teams != current.info.teams ||
              previous.teamMembers != current.teamMembers,
          builder: (context, state) {
            if (state.info.teams.isEmpty) {
              return Center(child: Text(AppLocalizations.of(context).noTeams));
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: state.info.teams.entries.map((entry) {
                final name = entry.key;
                final team = entry.value;
                final selected =
                    state.teamMembers[name]?.contains(state.id) ?? false;
                return ListTile(
                  title: Text(name),
                  leading: ColorButton(
                    color: team.color?.color ?? Colors.transparent,
                    size: 24,
                  ),
                  selected: selected,
                  trailing: MenuAnchor(
                    builder: defaultMenuButton(),
                    menuChildren: [
                      MenuItemButton(
                        leadingIcon: const Icon(PhosphorIconsLight.pencil),
                        child: Text(AppLocalizations.of(context).edit),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: bloc,
                            child: TeamDialog(team: name, data: team),
                          ),
                        ),
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(PhosphorIconsLight.trash),
                        child: Text(AppLocalizations.of(context).delete),
                        onPressed: () => bloc.process(TeamRemoved(name)),
                      ),
                    ],
                  ),
                  onTap: () => bloc.process(
                    selected ? TeamLeaveRequest(name) : TeamJoinRequest(name),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _GameMenuOption extends StatelessWidget {
  final double width;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _GameMenuOption({
    required this.width,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 60,
      child: FilledButton.tonalIcon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label, textAlign: TextAlign.center),
        style: FilledButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

class _TableMenuCard extends StatelessWidget {
  final Widget child;
  final bool emphasized;

  const _TableMenuCard({required this.child, this.emphasized = false});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
      child: Card.filled(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        color: emphasized ? scheme.primaryContainer : null,
        child: child,
      ),
    );
  }
}
