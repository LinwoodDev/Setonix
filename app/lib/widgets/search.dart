import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/widgets/two_child_row_layout.dart';

const searchConstraints =
    BoxConstraints(minWidth: 200.0, maxWidth: 260.0, minHeight: 56.0);

class TabSearchView extends StatelessWidget {
  final TabController? tabController;
  final TextEditingController? searchController;
  final List<Widget> tabs;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;
  final ValueChanged<int>? onTabTap;

  const TabSearchView({
    super.key,
    this.tabController,
    this.searchController,
    required this.tabs,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onTabTap,
  });

  @override
  Widget build(BuildContext context) {
    final tabBar = TabBar(
      controller: tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.label,
      onTap: onTabTap,
      tabs: tabs,
    );
    final searchBar = SearchBar(
      constraints: const BoxConstraints(
          minWidth: 200.0, maxWidth: 260.0, minHeight: 56.0),
      leading: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
      hintText: AppLocalizations.of(context).search,
      onChanged: onSearchChanged,
      onSubmitted: onSearchSubmitted,
      controller: searchController,
    );
    return TwoChildRowLayout(
      primary: tabBar,
      second: searchBar,
      breakpoint: LeapBreakpoints.medium,
    );
  }
}

class RowSearchView extends StatefulWidget {
  final List<Widget> children;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;
  final ValueChanged<int>? onTabTap;

  const RowSearchView({
    super.key,
    this.children = const [],
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onTabTap,
  });

  @override
  State<RowSearchView> createState() => _RowSearchViewState();
}

class _RowSearchViewState extends State<RowSearchView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabBar = widget.children.isEmpty
        ? const SizedBox()
        : SizedBox(
            height: 56,
            child: Scrollbar(
              controller: _scrollController,
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.children.length,
                itemBuilder: (context, index) => widget.children[index],
                separatorBuilder: (context, index) => const SizedBox(width: 8),
              ),
            ),
          );
    final searchBar = SearchBar(
      constraints: const BoxConstraints(
          minWidth: 200.0, maxWidth: 260.0, minHeight: 56.0),
      leading: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
      hintText: AppLocalizations.of(context).search,
      onChanged: widget.onSearchChanged,
      onSubmitted: widget.onSearchSubmitted,
    );
    return TwoChildRowLayout(primary: tabBar, second: searchBar);
  }
}
