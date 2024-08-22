import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/helpers/visualizer.dart';
import 'package:quokka_api/quokka_api.dart';

class TeamDialog extends StatefulWidget {
  final String? team;
  final GameTeam? data;

  const TeamDialog({
    super.key,
    this.team,
    this.data,
  });

  @override
  State<TeamDialog> createState() => TeamDialogState();
}

class TeamDialogState extends State<TeamDialog> {
  late final WorldBloc _bloc = context.read<WorldBloc>();
  final TextEditingController _nameController = TextEditingController(),
      _descriptionController = TextEditingController();
  TeamColor? _color;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.team ?? '';
    final data = widget.data;
    if (data != null) {
      _descriptionController.text = data.description;
      _color = data.color;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _isCreate() => widget.team == null;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).addTeam),
      scrollable: true,
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name,
                filled: true,
              ),
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).description,
                border: const OutlineInputBorder(),
              ),
              controller: _descriptionController,
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            Wrap(
              children: TeamColor.values
                  .map((e) => ColorButton(
                        color: e.color,
                        size: 32,
                        selected: _color == e,
                        onTap: () =>
                            setState(() => _color = _color == e ? null : e),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        BlocBuilder<WorldBloc, WorldState>(
          bloc: _bloc,
          buildWhen: (previous, current) =>
              previous.info.teams != current.info.teams,
          builder: (context, state) => ListenableBuilder(
            listenable: _nameController,
            builder: (context, child) {
              final text = _nameController.text;
              return ElevatedButton(
                onPressed: text.isEmpty ||
                        (state.info.teams.containsKey(text) &&
                            text != widget.team)
                    ? null
                    : () {
                        final team = GameTeam(
                          description: _descriptionController.text,
                          color: _color,
                        );
                        _bloc.add(TeamChanged(
                            widget.team ?? _nameController.text, team));
                        Navigator.of(context).pop();
                      },
                child: Text(_isCreate()
                    ? AppLocalizations.of(context).create
                    : AppLocalizations.of(context).edit),
              );
            },
          ),
        ),
      ],
    );
  }
}
