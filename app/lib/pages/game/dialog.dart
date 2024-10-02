import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka_api/quokka_api.dart';

class GameDialogOverlay extends StatelessWidget {
  const GameDialogOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, ClientWorldState>(
      builder: (context, state) {
        final dialog = state.world.dialogs.firstOrNull;
        if (dialog == null) {
          return const SizedBox();
        }
        var value = GameDialogValue();
        void updateValue(GameDialogValue newValue) {
          value = newValue;
        }

        void submitValue([GameDialogValue? newValue]) {
          updateValue(newValue ?? value);
          context.read<WorldBloc>().process(
                DialogCloseRequest(dialog.id, value),
              );
        }

        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            ResponsiveAlertDialog(
              title: Text(dialog.title),
              leading: IconButton.outlined(
                icon: const Icon(PhosphorIconsLight.x),
                onPressed: () => submitValue(),
              ),
              constraints:
                  const BoxConstraints(maxWidth: LeapBreakpoints.compact),
              content: ListView(
                shrinkWrap: true,
                children: dialog.components.mapIndexed((cIndex, component) {
                  switch (component) {
                    case GameDialogMarkdownComponent():
                      return MarkdownBody(
                        extensionSet: md.ExtensionSet(
                          md.ExtensionSet.gitHubWeb.blockSyntaxes,
                          <md.InlineSyntax>[
                            md.EmojiSyntax(),
                            ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
                          ],
                        ),
                        data: component.content,
                      );
                    case GameDialogTextFieldComponent():
                      return TextFormField(
                        decoration: InputDecoration(
                          labelText: component.label,
                          hintText: component.placeholder,
                          filled: !component.multiline,
                          border: component.multiline
                              ? const OutlineInputBorder()
                              : null,
                        ),
                        maxLines: (component.multiline && !component.password)
                            ? null
                            : 1,
                        obscureText: component.password,
                        onChanged: (input) {
                          updateValue(
                            value.copyWith.values.put(
                              component.idOrLabel,
                              GameDialogTextFieldValue(
                                value: input,
                                component: cIndex,
                              ),
                            ),
                          );
                        },
                      );
                    case GameDialogActionRowComponent():
                      return Wrap(
                        children: component.actions.mapIndexed((index, action) {
                          return ElevatedButton(
                            onPressed: () {
                              submitValue(
                                value.copyWith.values.put(
                                  action.idOrLabel,
                                  GameDialogButtonValue(
                                    label: action.label,
                                    index: index,
                                    component: cIndex,
                                  ),
                                ),
                              );
                            },
                            child: Text(action.label),
                          );
                        }).toList(),
                      );
                  }
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
