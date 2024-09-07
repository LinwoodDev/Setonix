import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka_api/quokka_api.dart';

class GameNoteDialog extends StatefulWidget {
  final String? note;

  const GameNoteDialog({
    super.key,
    this.note,
  });

  @override
  State<GameNoteDialog> createState() => _GameNoteDialogState();
}

class _GameNoteDialogState extends State<GameNoteDialog> {
  late final WorldBloc _bloc;
  bool _editing = true;
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
    _bloc.process(NoteChanged(_nameController.text, _contentController.text));
    _nameController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: widget.note == null
          ? TextFormField(
              controller: _nameController,
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
              _editing = !_editing;
            });
          },
        ),
      ],
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
      ),
      constraints: const BoxConstraints(
          maxWidth: LeapBreakpoints.medium, maxHeight: 800),
      content: _editing
          ? TextFormField(
              minLines: 5,
              maxLines: 50,
              controller: _contentController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).content,
                border: const OutlineInputBorder(),
              ),
            )
          : ListenableBuilder(
              listenable: _contentController,
              builder: (context, _) => Markdown(
                  extensionSet: md.ExtensionSet(
                    md.ExtensionSet.gitHubWeb.blockSyntaxes,
                    <md.InlineSyntax>[
                      md.EmojiSyntax(),
                      ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
                    ],
                  ),
                  data: _contentController.text)),
    );
  }
}
