import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix_api/setonix_api.dart';

class ScriptsEditorPage extends StatelessWidget {
  const ScriptsEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditorCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: LeapBreakpoints.expanded),
            padding: const EdgeInsets.all(4),
            child: BlocBuilder<EditorCubit, SetonixData>(
              builder: (context, state) {
                final scripts = state.getScripts().toList();
                if (scripts.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context).noData),
                    ),
                  );
                }
                return Column(
                  children: scripts.map((id) {
                    return Dismissible(
                      key: ValueKey(id),
                      onDismissed: (direction) {
                        cubit.removeScript(id);
                      },
                      child: ListTile(
                        title: Text(id),
                        trailing: IconButton(
                          icon: const Icon(PhosphorIconsLight.trash),
                          onPressed: () {
                            cubit.removeScript(id);
                          },
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: cubit,
                              child: ScriptEditorDialog(name: id),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var name = await showDialog<String>(
            context: context,
            builder: (context) =>
                NameDialog(), // We can do better later, just minimal
          );
          if (name == null || name.isEmpty) return;
          name = '$name.lua';
          cubit.setScript(name, '-- new script\n');
        },
        label: Text(LeapLocalizations.of(context).create),
        icon: const Icon(PhosphorIconsLight.plus),
      ),
    );
  }
}

class ScriptEditorDialog extends StatefulWidget {
  final String name;

  const ScriptEditorDialog({super.key, required this.name});

  @override
  State<ScriptEditorDialog> createState() => _ScriptEditorDialogState();
}

class _ScriptEditorDialogState extends State<ScriptEditorDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final editorState = context.read<EditorCubit>().state;
    final value = editorState.getScript(widget.name) ?? '';
    _controller = TextEditingController(text: value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(widget.name),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.expanded),
      content: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).scripts,
          filled: true,
          alignLabelWithHint: true,
        ),
        maxLines: null,
        expands: true,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(fontFamily: 'monospace'),
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
            context.read<EditorCubit>().setScript(
              widget.name,
              _controller.text,
            );
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
