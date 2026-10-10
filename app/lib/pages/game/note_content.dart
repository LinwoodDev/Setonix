import 'package:material_ui/material_ui.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_widget/markdown_widget.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix_api/setonix_api.dart';

void processNoteAction(WorldBloc bloc, String id) {
  if (bloc.state.world.toolbar.actions.any(
    (action) => action.id == id && action.enabled,
  )) {
    bloc.process(ToolbarActionRequest(id));
  }
}

/// Shared, selectable Markdown presentation for the reader and live panel.
class GameNoteContent extends StatelessWidget {
  final String content;
  final ValueChanged<String>? onOpenNote, onAction;
  final List<ToolbarAction> actions;

  const GameNoteContent({
    super.key,
    required this.content,
    this.onOpenNote,
    this.onAction,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) => MarkdownBlock(
    data: content,
    config: Theme.of(context).brightness == Brightness.dark
        ? MarkdownConfig.darkConfig
        : MarkdownConfig.defaultConfig,
    generator: MarkdownGenerator(
      extensionSet: md.ExtensionSet.gitHubWeb,
      generators: [
        SpanNodeGeneratorWithTag(
          tag: 'a',
          generator: (element, config, visitor) {
            final uri = Uri.tryParse(element.attributes['href'] ?? '');
            if (uri?.scheme == 'action') {
              final id = Uri.decodeComponent(uri!.path);
              final action = actions
                  .where((action) => action.id == id)
                  .firstOrNull;
              return _NoteActionNode(
                label: element.textContent,
                onPressed: action?.enabled == true && onAction != null
                    ? () => onAction!(id)
                    : null,
              );
            }
            if (uri?.scheme == 'note') {
              return LinkNode(
                element.attributes,
                LinkConfig(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                  onTap: (_) =>
                      onOpenNote?.call(Uri.decodeComponent(uri!.path)),
                ),
              );
            }
            return LinkNode(element.attributes, config.a);
          },
        ),
      ],
    ),
  );
}

class _NoteActionNode extends ElementNode {
  final String label;
  final VoidCallback? onPressed;

  _NoteActionNode({required this.label, this.onPressed});

  @override
  InlineSpan build() => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: FilledButton.tonal(onPressed: onPressed, child: Text(label)),
    ),
  );
}
