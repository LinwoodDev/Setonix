import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix/widgets/game_mode.dart';
import 'package:setonix_api/setonix_api.dart';

class RecentHomeView extends StatefulWidget {
  const RecentHomeView({super.key});

  @override
  State<RecentHomeView> createState() => _RecentHomeViewState();
}

class _RecentHomeViewState extends State<RecentHomeView> {
  Future<List<_RecentGameDetails>>? _detailsFuture;
  List<RecentGameEntry>? _recentGames;

  void _updateDetailsFuture(List<RecentGameEntry> recentGames) {
    if (_recentGames == recentGames) return;
    _recentGames = recentGames;
    _detailsFuture = _loadDetails(recentGames);
  }

  Future<List<_RecentGameDetails>> _loadDetails(
    List<RecentGameEntry> recentGames,
  ) async {
    final fileSystem = context.read<SetonixFileSystem>();
    final packs = await fileSystem.getPacks();
    final packsByNamespace = <String, SetonixData>{};
    for (final file in packs) {
      final pack = file.load();
      packsByNamespace[file.identifier] = pack;
    }

    await fileSystem.worldSystem.initialize();
    final worlds = await fileSystem.worldSystem.getFiles();
    return Future.wait(
      recentGames.map((entry) async {
        SetonixData? data;
        if (!entry.isMultiplayer) {
          data = _findRecentWorld(worlds, entry);
        }
        final modeLocation = data?.getInfoOrDefault().gameMode;
        final modePack = packsByNamespace[modeLocation?.namespace];
        return _RecentGameDetails(
          entry: entry,
          mode: modeLocation == null
              ? null
              : modePack?.getModeItem(modeLocation.id, modeLocation.namespace),
        );
      }),
    );
  }

  SetonixData? _findRecentWorld(
    List<FileSystemFile<SetonixData>> worlds,
    RecentGameEntry entry,
  ) {
    final path = _recentPath(entry.location);
    for (final world in worlds) {
      if (world.pathWithoutLeadingSlash == entry.name ||
          world.fileNameWithoutExtension == entry.name ||
          world.fileName == entry.name ||
          world.pathWithoutLeadingSlash == path ||
          world.fileName == path ||
          world.fileNameWithoutExtension == path) {
        return world.data;
      }
      final metadata = world.data?.getMetadata();
      if (metadata?.name == entry.name) return world.data;
    }
    return null;
  }

  String _recentPath(Uri location) {
    if (!location.isScheme('file')) return location.toString();
    try {
      return location.toFilePath();
    } catch (_) {
      return location.pathSegments.isEmpty
          ? location.path
          : location.pathSegments.last;
    }
  }

  void _openRecent(BuildContext context, RecentGameEntry entry) {
    GoRouter.of(context).goNamed(
      'game',
      pathParameters: {'name': entry.name},
      queryParameters: {
        if (entry.isMultiplayer) 'address': entry.location.toString(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<SettingsCubit, SetonixSettings>(
          buildWhen: (previous, current) =>
              previous.recentGames != current.recentGames,
          builder: (context, state) {
            _updateDetailsFuture(state.recentGames);
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(PhosphorIconsLight.clockCounterClockwise),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).recentGames,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            AppLocalizations.of(context).recentGamesDescription,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (state.recentGames.isEmpty)
                  _RecentEmptyState()
                else
                  FutureBuilder<List<_RecentGameDetails>>(
                    future: _detailsFuture,
                    builder: (context, snapshot) {
                      final details =
                          snapshot.data ??
                          state.recentGames
                              .map((entry) => _RecentGameDetails(entry: entry))
                              .toList();
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            itemCount: details.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                  childAspectRatio: 9 / 8,
                                ),
                            itemBuilder: (context, index) => GameModeTile(
                              label: details[index].entry.name,
                              mode: details[index].mode,
                              multiplayer: details[index].entry.isMultiplayer,
                              sandbox: details[index].mode == null,
                              onTap: () =>
                                  _openRecent(context, details[index].entry),
                            ),
                          );
                        },
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RecentGameDetails {
  final RecentGameEntry entry;
  final PackItem<GameMode>? mode;

  const _RecentGameDetails({required this.entry, this.mode});
}

class _RecentEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(PhosphorIconsLight.cards, size: 42),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context).noRecentGames,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            AppLocalizations.of(context).noRecentGamesDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
