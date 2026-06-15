import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/api/save.dart';
import 'package:setonix/helpers/game_mode.dart';
import 'package:setonix/pages/home/create.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix/widgets/game_mode.dart';
import 'package:setonix_api/setonix_api.dart';

class PlayDialog extends StatelessWidget {
  const PlayDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).singleplayer),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
      ),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.expanded,
        maxHeight: 700,
      ),
      content: const PlayView(),
    );
  }
}

class PlayView extends StatefulWidget {
  const PlayView({super.key});

  @override
  State<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView> {
  late final TypedKeyFileSystem<SetonixData> _worldSystem;
  late final SetonixFileSystem _fileSystem;
  late Stream<List<FileSystemFile<SetonixData>>> _gamesStream;
  late Future<List<PackItem<GameMode>>> _modesFuture;
  _GameModeChoice? _selectedMode;

  @override
  void initState() {
    super.initState();
    _fileSystem = context.read<SetonixFileSystem>();
    _worldSystem = _fileSystem.worldSystem;
    _gamesStream = ValueConnectableStream(_fetchGames()).autoConnect();
    _modesFuture = _loadGameModes();
  }

  Stream<List<FileSystemFile<SetonixData>>> _fetchGames() async* {
    await _worldSystem.initialize();
    yield* _worldSystem.fetchFiles();
  }

  void _reloadGames() {
    if (!mounted) return;
    setState(() {
      _gamesStream = ValueConnectableStream(_fetchGames()).autoConnect();
    });
  }

  Future<List<PackItem<GameMode>>> _loadGameModes() async {
    final modes = <PackItem<GameMode>>[];
    for (final file in await _fileSystem.getPacks()) {
      final data = file.load();
      for (final id in data.getModes()) {
        final mode = data.getModeItem(id, file.identifier);
        if (mode != null) modes.add(mode);
      }
    }
    return modes;
  }

  String _choiceLabel(BuildContext context, _GameModeChoice choice) =>
      getGameModeLabel(context, choice.mode);

  bool _matchesMode(FileSystemFile<SetonixData> game) {
    final gameMode = game.data?.getInfoOrDefault().gameMode;
    final selectedMode = _selectedMode?.mode;
    if (selectedMode == null) return gameMode == null;
    return gameMode?.toString() == selectedMode.location.toString();
  }

  void _play(FileSystemFile<SetonixData> game) {
    GoRouter.of(
      context,
    ).goNamed('game', pathParameters: {'name': game.pathWithoutLeadingSlash});
  }

  Future<void> _createGame({bool full = false}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => full
          ? const CreateDialog()
          : CreateDialog(
              initialModeTemplate: _selectedMode?.mode,
              lockedModeSelection: true,
              customOnly: _selectedMode?.mode == null,
            ),
    );
    if (result ?? false) _reloadGames();
  }

  Future<void> _deleteGame(FileSystemFile<SetonixData> game) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteGame),
        content: Text(AppLocalizations.of(context).deleteGameMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context).delete),
          ),
        ],
      ),
    );
    if (!(result ?? false)) return;
    await _worldSystem.deleteFile(game.path);
    _reloadGames();
  }

  List<_GameModeChoice> _buildChoices(List<PackItem<GameMode>> modes) {
    return [...modes.map(_GameModeChoice.new), const _GameModeChoice.custom()]
      ..sort((a, b) {
        if (a.mode == null) return 1;
        if (b.mode == null) return -1;
        return _choiceLabel(context, a).compareTo(_choiceLabel(context, b));
      });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PackItem<GameMode>>>(
      future: _modesFuture,
      builder: (context, modesSnapshot) {
        final modes = modesSnapshot.data;
        if (modes == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final choices = _buildChoices(modes);
        final selected = _selectedMode;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: selected == null
              ? _ModePickerView(
                  key: const ValueKey('modes'),
                  choices: choices,
                  labelBuilder: (choice) => _choiceLabel(context, choice),
                  onCreate: () => _createGame(full: true),
                  onSelected: (choice) => setState(() {
                    _selectedMode = choice;
                  }),
                )
              : _ModeGamesView(
                  key: ValueKey(selected.key),
                  title: _choiceLabel(context, selected),
                  icon: selected.mode == null
                      ? PhosphorIconsLight.paintBrushBroad
                      : PhosphorIconsLight.gameController,
                  gamesStream: _gamesStream,
                  matchesMode: _matchesMode,
                  onBack: () => setState(() => _selectedMode = null),
                  onCreate: _createGame,
                  onImport: () => importFile(
                    context,
                    _fileSystem,
                  ).then((_) => _reloadGames()),
                  onPlay: _play,
                  onDelete: _deleteGame,
                ),
        );
      },
    );
  }
}

class _ModePickerView extends StatelessWidget {
  final List<_GameModeChoice> choices;
  final String Function(_GameModeChoice choice) labelBuilder;
  final VoidCallback onCreate;
  final ValueChanged<_GameModeChoice> onSelected;

  const _ModePickerView({
    super.key,
    required this.choices,
    required this.labelBuilder,
    required this.onCreate,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 20),
                child: _GamesHeader(
                  title: AppLocalizations.of(context).games,
                  subtitle: AppLocalizations.of(
                    context,
                  ).homeSingleplayerDescription,
                  actions: [
                    OutlinedButton.icon(
                      onPressed: onCreate,
                      icon: const Icon(PhosphorIconsLight.plus),
                      label: Text(LeapLocalizations.of(context).create),
                    ),
                  ],
                ),
              ),
            ),
            SliverGrid.builder(
              itemCount: choices.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 350,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 9 / 8,
              ),
              itemBuilder: (context, index) {
                final choice = choices[index];
                return GameModeTile(
                  sandbox: choice.mode == null,
                  label: labelBuilder(choice),
                  mode: choice.mode,
                  onTap: () => onSelected(choice),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ModeGamesView extends StatelessWidget {
  final String title;
  final IconData icon;
  final Stream<List<FileSystemFile<SetonixData>>> gamesStream;
  final bool Function(FileSystemFile<SetonixData> game) matchesMode;
  final VoidCallback onBack;
  final VoidCallback onCreate;
  final VoidCallback onImport;
  final ValueChanged<FileSystemFile<SetonixData>> onPlay;
  final ValueChanged<FileSystemFile<SetonixData>> onDelete;

  const _ModeGamesView({
    super.key,
    required this.title,
    required this.icon,
    required this.gamesStream,
    required this.matchesMode,
    required this.onBack,
    required this.onCreate,
    required this.onImport,
    required this.onPlay,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FileSystemFile<SetonixData>>>(
      stream: gamesStream,
      builder: (context, snapshot) {
        final games = snapshot.data?.where(matchesMode).toList();
        if (games == null) {
          return const Center(child: CircularProgressIndicator());
        }
        games.sort((a, b) {
          final aMetadata = a.data?.getMetadata() ?? const FileMetadata();
          final bMetadata = b.data?.getMetadata() ?? const FileMetadata();
          final aName = aMetadata.name.isEmpty
              ? a.pathWithoutLeadingSlash
              : aMetadata.name;
          final bName = bMetadata.name.isEmpty
              ? b.pathWithoutLeadingSlash
              : bMetadata.name;
          return aName.compareTo(bName);
        });
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 20),
                child: _GamesHeader(
                  title: title,
                  subtitle: AppLocalizations.of(context).recentGamesDescription,
                  leading: IconButton.outlined(
                    onPressed: onBack,
                    icon: const Icon(PhosphorIconsLight.arrowLeft),
                  ),
                  icon: icon,
                  actions: [
                    IconButton.outlined(
                      onPressed: onImport,
                      tooltip: AppLocalizations.of(context).import,
                      icon: const Icon(PhosphorIconsLight.arrowSquareIn),
                    ),
                    FilledButton.icon(
                      onPressed: onCreate,
                      icon: const Icon(PhosphorIconsLight.plus),
                      label: Text(LeapLocalizations.of(context).create),
                    ),
                  ],
                ),
              ),
            ),
            if (games.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _FriendlyInfoState(
                  icon: PhosphorIconsLight.cards,
                  title: AppLocalizations.of(context).noGames,
                  message: AppLocalizations.of(context).noGamesDescription,
                ),
              )
            else
              SliverList.separated(
                itemCount: games.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final game = games[index];
                  return _GameTile(
                    game: game,
                    onPlay: () => onPlay(game),
                    onExport: () =>
                        exportData(context, game.data!, game.fileName),
                    onDelete: () => onDelete(game),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class _GamesHeader extends StatelessWidget {
  final String title, subtitle;
  final IconData? icon;
  final Widget? leading;
  final List<Widget> actions;

  const _GamesHeader({
    required this.title,
    required this.subtitle,
    this.icon,
    this.leading,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 560;
        final titleBlock = Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 12)],
            if (icon != null) ...[
              Icon(icon, size: 36),
              const SizedBox(width: 14),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text(subtitle, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        );
        final actionsBlock = Wrap(spacing: 8, runSpacing: 8, children: actions);
        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleBlock,
              if (actions.isNotEmpty) ...[
                const SizedBox(height: 12),
                actionsBlock,
              ],
            ],
          );
        }
        return Row(
          children: [
            Expanded(child: titleBlock),
            if (actions.isNotEmpty) ...[
              const SizedBox(width: 16),
              actionsBlock,
            ],
          ],
        );
      },
    );
  }
}

class _GameTile extends StatelessWidget {
  final FileSystemFile<SetonixData> game;
  final VoidCallback onPlay, onExport, onDelete;

  const _GameTile({
    required this.game,
    required this.onPlay,
    required this.onExport,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final metadata = game.data?.getMetadata() ?? const FileMetadata();
    final name = metadata.name.isEmpty
        ? game.pathWithoutLeadingSlash
        : metadata.name;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPlay,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: const Icon(PhosphorIconsLight.diceFive),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      game.pathWithoutLeadingSlash,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              MenuAnchor(
                builder: defaultMenuButton(),
                menuChildren: [
                  MenuItemButton(
                    leadingIcon: const Icon(PhosphorIconsLight.export),
                    onPressed: onExport,
                    child: Text(AppLocalizations.of(context).export),
                  ),
                  MenuItemButton(
                    leadingIcon: const Icon(PhosphorIconsLight.trash),
                    onPressed: onDelete,
                    child: Text(AppLocalizations.of(context).delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GameModeChoice {
  final PackItem<GameMode>? mode;

  const _GameModeChoice.custom() : mode = null;
  const _GameModeChoice(this.mode);

  String get key => mode?.location.toString() ?? '';
}

class _FriendlyInfoState extends StatelessWidget {
  final IconData icon;
  final String title, message;

  const _FriendlyInfoState({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 42),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
