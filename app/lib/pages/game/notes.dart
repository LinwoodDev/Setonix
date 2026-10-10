import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/pages/game/note.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

class GameNotesDialog extends StatelessWidget {
  const GameNotesDialog({super.key});

  void _openNote(BuildContext context, {String? note, bool edit = false}) {
    final bloc = context.read<WorldBloc>();
    showDialog<void>(
      context: context,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: GameNoteDialog(note: note, edit: edit),
      ),
    );
  }

  Future<void> _deleteNote(BuildContext context, String note) async {
    final bloc = context.read<WorldBloc>();
    if (!bloc.state.world.toolbar.editable) return;
    final loc = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.deleteNote),
        content: Text(loc.deleteNoteMessage(note)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(loc.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(loc.delete),
          ),
        ],
      ),
    );
    if (confirmed == true &&
        !bloc.isClosed &&
        bloc.state.world.toolbar.editable) {
      bloc.process(NoteRemoved(note));
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<WorldBloc, ClientWorldState>(
    buildWhen: (previous, current) =>
        previous.data != current.data ||
        previous.info.homeNote != current.info.homeNote ||
        previous.world.toolbar.editable != current.world.toolbar.editable,
    builder: (context, state) {
      final loc = AppLocalizations.of(context);
      final theme = Theme.of(context);
      final notes = state.data.getNotes().toList()..sort();
      final editable = state.world.toolbar.editable;
      return Dialog(
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 520,
            maxHeight: math.min(640, MediaQuery.sizeOf(context).height - 48),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 12, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        loc.manageNotes,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      tooltip: loc.close,
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(PhosphorIconsLight.x),
                    ),
                  ],
                ),
              ),
              if (!editable)
                ListTile(
                  leading: const Icon(PhosphorIconsLight.lock),
                  title: Text(loc.readOnly),
                ),
              Flexible(
                child: notes.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 40,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(PhosphorIconsLight.files, size: 40),
                            const SizedBox(height: 12),
                            Text(
                              loc.noNotes,
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          final home = state.info.homeNote == note;
                          return ListTile(
                            leading: Icon(
                              home
                                  ? PhosphorIconsFill.house
                                  : PhosphorIconsLight.fileText,
                            ),
                            title: Text(
                              note,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: home ? Text(loc.homePage) : null,
                            onTap: () => _openNote(context, note: note),
                            trailing: editable
                                ? MenuAnchor(
                                    builder: (context, controller, child) =>
                                        IconButton(
                                          tooltip: loc.manageNotes,
                                          icon: const Icon(
                                            PhosphorIconsLight
                                                .dotsThreeVertical,
                                          ),
                                          onPressed: () => controller.isOpen
                                              ? controller.close()
                                              : controller.open(),
                                        ),
                                    menuChildren: [
                                      MenuItemButton(
                                        leadingIcon: const Icon(
                                          PhosphorIconsLight.pencil,
                                        ),
                                        onPressed: () => _openNote(
                                          context,
                                          note: note,
                                          edit: true,
                                        ),
                                        child: Text(loc.edit),
                                      ),
                                      MenuItemButton(
                                        leadingIcon: const Icon(
                                          PhosphorIconsLight.trash,
                                        ),
                                        onPressed: () =>
                                            _deleteNote(context, note),
                                        child: Text(loc.delete),
                                      ),
                                    ],
                                  )
                                : const Icon(PhosphorIconsLight.lock, size: 20),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: FilledButton.icon(
                  icon: const Icon(PhosphorIconsLight.plus),
                  label: Text(loc.createNote),
                  onPressed: editable ? () => _openNote(context) : null,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
