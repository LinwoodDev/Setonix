import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix_api/setonix_api.dart';

class ModeEditorDialog extends StatefulWidget {
  final String name;

  const ModeEditorDialog({super.key, required this.name});

  @override
  State<ModeEditorDialog> createState() => _ModeEditorDialogState();
}

class _ModeEditorDialogState extends State<ModeEditorDialog> {
  GameMode? _value;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_value == null) {
      final editorState = context.read<EditorCubit>().state;
      _value = editorState.getMode(widget.name) ?? GameMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final value = _value;
    if (value == null) return const SizedBox();

    return DefaultTabController(
      length: 3,
      child: ResponsiveAlertDialog(
        title: Text(widget.name),
        constraints: const BoxConstraints(
          maxWidth: LeapBreakpoints.compact,
          maxHeight: 600,
        ),
        content: Column(
          children: [
            TabBar(
              tabs: [
                HorizontalTab(
                  icon: const Icon(PhosphorIconsLight.textT),
                  label: Text(AppLocalizations.of(context).general),
                ),
                HorizontalTab(
                  icon: const Icon(PhosphorIconsLight.users),
                  label: Text(AppLocalizations.of(context).teams),
                ),
                HorizontalTab(
                  icon: const Icon(PhosphorIconsLight.mapTrifold),
                  label: Text(AppLocalizations.of(context).tables),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: General (Script)
                  ListView(
                    shrinkWrap: true,
                    children: [
                      BlocBuilder<EditorCubit, SetonixData>(
                        builder: (context, state) {
                          final scripts = state.getScripts().toList();
                          return DropdownButtonFormField<String?>(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).scripts,
                              filled: true,
                            ),
                            initialValue: value.script,
                            items: [
                              DropdownMenuItem(
                                value: null,
                                child: Text(AppLocalizations.of(context).none),
                              ),
                              ...scripts.map(
                                (script) => DropdownMenuItem(
                                  value: script,
                                  child: Text(script),
                                ),
                              ),
                            ],
                            onChanged: (newScript) {
                              setState(() {
                                _value = value.copyWith(script: newScript);
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  // Tab 2: Teams
                  Stack(
                    children: [
                      ListView.builder(
                        itemCount: value.teams.length,
                        itemBuilder: (context, index) {
                          final teamId = value.teams.keys.elementAt(index);
                          final team = value.teams[teamId]!;
                          return ListTile(
                            title: Text(teamId),
                            subtitle: Text(team.description),
                            onTap: () async {
                              final cubit = context.read<EditorCubit>();
                              final result =
                                  await showDialog<MapEntry<String, GameTeam>>(
                                    context: context,
                                    builder: (context) => BlocProvider.value(
                                      value: cubit,
                                      child: _ModeTeamEditorDialog(
                                        initialId: teamId,
                                        initialTeam: team,
                                      ),
                                    ),
                                  );
                              if (result == null) return;
                              setState(() {
                                final newTeams = Map<String, GameTeam>.from(
                                  value.teams,
                                );
                                if (result.key != teamId) {
                                  newTeams.remove(teamId);
                                }
                                newTeams[result.key] = result.value;
                                _value = value.copyWith(teams: newTeams);
                              });
                            },
                            trailing: IconButton(
                              icon: const Icon(PhosphorIconsLight.trash),
                              onPressed: () {
                                setState(() {
                                  final newTeams = Map<String, GameTeam>.from(
                                    value.teams,
                                  );
                                  newTeams.remove(teamId);
                                  _value = value.copyWith(teams: newTeams);
                                });
                              },
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            final cubit = context.read<EditorCubit>();
                            final result =
                                await showDialog<MapEntry<String, GameTeam>>(
                                  context: context,
                                  builder: (context) => BlocProvider.value(
                                    value: cubit,
                                    child: const _ModeTeamEditorDialog(),
                                  ),
                                );
                            if (result == null) return;
                            setState(() {
                              final newTeams = Map<String, GameTeam>.from(
                                value.teams,
                              );
                              newTeams[result.key] = result.value;
                              _value = value.copyWith(teams: newTeams);
                            });
                          },
                          icon: const Icon(PhosphorIconsLight.plus),
                          label: Text(LeapLocalizations.of(context).create),
                        ),
                      ),
                    ],
                  ),
                  // Tab 3: Tables
                  Stack(
                    children: [
                      ListView.builder(
                        itemCount: value.tables.length,
                        itemBuilder: (context, index) {
                          final tableId = value.tables.keys.elementAt(index);
                          final table = value.tables[tableId]!;
                          return ListTile(
                            title: Text(tableId),
                            onTap: () async {
                              final cubit = context.read<EditorCubit>();
                              final result =
                                  await showDialog<MapEntry<String, GameTable>>(
                                    context: context,
                                    builder: (context) => BlocProvider.value(
                                      value: cubit,
                                      child: _ModeTableEditorDialog(
                                        initialId: tableId,
                                        initialTable: table,
                                      ),
                                    ),
                                  );
                              if (result == null) return;
                              setState(() {
                                final newTables = Map<String, GameTable>.from(
                                  value.tables,
                                );
                                if (result.key != tableId) {
                                  newTables.remove(tableId);
                                }
                                newTables[result.key] = result.value;
                                _value = value.copyWith(tables: newTables);
                              });
                            },
                            trailing: IconButton(
                              icon: const Icon(PhosphorIconsLight.trash),
                              onPressed: () {
                                setState(() {
                                  final newTables = Map<String, GameTable>.from(
                                    value.tables,
                                  );
                                  newTables.remove(tableId);
                                  _value = value.copyWith(tables: newTables);
                                });
                              },
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            final cubit = context.read<EditorCubit>();
                            final result =
                                await showDialog<MapEntry<String, GameTable>>(
                                  context: context,
                                  builder: (context) => BlocProvider.value(
                                    value: cubit,
                                    child: const _ModeTableEditorDialog(),
                                  ),
                                );
                            if (result == null) return;
                            setState(() {
                              final newTables = Map<String, GameTable>.from(
                                value.tables,
                              );
                              newTables[result.key] = result.value;
                              _value = value.copyWith(tables: newTables);
                            });
                          },
                          icon: const Icon(PhosphorIconsLight.plus),
                          label: Text(LeapLocalizations.of(context).create),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<EditorCubit>().setMode(widget.name, value);
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).save),
          ),
        ],
      ),
    );
  }
}

class _ModeTeamEditorDialog extends StatefulWidget {
  final String? initialId;
  final GameTeam? initialTeam;

  const _ModeTeamEditorDialog({this.initialId, this.initialTeam});

  @override
  State<_ModeTeamEditorDialog> createState() => _ModeTeamEditorDialogState();
}

class _ModeTeamEditorDialogState extends State<_ModeTeamEditorDialog> {
  late String _id;
  late GameTeam _team;

  @override
  void initState() {
    super.initState();
    _id = widget.initialId ?? 'team_id';
    _team = widget.initialTeam ?? GameTeam();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(
        widget.initialId == null
            ? AppLocalizations.of(context).createTeam
            : AppLocalizations.of(context).editTeam,
      ),
      content: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).teamId,
              filled: true,
            ),
            initialValue: _id,
            onChanged: (val) => _id = val,
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).description,
              filled: true,
            ),
            initialValue: _team.description,
            onChanged: (val) =>
                setState(() => _team = _team.copyWith(description: val)),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<TeamColor?>(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).color,
              filled: true,
            ),
            initialValue: _team.color,
            items: [
              DropdownMenuItem(
                value: null,
                child: Text(AppLocalizations.of(context).none),
              ),
              ...TeamColor.values.map(
                (c) => DropdownMenuItem(value: c, child: Text(c.name)),
              ),
            ],
            onChanged: (val) =>
                setState(() => _team = _team.copyWith(color: val)),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (_id.isEmpty) return;
            Navigator.of(context).pop(MapEntry(_id, _team));
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}

class _ModeTableEditorDialog extends StatefulWidget {
  final String? initialId;
  final GameTable? initialTable;

  const _ModeTableEditorDialog({this.initialId, this.initialTable});

  @override
  State<_ModeTableEditorDialog> createState() => _ModeTableEditorDialogState();
}

class _ModeTableEditorDialogState extends State<_ModeTableEditorDialog> {
  late String _id;
  late GameTable _table;

  @override
  void initState() {
    super.initState();
    _id = widget.initialId ?? 'table_id';
    _table = widget.initialTable ?? const GameTable();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(
        widget.initialId == null
            ? AppLocalizations.of(context).createTable
            : AppLocalizations.of(context).editTable,
      ),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).tableId,
              filled: true,
            ),
            initialValue: _id,
            onChanged: (val) => _id = val,
          ),
          const SizedBox(height: 8),
          BlocBuilder<EditorCubit, SetonixData>(
            builder: (context, state) {
              final backgrounds = state.getBackgrounds().toList();
              final currentBg = _table.background?.toString();
              return DropdownButtonFormField<String?>(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).backgrounds,
                  filled: true,
                ),
                initialValue: backgrounds.contains(currentBg)
                    ? currentBg
                    : null,
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text(AppLocalizations.of(context).none),
                  ),
                  ...backgrounds.map(
                    (bg) => DropdownMenuItem(value: bg, child: Text(bg)),
                  ),
                ],
                onChanged: (val) => setState(() {
                  _table = _table.copyWith(
                    background: val == null
                        ? null
                        : ItemLocation.fromString(val),
                  );
                }),
              );
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (_id.isEmpty) return;
            Navigator.of(context).pop(MapEntry(_id, _table));
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
