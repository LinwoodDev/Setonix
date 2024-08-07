import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/pages/home/create.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka/widgets/loading.dart';

class PlayDialog extends StatefulWidget {
  const PlayDialog({super.key});

  @override
  State<PlayDialog> createState() => _PlayDialogState();
}

class _PlayDialogState extends State<PlayDialog> with TickerProviderStateMixin {
  String? _selectedGame;
  late final TypedKeyFileSystem<QuokkaData> _worldSystem;
  late Stream<Map<String, QuokkaData>> _gamesStream;

  @override
  void initState() {
    super.initState();
    _worldSystem = context.read<QuokkaFileSystem>().worldSystem;
    _gamesStream = () async* {
      await _worldSystem.initialize();
      yield* _worldSystem.fetchFiles();
    }();
  }

  @override
  Widget build(BuildContext context) {
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
              child: StreamBuilder(
                  stream: _gamesStream,
                  builder: (context, snapshot) {
                    final games = snapshot.data?.entries.toList();
                    if (games == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (games.isEmpty) {
                      return Center(
                        child: Text(AppLocalizations.of(context).noGames),
                      );
                    }
                    return ListView.builder(
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        final entry = games[index];
                        final name = entry.key;
                        final selected = _selectedGame == name;
                        return ListTile(
                          title: Text(name),
                          selected: selected,
                          onTap: () => setState(
                              () => _selectedGame = selected ? null : name),
                        );
                      },
                    );
                  }),
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
                          onPressed: () => GoRouter.of(context).go('/game'),
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
                            if (context.mounted) {
                              GoRouter.of(context).go('/game');
                            }
                          },
                          label: Text('Play $_selectedGame'),
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
