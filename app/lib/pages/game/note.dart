import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/pages/game/note_content.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

class GameNoteDialog extends StatefulWidget {
  final String? note;
  final bool edit;

  const GameNoteDialog({super.key, this.note, this.edit = false});

  @override
  State<GameNoteDialog> createState() => _GameNoteDialogState();
}

class _GameNoteDialogState extends State<GameNoteDialog> {
  late final WorldBloc _bloc;
  bool _editing = true, _expanded = false, _hasDraft = false;
  bool _homePage = false;
  String? _note;
  final TextEditingController _nameController = TextEditingController(),
      _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorldBloc>();
    final note = _note = widget.note;
    if (note != null) {
      _editing = widget.edit;
      _nameController.text = note;
      _contentController.text = _bloc.state.data.getNote(note) ?? '';
      _homePage = _bloc.state.info.homeNote == note;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WorldBloc, ClientWorldState>(
        buildWhen: (previous, current) =>
            previous.data != current.data ||
            previous.world.toolbar != current.world.toolbar ||
            previous.info.homeNote != current.info.homeNote,
        builder: _buildDialog,
      );

  Widget _buildDialog(BuildContext context, ClientWorldState state) {
    final loc = AppLocalizations.of(context);
    final size = MediaQuery.sizeOf(context);
    final editable = state.world.toolbar.editable;
    final editing = editable && _editing;
    return ResponsiveAlertDialog(
      title: _note == null && editable
          ? TextFormField(
              controller: _nameController,
              autofocus: true,
              onChanged: (_) => setState(() {}),
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: InputDecoration(hintText: loc.name, filled: true),
            )
          : Text(_note ?? loc.notes),
      headerActions: [
        if (!editable)
          Tooltip(
            message: loc.readOnly,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(PhosphorIconsLight.lock),
            ),
          ),
        if (editable)
          IconButton(
            icon: const Icon(PhosphorIconsLight.pencil),
            tooltip: editing ? loc.exitEditMode : loc.enterEditMode,
            isSelected: editing,
            selectedIcon: const Icon(PhosphorIconsLight.monitor),
            onPressed: () {
              setState(() {
                if (!_editing && !_hasDraft && _note != null) {
                  _contentController.text =
                      _bloc.state.data.getNote(_note!) ?? '';
                  _homePage = _bloc.state.info.homeNote == _note;
                }
                _editing = !_editing;
              });
            },
          ),
        if (size.width > LeapBreakpoints.expanded)
          IconButton(
            icon: Icon(
              _expanded
                  ? PhosphorIconsLight.arrowsInSimple
                  : PhosphorIconsLight.arrowsOutSimple,
            ),
            tooltip: _expanded ? loc.collapse : loc.expand,
            onPressed: () => setState(() => _expanded = !_expanded),
          ),
      ],
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(editing ? loc.cancel : loc.close),
        ),
        if (editing)
          FilledButton.icon(
            icon: const Icon(PhosphorIconsLight.floppyDisk),
            label: Text(loc.save),
            onPressed: _nameController.text.trim().isEmpty
                ? null
                : () {
                    if (!_bloc.state.world.toolbar.editable) return;
                    _bloc.process(
                      NoteChanged(
                        _nameController.text.trim(),
                        _contentController.text,
                        homePage: _homePage,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
          ),
      ],
      constraints: BoxConstraints(
        maxWidth: _expanded ? LeapBreakpoints.large : LeapBreakpoints.medium,
        maxHeight: 1000,
      ),
      content: editing
          ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(loc.homePage),
                    value: _homePage,
                    onChanged: (value) => setState(() {
                      _homePage = value ?? false;
                      _hasDraft = true;
                    }),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    minLines: _expanded ? 15 : 6,
                    maxLines: 50,
                    autofocus: _note != null,
                    controller: _contentController,
                    onChanged: (_) => _hasDraft = true,
                    decoration: InputDecoration(
                      hintText: loc.content,
                      helperText: loc.noteFormattingHelp,
                      helperMaxLines: 4,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: _expanded ? 400 : 200),
                child: GameNoteContent(
                  actions: state.world.toolbar.actions,
                  onAction: (id) => processNoteAction(_bloc, id),
                  onOpenNote: (name) {
                    if (state.data.getNotes().contains(name)) {
                      setState(() {
                        _note = name;
                        _nameController.text = name;
                        _contentController.text =
                            state.data.getNote(name) ?? '';
                        _homePage = state.info.homeNote == name;
                        _hasDraft = false;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.noteNotFound(name))),
                      );
                    }
                  },
                  content: _note == null || _hasDraft
                      ? _contentController.text
                      : state.data.getNote(_note!) ?? '',
                ),
              ),
            ),
    );
  }
}
