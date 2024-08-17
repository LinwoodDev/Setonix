import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/meta.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka/widgets/search.dart';

class PacksDialog extends StatefulWidget {
  const PacksDialog({super.key});

  @override
  State<PacksDialog> createState() => _PacksDialogState();
}

class _PacksDialogState extends State<PacksDialog>
    with TickerProviderStateMixin {
  bool _isMobileOpen = false;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  late final QuokkaFileSystem _service = context.read<QuokkaFileSystem>();
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  Future<List<FileSystemFile<QuokkaData>>>? _packsFuture;
  (QuokkaData, String, bool)? _selectedPack;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _selectedPack = null;
          _isMobileOpen = false;
        });
      }
    });
    _packsFuture = _service.getPacks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _reloadPacks() {
    if (mounted) {
      setState(() {
        _packsFuture = _service.getPacks();
      });
    }
  }

  List<Widget> _buildDetailsChildren(QuokkaData pack, FileMetadata? metadata) {
    if (metadata == null) {
      return [];
    }
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(metadata.description),
      ),
    ];
  }

  List<Widget> _buildActionsChildren(
    QuokkaData pack, {
    VoidCallback? onInstall,
    VoidCallback? onRemove,
  }) =>
      [
        if (onInstall != null) ...[
          SizedBox(
            height: 42,
            child: FilledButton.tonalIcon(
              onPressed: onInstall,
              label: Text(AppLocalizations.of(context).install),
              icon: const Icon(PhosphorIconsLight.download),
            ),
          ),
        ],
        if (onRemove != null) ...[
          SizedBox(
            height: 42,
            child: FilledButton.tonalIcon(
              onPressed: onRemove,
              label: Text(AppLocalizations.of(context).remove),
              icon: const Icon(PhosphorIconsLight.trash),
            ),
          ),
        ],
      ];

  void _deselectPack() => _controller.reverse();

  Future<void> _removePack() async {
    _deselectPack();
    final pack = _selectedPack?.$2;
    if (pack == null) return;
    await _service.packSystem.deleteFile(pack);
    _reloadPacks();
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.sizeOf(context).width;
    final isMobile = currentSize < LeapBreakpoints.medium;
    final onInstall = _selectedPack?.$3 ?? false ? null : _deselectPack;
    final onRemove =
        (_selectedPack?.$3 ?? false) && (_selectedPack?.$2.isNotEmpty ?? true)
            ? _removePack
            : null;
    Future<void> selectPack(QuokkaData pack, String id, bool installed) async {
      _controller.forward();
      setState(() {
        _selectedPack = (pack, id, installed);
        _isMobileOpen = isMobile;
      });
      final metadata = pack.getMetadata();
      if (isMobile) {
        await showLeapBottomSheet(
          context: context,
          childrenBuilder: (context) => [
            ..._buildDetailsChildren(pack, metadata),
            const SizedBox(height: 16),
            ..._buildActionsChildren(pack,
                onInstall: onInstall, onRemove: onRemove),
          ],
          title: pack.getMetadata()?.name ?? '',
        );
        if (mounted) {
          _deselectPack();
        }
      }
    }

    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).packs),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.expanded,
        maxHeight: 700,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabSearchView(
            tabController: _tabController,
            searchController: _searchController,
            tabs: [
              HorizontalTab(
                icon: const PhosphorIcon(PhosphorIconsLight.folder),
                label: Text(AppLocalizations.of(context).installed),
              ),
              HorizontalTab(
                icon: const PhosphorIcon(PhosphorIconsLight.globe),
                label: Text(AppLocalizations.of(context).browse),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<FileSystemFile<QuokkaData>>>(
              future: _packsFuture,
              builder: (context, snapshot) {
                final packs = snapshot.data ?? [];
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context).error,
                            style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 8),
                        Text(snapshot.error.toString()),
                      ],
                    ),
                  );
                }
                final view = ListenableBuilder(
                    listenable: _searchController,
                    builder: (context, _) {
                      final query = _searchController.text.toLowerCase();
                      final filtered = packs
                          .where((entry) =>
                              entry.data
                                  ?.getMetadata()
                                  ?.name
                                  .toLowerCase()
                                  .contains(query) ??
                              entry.fileName.toLowerCase().contains(query))
                          .toList();
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final pack = packs[index];
                              final key = pack.pathWithoutLeadingSlash;
                              final data = pack.data!;
                              final metadata = data.getMetadata();
                              return ListTile(
                                title: Text(metadata?.name ??
                                    AppLocalizations.of(context).unnamed),
                                subtitle: Text(key),
                                selected: _selectedPack?.$1 == data &&
                                    (!isMobile || _isMobileOpen),
                                onTap: () => selectPack(data, key, true),
                              );
                            },
                          ),
                          Center(
                            child:
                                Text(AppLocalizations.of(context).comingSoon),
                          ),
                        ],
                      );
                    });
                if (isMobile) {
                  return view;
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: view,
                    ),
                    SizeTransition(
                      sizeFactor: CurvedAnimation(
                        parent: _controller,
                        curve: Curves.fastOutSlowIn,
                      ),
                      axis: Axis.horizontal,
                      child: SizedBox(
                        width: 300,
                        child: Card(child: Builder(
                          builder: (context) {
                            final pack = _selectedPack?.$1;
                            if (pack == null) {
                              return const SizedBox();
                            }
                            final metadata = pack.getMetadata();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: _selectedPack?.$1 == null
                                  ? []
                                  : [
                                      Header(
                                        title: Text(metadata?.name ?? ''),
                                        actions: [
                                          IconButton.outlined(
                                            icon: const Icon(
                                                PhosphorIconsLight.x),
                                            onPressed: _deselectPack,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView(
                                          children: _buildDetailsChildren(
                                            _selectedPack!.$1,
                                            metadata,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: _buildActionsChildren(
                                            pack,
                                            onInstall: onInstall,
                                            onRemove: onRemove,
                                          ),
                                        ),
                                      ),
                                    ],
                            );
                          },
                        )),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
      ),
      headerActions: [
        /*IconButton(
          icon: Icon(_gridView
              ? PhosphorIconsLight.list
              : PhosphorIconsLight.gridFour),
          onPressed: () => setState(() => _gridView = !_gridView),
        ),
        const SizedBox(height: 32, child: VerticalDivider()),*/
        IconButton(
          tooltip: AppLocalizations.of(context).import,
          onPressed: _importPack,
          icon: const Icon(PhosphorIconsLight.arrowSquareIn),
        ),
      ],
    );
  }

  Future<void> _importPack() async {
    final result = await fs.openFile(
      acceptedTypeGroups: [
        fs.XTypeGroup(
          label: AppLocalizations.of(context).packs,
          extensions: const ['qka'],
          uniformTypeIdentifiers: const ['dev.linwood.quokka.pack'],
          mimeTypes: const ['application/octet-stream', 'application/zip'],
        )
      ],
    );
    if (result == null) return;
    final data = await result.readAsBytes();
    var name = result.name;
    const qka = '.qka';
    if (name.endsWith(qka)) {
      name = name.substring(0, name.length - qka.length);
    }
    final pack = QuokkaData.fromData(data);
    await _service.packSystem.updateFile(
      name,
      pack,
    );

    _reloadPacks();
  }
}
