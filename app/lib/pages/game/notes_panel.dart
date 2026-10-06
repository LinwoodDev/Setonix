import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/pages/game/note_content.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

class GameNotesPanel extends StatelessWidget {
  final VoidCallback onClose, onManage;

  const GameNotesPanel({
    super.key,
    required this.onClose,
    required this.onManage,
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WorldBloc, ClientWorldState>(
        buildWhen: (previous, current) => previous.data != current.data,
        builder: (context, state) => GameNotesReader(
          data: state.data,
          onClose: onClose,
          onManage: onManage,
        ),
      );
}

/// Selection belongs to the reader so incoming updates do not reset the note
/// or scroll position while the player is following a round.
class GameNotesReader extends StatefulWidget {
  final SetonixData data;
  final VoidCallback onClose, onManage;

  const GameNotesReader({
    super.key,
    required this.data,
    required this.onClose,
    required this.onManage,
  });

  @override
  State<GameNotesReader> createState() => _GameNotesReaderState();
}

class _GameNotesReaderState extends State<GameNotesReader> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final notes = widget.data.getNotes().toList()..sort();
    final selected = notes.contains(_selected) ? _selected : notes.firstOrNull;
    _selected = selected;
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    loc.notes,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: widget.onManage,
                  tooltip: loc.edit,
                  icon: const Icon(PhosphorIconsLight.pencil),
                ),
                IconButton(
                  onPressed: widget.onClose,
                  tooltip: loc.close,
                  icon: const Icon(PhosphorIconsLight.x),
                ),
              ],
            ),
          ),
          if (notes.length > 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: DropdownButtonFormField<String>(
                key: ValueKey(selected),
                initialValue: selected,
                isExpanded: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: notes
                    .map(
                      (note) => DropdownMenuItem(
                        value: note,
                        child: Text(note, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                onChanged: (note) => setState(() => _selected = note),
              ),
            ),
          const Divider(height: 1),
          Expanded(
            child: selected == null
                ? Center(child: Text(loc.notes))
                : SingleChildScrollView(
                    key: ValueKey(selected),
                    padding: const EdgeInsets.all(16),
                    child: GameNoteContent(
                      content: widget.data.getNote(selected) ?? '',
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
