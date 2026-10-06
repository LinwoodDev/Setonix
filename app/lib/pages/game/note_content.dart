import 'package:material_ui/material_ui.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_widget/markdown_widget.dart';

/// Shared, selectable Markdown presentation for the reader and live panel.
class GameNoteContent extends StatelessWidget {
  final String content;

  const GameNoteContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) => MarkdownWidget(
    data: content,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    config: Theme.of(context).brightness == Brightness.dark
        ? MarkdownConfig.darkConfig
        : MarkdownConfig.defaultConfig,
    markdownGenerator: MarkdownGenerator(
      extensionSet: md.ExtensionSet.gitHubWeb,
    ),
  );
}
