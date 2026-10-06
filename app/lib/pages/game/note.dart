import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/pages/game/note_content.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix_api/setonix_api.dart';

class GameNoteDialog extends StatefulWidget {
  final String? note;

  const GameNoteDialog({super.key, this.note});

  @override
  State<GameNoteDialog> createState() => _GameNoteDialogState();
}

class _GameNoteDialogState extends State<GameNoteDialog> {
  late final WorldBloc _bloc;
  bool _editing = true, _expanded = false, _hasDraft = false;
  final TextEditingController _nameController = TextEditingController(),
      _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorldBloc>();
    final note = widget.note;
    if (note != null) {
      _editing = false;
      _nameController.text = note;
      _contentController.text = _bloc.state.data.getNote(note) ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ResponsiveAlertDialog(
      title: widget.note == null
          ? TextFormField(
              controller: _nameController,
              autofocus: true,
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).name,
                filled: true,
              ),
            )
          : Text(widget.note!),
      headerActions: [
        IconButton(
          icon: const Icon(PhosphorIconsLight.pencil),
          tooltip: _editing
              ? AppLocalizations.of(context).exitEditMode
              : AppLocalizations.of(context).enterEditMode,
          isSelected: _editing,
          selectedIcon: const Icon(PhosphorIconsLight.monitor),
          onPressed: () {
            setState(() {
              if (!_editing && !_hasDraft && widget.note != null) {
                _contentController.text =
                    _bloc.state.data.getNote(widget.note!) ?? '';
              }
              _editing = !_editing;
            });
          },
        ),
        if (size.width > LeapBreakpoints.expanded)
          IconButton(
            icon: _expanded
                ? const Icon(PhosphorIconsLight.arrowsInSimple)
                : const Icon(PhosphorIconsLight.arrowsOutSimple),
            tooltip: _expanded
                ? AppLocalizations.of(context).collapse
                : AppLocalizations.of(context).expand,
            onPressed: () => setState(() => _expanded = !_expanded),
          ),
      ],
      actions: [
        TextButton.icon(
          icon: const Icon(PhosphorIconsLight.prohibit),
          label: Text(AppLocalizations.of(context).cancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
        if (_editing)
          ElevatedButton.icon(
            icon: const Icon(PhosphorIconsLight.floppyDisk),
            label: Text(AppLocalizations.of(context).save),
            onPressed: () {
              _bloc.process(
                NoteChanged(_nameController.text, _contentController.text),
              );
              Navigator.of(context).pop();
            },
          ),
      ],
      constraints: BoxConstraints(
        maxWidth: _expanded ? LeapBreakpoints.large : LeapBreakpoints.medium,
        maxHeight: 1000,
      ),
      content: _editing
          ? TextFormField(
              minLines: _expanded ? 15 : 6,
              maxLines: 50,
              autofocus: widget.note != null,
              controller: _contentController,
              onChanged: (_) => _hasDraft = true,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).content,
                border: const OutlineInputBorder(),
              ),
            )
          : BlocBuilder<WorldBloc, ClientWorldState>(
              buildWhen: (previous, current) => previous.data != current.data,
              builder: (context, state) => ConstrainedBox(
                constraints: BoxConstraints(minHeight: _expanded ? 400 : 200),
                child: GameNoteContent(
                  content: widget.note == null || _hasDraft
                      ? _contentController.text
                      : state.data.getNote(widget.note!) ?? '',
                ),
              ),
            ),
    );
  }
}
