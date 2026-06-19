import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

class WaypointDialog extends StatelessWidget {
  final String? team;
  final Waypoint? waypoint;
  final GlobalVectorDefinition? position;

  const WaypointDialog({super.key, this.team, this.waypoint, this.position});

  @override
  Widget build(BuildContext context) {
    final isCreated = position != null;
    final loc = AppLocalizations.of(context);
    var waypoint =
        this.waypoint ??
        Waypoint(
          name: '',
          position: position ?? GlobalVectorDefinition('', 0, 0),
        );
    var team = this.team;
    final bloc = context.read<WorldBloc>();
    return ResponsiveAlertDialog(
      title: Text(isCreated ? loc.addWaypoint : loc.editWaypoint),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: loc.name, filled: true),
            initialValue: waypoint.name,
            onChanged: (value) {
              waypoint = waypoint.copyWith(name: value);
            },
          ),
          const SizedBox(height: 8),
          DropdownMenu<String?>(
            expandedInsets: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
            dropdownMenuEntries: [
              DropdownMenuEntry<String?>(value: null, label: loc.public),
              ...bloc.state.world.getTeams().map(
                (e) => DropdownMenuEntry<String?>(value: e, label: e),
              ),
            ],
            label: Text(loc.team),
            initialSelection: team,
            onSelected: (value) {
              team = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(loc.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            bloc.add(
              WaypointChanged(
                waypoint: waypoint,
                team: team,
                name: this.waypoint?.name,
              ),
            );
            Navigator.of(context).pop();
          },
          child: Text(isCreated ? loc.add : loc.save),
        ),
      ],
    );
  }
}
