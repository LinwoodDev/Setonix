import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/pages/home/create.dart';
import 'package:quokka/widgets/loading.dart';

class PlayDialog extends StatefulWidget {
  const PlayDialog({super.key});

  @override
  State<PlayDialog> createState() => _PlayDialogState();
}

class _PlayDialogState extends State<PlayDialog> with TickerProviderStateMixin {
  int? _selectedGame;

  @override
  Widget build(BuildContext context) {
    final games = List.generate(30, (index) => 'Game ${index + 1}');
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).play),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.compact,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Material(
              type: MaterialType.transparency,
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(games[index]),
                    selected: _selectedGame == index,
                    onTap: () => setState(() =>
                        _selectedGame = index == _selectedGame ? null : index),
                  );
                },
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: _selectedGame != null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: IconButton.filledTonal(
                          icon: const Icon(PhosphorIconsLight.info),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () async {
                            final controller = showLoadingOverlay(context);
                            await Future.delayed(const Duration(seconds: 2));
                            controller.setLabel('Loading world...');
                            await Future.delayed(const Duration(seconds: 2));
                            controller.setLabel('Starting game...');
                            await Future.delayed(const Duration(seconds: 2));
                            controller.setLabel('Game started!');
                            await Future.delayed(const Duration(seconds: 2));
                            controller.remove();
                          },
                          label: Text('Play ${games[_selectedGame!]}'),
                          icon: const Icon(PhosphorIconsLight.play),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Center(
                        child: IconButton.filledTonal(
                          icon: const Icon(PhosphorIconsLight.x),
                          onPressed: () => setState(() => _selectedGame = null),
                        ),
                      ),
                    ],
                  )
                : FilledButton.icon(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => const CreateDialog(),
                    ),
                    label: Text(AppLocalizations.of(context).create),
                    icon: const Icon(PhosphorIconsLight.plus),
                  ),
          ),
        ],
      ),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
      ),
      headerActions: [
        IconButton(
          icon: const Icon(PhosphorIconsBold.arrowSquareIn),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
