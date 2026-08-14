import 'dart:ui';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix_api/setonix_api.dart';

class GameDialogOverlay extends StatelessWidget {
  const GameDialogOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, ClientWorldState>(
      buildWhen: (previous, current) =>
          previous.world.dialogs.firstOrNull !=
              current.world.dialogs.firstOrNull ||
          previous.world.images != current.world.images,
      builder: (context, state) {
        final dialog = state.world.dialogs.firstOrNull;
        if (dialog == null) {
          return const SizedBox();
        }
        final image = state.world.images[dialog.image];
        return _GameDialogContent(dialog: dialog, image: image);
      },
    );
  }
}

class _GameDialogContent extends StatefulWidget {
  final GameDialog dialog;
  final Uint8List? image;

  const _GameDialogContent({required this.dialog, this.image});

  @override
  State<_GameDialogContent> createState() => _GameDialogContentState();
}

class _GameDialogContentState extends State<_GameDialogContent> {
  late GameDialogValue value;

  @override
  void initState() {
    super.initState();
    _initValue();
  }

  @override
  void didUpdateWidget(covariant _GameDialogContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dialog.id != widget.dialog.id) {
      _initValue();
    }
  }

  void _initValue() {
    var newValue = GameDialogValue();
    for (var i = 0; i < widget.dialog.components.length; i++) {
      final component = widget.dialog.components[i];
      if (component is GameDialogTextFieldComponent) {
        newValue = newValue.copyWith.values.put(
          component.idOrLabel,
          GameDialogTextFieldValue(value: '', component: i),
        );
      } else if (component is GameDialogCheckboxComponent) {
        newValue = newValue.copyWith.values.put(
          component.idOrLabel,
          GameDialogCheckboxValue(value: component.initialValue, component: i),
        );
      } else if (component is GameDialogDropdownComponent) {
        newValue = newValue.copyWith.values.put(
          component.idOrLabel,
          GameDialogDropdownValue(
            value:
                component.initialValue ??
                component.options.firstOrNull?.value ??
                '',
            component: i,
          ),
        );
      }
    }
    value = newValue;
  }

  void updateValue(GameDialogValue newValue) {
    setState(() {
      value = newValue;
    });
  }

  void submitValue([GameDialogValue? newValue]) {
    context.read<WorldBloc>().process(
      DialogCloseRequest(widget.dialog.id, newValue ?? value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final header = widget.image == null
        ? null
        : Image.memory(widget.image!, height: 200);

    final isMobile = MediaQuery.of(context).size.width < LeapBreakpoints.medium;

    return Stack(
      children: [
        GestureDetector(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withValues(alpha: 0.5)),
          ),
          onTap: () {
            submitValue();
          },
        ),
        ResponsiveAlertDialog(
          title: Text(widget.dialog.title),
          leading: IconButton.outlined(
            icon: const Icon(PhosphorIconsLight.x),
            onPressed: () => submitValue(),
          ),
          constraints: BoxConstraints(
            maxWidth: header == null
                ? LeapBreakpoints.medium
                : LeapBreakpoints.expanded,
          ),
          content: Row(
            children: [
              if (!isMobile && header != null) Expanded(child: header),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.dialog.components.length + 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, cIndex) {
                    if (cIndex == 0) {
                      return Column(
                        children: [
                          if (isMobile && header != null) header,
                          Card.filled(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Icon(PhosphorIconsLight.warning),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .thirdPartyContent,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    cIndex--;
                    final component = widget.dialog.components[cIndex];
                    switch (component) {
                      case GameDialogMarkdownComponent():
                        return MarkdownWidget(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          markdownGenerator: MarkdownGenerator(
                            extensionSet: md.ExtensionSet(
                              md.ExtensionSet.gitHubWeb.blockSyntaxes,
                              <md.InlineSyntax>[
                                md.EmojiSyntax(),
                                ...md.ExtensionSet.gitHubWeb.inlineSyntaxes,
                              ],
                            ),
                          ),
                          data: component.content,
                        );
                      case GameDialogTextFieldComponent():
                        final multiline =
                            component.multiline && !component.password;
                        final initialValue = value
                            .getValue(component.idOrLabel)
                            .getAsString();
                        void updateComponent(String text) => updateValue(
                          value.copyWith.values.put(
                            component.idOrLabel,
                            GameDialogTextFieldValue(
                              value: text,
                              component: cIndex,
                            ),
                          ),
                        );
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: component.label,
                            hintText: component.placeholder,
                            filled: !multiline,
                            border: multiline
                                ? const OutlineInputBorder()
                                : null,
                          ),
                          maxLines: multiline ? null : 1,
                          obscureText: component.password,
                          initialValue: initialValue,
                          onChanged: updateComponent,
                        );
                      case GameDialogCheckboxComponent():
                        final initialValue = value.hasValue(component.idOrLabel)
                            ? value.getValue(component.idOrLabel).getAsBool()
                            : component.initialValue;
                        void updateComponent(bool? val) => updateValue(
                          value.copyWith.values.put(
                            component.idOrLabel,
                            GameDialogCheckboxValue(
                              value: val ?? false,
                              component: cIndex,
                            ),
                          ),
                        );
                        return CheckboxListTile(
                          title: Text(component.label),
                          value: initialValue,
                          onChanged: updateComponent,
                        );
                      case GameDialogDropdownComponent():
                        final initialValue = value.hasValue(component.idOrLabel)
                            ? value.getValue(component.idOrLabel).getAsString()
                            : component.initialValue ??
                                  component.options.firstOrNull?.value ??
                                  '';
                        void updateComponent(String? val) => updateValue(
                          value.copyWith.values.put(
                            component.idOrLabel,
                            GameDialogDropdownValue(
                              value: val ?? '',
                              component: cIndex,
                            ),
                          ),
                        );
                        return DropdownMenu<String>(
                          label: Text(component.label),
                          expandedInsets: EdgeInsets.symmetric(vertical: 4),
                          initialSelection: initialValue.isEmpty
                              ? null
                              : initialValue,
                          dropdownMenuEntries: component.options
                              .map(
                                (e) => DropdownMenuEntry(
                                  value: e.value,
                                  label: e.idOrLabel,
                                ),
                              )
                              .toList(),
                          onSelected: updateComponent,
                        );
                    }
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                submitValue();
              },
              child: Text(AppLocalizations.of(context).cancel),
            ),
            ...(widget.dialog.actions?.mapIndexed((index, action) {
                  return ElevatedButton(
                    onPressed: () {
                      submitValue(
                        value.copyWith(buttonPressed: action.idOrLabel),
                      );
                    },
                    child: Text(action.label),
                  );
                }) ??
                [
                  ElevatedButton(
                    onPressed: () {
                      submitValue();
                    },
                    child: Text(AppLocalizations.of(context).save),
                  ),
                ]),
          ],
        ),
      ],
    );
  }
}
