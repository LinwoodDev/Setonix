import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka_api/quokka_api.dart';

class GameDialogOverlay extends StatefulWidget {
  const GameDialogOverlay({super.key});

  @override
  State<GameDialogOverlay> createState() => _GameDialogOverlayState();
}

class _GameDialogOverlayState extends State<GameDialogOverlay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, ClientWorldState>(
      builder: (context, state) {
        final dialog = state.world.dialogs.firstOrNull;
        if (dialog == null) {
          return const SizedBox();
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
                onPressed: () => context
                    .read<WorldBloc>()
                    .process(DialogCloseRequest(dialog.id, {})),
              ),
              constraints:
                  const BoxConstraints(maxWidth: LeapBreakpoints.compact),
              content: ListView(
                shrinkWrap: true,
                children: dialog.components.map((component) {
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
                    case GameDialogActionRowComponent():
                      return Wrap(
                        children: component.actions.map((action) {
                          return ElevatedButton(
                            onPressed: () {},
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
