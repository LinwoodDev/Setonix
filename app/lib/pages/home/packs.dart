import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/models/definitions/meta.dart';
import 'package:quokka/models/definitions/pack.dart';
import 'package:quokka/services/packs.dart';
import 'package:quokka/widgets/search.dart';

class PacksDialog extends StatefulWidget {
  const PacksDialog({super.key});

  @override
  State<PacksDialog> createState() => _PacksDialogState();
}

class _PacksDialogState extends State<PacksDialog>
    with TickerProviderStateMixin {
  bool _gridView = false;
  bool _isMobileOpen = false;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  late final TabController _tabController;
  Future<Map<String, PackData>>? _packsFuture;
  (PackData, String, bool)? _selectedPack;

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
    _packsFuture = context.read<PacksService>().getPacks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _buildDetailsChildren(PackData pack, PackMetadata? metadata) {
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
    PackData pack, {
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

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.sizeOf(context).width;
    final isMobile = currentSize < LeapBreakpoints.medium;
    final onInstall = _selectedPack?.$3 ?? false ? null : _deselectPack;
    final onRemove =
        (_selectedPack?.$3 ?? false) && (_selectedPack?.$2.isNotEmpty ?? true)
            ? _deselectPack
            : null;
    Future<void> selectPack(PackData pack, String id, bool installed) async {
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
            tabs: const [
              HorizontalTab(
                icon: PhosphorIcon(PhosphorIconsLight.folder),
                label: Text('Installed'),
              ),
              HorizontalTab(
                icon: PhosphorIcon(PhosphorIconsLight.globe),
                label: Text('Browse'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<Map<String, PackData>>(
              future: _packsFuture,
              builder: (context, snapshot) {
                final packs = snapshot.data?.entries.toList() ?? [];
                final view = TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      itemCount: packs.length,
                      itemBuilder: (context, index) {
                        final key = packs[index].key;
                        final pack = packs[index].value;
                        final metadata = pack.getMetadata();
                        return ListTile(
                          title: Text(metadata?.name ??
                              AppLocalizations.of(context).unnamed),
                          selected: _selectedPack?.$1 == pack &&
                              (!isMobile || _isMobileOpen),
                          onTap: () => selectPack(pack, key, true),
                        );
                      },
                    ),
                    Center(
                      child: Text(AppLocalizations.of(context).comingSoon),
                    ),
                  ],
                );
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
                                      ..._buildActionsChildren(
                                        pack,
                                        onInstall: onInstall,
                                        onRemove: onRemove,
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
        IconButton(
          icon: Icon(_gridView
              ? PhosphorIconsLight.list
              : PhosphorIconsLight.gridFour),
          onPressed: () => setState(() => _gridView = !_gridView),
        ),
        const SizedBox(height: 32, child: VerticalDivider()),
        IconButton(
          icon: const Icon(PhosphorIconsBold.arrowSquareIn),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
