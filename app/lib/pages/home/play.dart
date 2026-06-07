import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/api/save.dart';
import 'package:setonix/pages/home/create.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/widgets/search.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:rxdart/rxdart.dart';

class PlayDialog extends StatefulWidget {
  const PlayDialog({super.key});

  @override
  State<PlayDialog> createState() => _PlayDialogState();
}

class _PlayDialogState extends State<PlayDialog> with TickerProviderStateMixin {
  late final TypedKeyFileSystem<SetonixData> _worldSystem;
  late final SetonixFileSystem _fileSystem;
  late Stream<List<FileSystemFile<SetonixData>>> _gamesStream;
  FileSystemFile<SetonixData>? _selected;
  Future<Map<String, String>>? _modeLabelsFuture;
  String? _modeLabelsKey;
  bool _isMobileOpen = false;

  String _search = '';

  @override
  void initState() {
    super.initState();
    _fileSystem = context.read<SetonixFileSystem>();
    _worldSystem = _fileSystem.worldSystem;
    _gamesStream = ValueConnectableStream(_fetchGames()).autoConnect();
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

  List<Widget> _buildDetailsChildren(FileMetadata metadata) => [
    if (metadata.description.isNotEmpty)
      Padding(
        padding: const EdgeInsets.all(16),
        child: Text(metadata.description),
      )
    else
      Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          AppLocalizations.of(context).noGameDescription,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
  ];

  List<_GameModeGroup> _groupGamesByMode(
    List<FileSystemFile<SetonixData>> games,
  ) {
    final groups = <String, _GameModeGroup>{};
    for (final game in games) {
      final mode = game.data?.getInfoOrDefault().gameMode;
      final key = mode?.toString() ?? '';
      groups
          .putIfAbsent(key, () => _GameModeGroup(key: key, location: mode))
          .games
          .add(game);
    }
    return groups.values.toList();
  }

  Future<Map<String, String>> _loadModeLabels(
    Iterable<_GameModeGroup> groups,
    Locale locale,
  ) async {
    final labels = <String, String>{};
    for (final group in groups) {
      final location = group.location;
      if (location == null) continue;
      final pack = await _fileSystem.getPack(location.namespace);
      final data = pack?.load();
      final translations = data?.getTranslationsStore(
        getLocale: () => locale.languageCode,
      );
      labels[group.key] =
          translations?.getModeTranslation(location.id).name ??
          location.toString();
    }
    return labels;
  }

  Future<Map<String, String>> _getModeLabelsFuture(
    Iterable<_GameModeGroup> groups,
    Locale locale,
  ) {
    final groupKeys = groups.map((group) => group.key).toList()..sort();
    final key = '${locale.languageCode}:${groupKeys.join('|')}';
    if (_modeLabelsKey != key) {
      _modeLabelsKey = key;
      _modeLabelsFuture = _loadModeLabels(groups, locale);
    }
    return _modeLabelsFuture!;
  }

  String _modeGroupLabel(
    BuildContext context,
    _GameModeGroup group,
    Map<String, String> labels,
  ) => group.location == null
      ? AppLocalizations.of(context).custom
      : labels[group.key] ?? group.location.toString();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < LeapBreakpoints.medium;
    Widget buildPlayButton(FileSystemFile<SetonixData>? selected) => SizedBox(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FilledButton.icon(
              icon: const Icon(PhosphorIconsLight.play),
              label: Text(AppLocalizations.of(context).play),
              onPressed: selected == null
                  ? null
                  : () => GoRouter.of(context).goNamed(
                      'game',
                      pathParameters: {
                        'name': selected.pathWithoutLeadingSlash,
                      },
                    ),
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              IconButton.outlined(
                icon: const Icon(PhosphorIconsLight.export),
                onPressed: selected == null
                    ? null
                    : () => exportData(
                        context,
                        selected.data!,
                        selected.fileName,
                      ),
              ),
              const SizedBox(width: 8),
              IconButton.outlined(
                icon: const Icon(PhosphorIconsLight.trash),
                tooltip: AppLocalizations.of(context).delete,
                onPressed: selected == null
                    ? null
                    : () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(AppLocalizations.of(context).deleteGame),
                          content: Text(
                            AppLocalizations.of(context).deleteGameMessage,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(AppLocalizations.of(context).cancel),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _worldSystem.deleteFile(selected.path);
                                Navigator.of(context).pop();
                                if (_isMobileOpen) Navigator.of(context).pop();
                                _selected = null;
                                _reloadGames();
                              },
                              child: Text(AppLocalizations.of(context).delete),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
    final metadata = _selected?.data?.getMetadata() ?? const FileMetadata();
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(PhosphorIconsLight.diceFive),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  metadata.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: ListView(children: _buildDetailsChildren(metadata))),
        const SizedBox(height: 16),
        buildPlayButton(_selected),
      ],
    );
    final listView = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: StreamBuilder(
            stream: _gamesStream,
            builder: (context, snapshot) {
              final games = snapshot.data
                  ?.where(
                    (e) => e.pathWithoutLeadingSlash.toLowerCase().contains(
                      _search.toLowerCase(),
                    ),
                  )
                  .toList();
              if (games == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (games.isEmpty) {
                return _FriendlyInfoState(
                  icon: PhosphorIconsLight.cards,
                  title: AppLocalizations.of(context).noGames,
                  message: AppLocalizations.of(context).noGamesDescription,
                );
              }
              final groups = _groupGamesByMode(games);
              return FutureBuilder(
                future: _getModeLabelsFuture(
                  groups,
                  Localizations.localeOf(context),
                ),
                builder: (context, labelSnapshot) {
                  final labels = labelSnapshot.data ?? const <String, String>{};
                  groups.sort((a, b) {
                    if (a.location == null && b.location != null) return -1;
                    if (a.location != null && b.location == null) return 1;
                    return _modeGroupLabel(
                      context,
                      a,
                      labels,
                    ).compareTo(_modeGroupLabel(context, b, labels));
                  });

                  return ListView(
                    children: groups.expand((group) {
                      final entries = group.games.toList()
                        ..sort((a, b) {
                          final aMetadata =
                              a.data?.getMetadata() ?? const FileMetadata();
                          final bMetadata =
                              b.data?.getMetadata() ?? const FileMetadata();
                          final aName = aMetadata.name.isEmpty
                              ? a.pathWithoutLeadingSlash
                              : aMetadata.name;
                          final bName = bMetadata.name.isEmpty
                              ? b.pathWithoutLeadingSlash
                              : bMetadata.name;
                          return aName.compareTo(bName);
                        });

                      return [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16,
                            16,
                            16,
                            4,
                          ),
                          child: Text(
                            _modeGroupLabel(context, group, labels),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        ...entries.map((entry) {
                          final name = entry.pathWithoutLeadingSlash;
                          final metadata =
                              entry.data?.getMetadata() ?? const FileMetadata();
                          return ListTile(
                            leading: const Icon(PhosphorIconsLight.diceFive),
                            title: Text(
                              metadata.name.isEmpty ? name : metadata.name,
                            ),
                            subtitle: Text(name),
                            onTap: () {
                              setState(() {
                                _selected = entry;
                                _isMobileOpen = isMobile;
                              });
                              if (isMobile) {
                                showLeapBottomSheet(
                                  context: context,
                                  titleBuilder: (context) =>
                                      Text(metadata.name),
                                  childrenBuilder: (context) => [
                                    ..._buildDetailsChildren(metadata),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildPlayButton(entry),
                                    ),
                                  ],
                                ).then((_) {
                                  if (mounted) {
                                    setState(() => _isMobileOpen = false);
                                  }
                                });
                              }
                            },
                            selected:
                                name == _selected?.pathWithoutLeadingSlash &&
                                (!isMobile || _isMobileOpen),
                          );
                        }),
                      ];
                    }).toList(),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            IconButton.outlined(
              onPressed: () =>
                  importFile(context, _fileSystem).then((_) => _reloadGames()),
              tooltip: AppLocalizations.of(context).import,
              icon: const Icon(PhosphorIconsLight.arrowSquareIn),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  icon: const Icon(PhosphorIconsLight.plus),
                  label: Text(LeapLocalizations.of(context).create),
                  onPressed: () =>
                      showDialog<bool>(
                        context: context,
                        builder: (context) => const CreateDialog(),
                      ).then((result) {
                        if (!(result ?? false)) return;
                        _reloadGames();
                      }),
                ),
              ),
            ),
          ],
        ),
      ],
    );
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
      content: Column(
        children: [
          RowSearchView(
            onSearchChanged: (value) => setState(() {
              _search = value;
            }),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: listView),
                if (!isMobile) ...[
                  const VerticalDivider(),
                  Expanded(
                    child: _selected == null
                        ? _FriendlyInfoState(
                            icon: PhosphorIconsLight.handTap,
                            title: AppLocalizations.of(context).selectGame,
                            message: AppLocalizations.of(
                              context,
                            ).selectGameDescription,
                          )
                        : details,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GameModeGroup {
  final String key;
  final ItemLocation? location;
  final List<FileSystemFile<SetonixData>> games = [];

  _GameModeGroup({required this.key, required this.location});
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
