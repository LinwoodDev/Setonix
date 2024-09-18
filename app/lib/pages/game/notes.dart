import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/pages/game/note.dart';
import 'package:quokka_api/quokka_api.dart';

class GameNotesDrawer extends StatefulWidget {
  const GameNotesDrawer({super.key});

  @override
  State<GameNotesDrawer> createState() => _GameNotesDrawerState();
}

class _GameNotesDrawerState extends State<GameNotesDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(
            leading: IconButton.outlined(
              icon: const Icon(PhosphorIconsLight.x),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(AppLocalizations.of(context).notes),
          ),
          Flexible(
            child: BlocBuilder<WorldBloc, ClientWorldState>(
              buildWhen: (previous, current) => previous.data != current.data,
              builder: (context, state) {
                final notes = state.data.getNotes().toList();
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return ListTile(
                      title: Text(note),
                      onTap: () {
                        final bloc = context.read<WorldBloc>();
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: bloc,
                            child: GameNoteDialog(note: note),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(PhosphorIconsLight.trash),
                        onPressed: () async {
                          final bloc = context.read<WorldBloc>();
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:
                                  Text(AppLocalizations.of(context).deleteNote),
                              content: Text(AppLocalizations.of(context)
                                  .deleteNoteMessage(note)),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child:
                                      Text(AppLocalizations.of(context).cancel),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child:
                                      Text(AppLocalizations.of(context).delete),
                                ),
                              ],
                            ),
                          );
                          if (!(result ?? false)) return;
                          bloc.process(
                            NoteRemoved(note),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              icon: const Icon(PhosphorIconsLight.plus),
              label: Text(AppLocalizations.of(context).create),
              onPressed: () {
                final bloc = context.read<WorldBloc>();
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                      value: bloc, child: const GameNoteDialog()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
