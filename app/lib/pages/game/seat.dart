import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/logic/connection/client.dart';
import 'package:qeck/logic/state.dart';

class SeatsDialog extends StatelessWidget {
  final ClientGameConnection connection;

  const SeatsDialog({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).seats),
      scrollable: true,
      content: SizedBox(
        width: 300,
        child: StreamBuilder<GameState>(
            stream: connection.stateStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...state.seats.asMap().entries.map(
                    (e) {
                      final seat = e.value;
                      final selected =
                          seat.players.contains(connection.playerId);
                      return ListTile(
                        title: Text(seat.name),
                        selected: selected,
                        leading: selected
                            ? IconButton(
                                icon:
                                    const PhosphorIcon(PhosphorIconsLight.door),
                                onPressed: () => connection.leaveSeat(e.key),
                              )
                            : IconButton(
                                icon: const PhosphorIcon(
                                    PhosphorIconsLight.doorOpen),
                                onPressed: () => connection.joinSeat(e.key),
                              ),
                        trailing: IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.trash),
                          onPressed: () => connection.removeSeat(e.key),
                        ),
                      );
                    },
                  ),
                  if (connection.state.seats.isNotEmpty) const Divider(),
                  ListTile(
                    title: Text(AppLocalizations.of(context).create),
                    trailing: const Icon(Icons.add),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              CreateSeatDialog(connection: connection));
                    },
                  ),
                ],
              );
            }),
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

class CreateSeatDialog extends StatelessWidget {
  final ClientGameConnection connection;
  const CreateSeatDialog({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    String name = '';
    return AlertDialog(
      title: Text(AppLocalizations.of(context).addSeat),
      scrollable: true,
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name,
                filled: true,
                icon: const PhosphorIcon(PhosphorIconsLight.textT),
              ),
              onChanged: (value) => name = value,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            connection.addSeat(name);
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
