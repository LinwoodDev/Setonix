import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PacksDialog extends StatefulWidget {
  const PacksDialog({super.key});

  @override
  State<PacksDialog> createState() => _PacksDialogState();
}

class _PacksDialogState extends State<PacksDialog>
    with TickerProviderStateMixin {
  bool _gridView = false;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).packs),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.expanded,
        maxHeight: 700,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            final tabBar = TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.startOffset,
              indicatorSize: TabBarIndicatorSize.label,
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
            );
            const searchBar = SearchBar(
              constraints: BoxConstraints(
                  minWidth: 200.0, maxWidth: 260.0, minHeight: 56.0),
              leading: PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
              hintText: 'Search',
            );
            if (constraints.maxWidth < LeapBreakpoints.medium) {
              return Column(
                children: [
                  searchBar,
                  const SizedBox(height: 12),
                  tabBar,
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: tabBar),
                const SizedBox(width: 64),
                searchBar,
              ],
            );
          }),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(
                  child: Text(AppLocalizations.of(context).comingSoon),
                ),
              ],
            ),
          ),
        ],
      ),
      leading: IconButton(
        icon: const Icon(PhosphorIconsLight.xCircle),
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
