import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/meta.dart';
import 'package:quokka/pages/home/create.dart';
import 'package:quokka/services/file_system.dart';

class PlayDialog extends StatefulWidget {
  const PlayDialog({super.key});

  @override
  State<PlayDialog> createState() => _PlayDialogState();
}

class _PlayDialogState extends State<PlayDialog> with TickerProviderStateMixin {
  late final TypedKeyFileSystem<QuokkaData> _worldSystem;
  late Stream<List<FileSystemFile<QuokkaData>>> _gamesStream;
  FileSystemFile<QuokkaData>? _selected;
  bool _isMobileOpen = false;

  @override
  void initState() {
    super.initState();
    _worldSystem = context.read<QuokkaFileSystem>().worldSystem;
    _gamesStream = _fetchGames().asBroadcastStream();
  }

  Stream<List<FileSystemFile<QuokkaData>>> _fetchGames() async* {
    await _worldSystem.initialize();
    yield* _worldSystem.fetchFiles();
  }

  void _reloadGames() {
    if (!mounted) return;
    setState(() {
      _gamesStream = _fetchGames().asBroadcastStream();
    });
  }

  _buildDetailsChildren(FileMetadata metadata) => [
        if (metadata.description.isNotEmpty)
          Card.filled(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(metadata.description),
            ),
          )
      ];
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < LeapBreakpoints.medium;
    final playButton = SizedBox(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FilledButton.icon(
              icon: const Icon(PhosphorIconsLight.play),
              label: Text(AppLocalizations.of(context).play),
              onPressed: () => GoRouter.of(context).goNamed(
                'game',
                pathParameters: {
                  if (_selected != null) 'name': _selected!.path,
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              IconButton.outlined(
                icon: const Icon(PhosphorIconsLight.export),
                onPressed: () => exportFile(
                  context: context,
                  bytes: _selected?.data?.exportAsBytes() ?? Uint8List(0),
                  fileExtension: 'qka',
                  fileName: _selected?.fileNameWithoutExtension ?? 'game',
                  label: AppLocalizations.of(context).game,
                  mimeType: 'application/octet-stream',
                  uniformTypeIdentifier: 'dev.linwood.quokka.pack',
                ),
              ),
              const SizedBox(width: 8),
              IconButton.outlined(
                icon: const Icon(PhosphorIconsLight.trash),
                tooltip: AppLocalizations.of(context).delete,
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context).deleteGame),
                    content:
                        Text(AppLocalizations.of(context).deleteGameMessage),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(AppLocalizations.of(context).cancel),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _worldSystem.deleteFile(_selected!.path);
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
          child: Text(
            metadata.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: ListView(
            children: _buildDetailsChildren(metadata),
          ),
        ),
        const SizedBox(height: 16),
        playButton,
      ],
    );
    final listView = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: StreamBuilder(
              stream: _gamesStream,
              builder: (context, snapshot) {
                final games = snapshot.data;
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
                    final name = entry.pathWithoutLeadingSlash;
                    return ListTile(
                      title: Text(name),
                      onTap: () {
                        setState(() {
                          _selected = entry;
                          _isMobileOpen = isMobile;
                        });
                        if (isMobile) {
                          final metadata =
                              entry.data?.getMetadata() ?? const FileMetadata();
                          showLeapBottomSheet(
                            context: context,
                            titleBuilder: (context) => Text(metadata.name),
                            childrenBuilder: (context) => [
                              ..._buildDetailsChildren(metadata),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: playButton,
                              ),
                            ],
                          ).then((_) {
                            if (mounted) setState(() => _isMobileOpen = false);
                          });
                        }
                      },
                      selected: name == _selected?.pathWithoutLeadingSlash &&
                          (!isMobile || _isMobileOpen),
                    );
                  },
                );
              }),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            icon: const Icon(PhosphorIconsLight.plus),
            label: Text(AppLocalizations.of(context).create),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const CreateDialog(),
            ).then((_) => _reloadGames()),
          ),
        ),
      ],
    );
    return ResponsiveAlertDialog(
        title: Text(AppLocalizations.of(context).play),
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
            Expanded(
              child: Row(
                children: [
                  Expanded(child: listView),
                  if (!isMobile) ...[
                    const VerticalDivider(),
                    Expanded(
                        child: _selected == null
                            ? Center(
                                child: Text(
                                    AppLocalizations.of(context).selectGame),
                              )
                            : details),
                  ],
                ],
              ),
            ),
          ],
        ));
  }
}
