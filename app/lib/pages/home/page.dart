import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/settings.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/main.dart';
import 'package:setonix/pages/home/accounts.dart';
import 'package:setonix/pages/home/connect.dart';
import 'package:setonix/pages/home/header.dart';
import 'package:setonix/pages/home/play.dart';
import 'package:setonix/pages/home/recent.dart';
import 'package:setonix/pages/packs/dialog.dart';
import 'package:setonix/pages/settings/intro.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

const _drawerWidth = 250.0;
const _mobileNavigationBreakpoint = 820.0;

enum HomeView {
  home(PhosphorIcons.house, '/'),
  games(PhosphorIcons.gameController, '/games'),
  servers(PhosphorIcons.plugsConnected, '/servers'),
  library(PhosphorIcons.package, '/library');

  final IconGetter icon;
  final String location;

  const HomeView(this.icon, this.location);

  static HomeView fromLocation(String location) =>
      HomeView.values.firstWhereOrNull((view) => view.location == location) ??
      HomeView.home;

  String getLabel(BuildContext context) => switch (this) {
    HomeView.home => AppLocalizations.of(context).home,
    HomeView.games => AppLocalizations.of(context).games,
    HomeView.servers => AppLocalizations.of(context).servers,
    HomeView.library => AppLocalizations.of(context).library,
  };
}

class HomePage extends StatefulWidget {
  final HomeView view;
  final Widget child;

  const HomePage({super.key, required this.view, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showIntro());
  }

  void _showIntro() {
    if (context.read<SettingsCubit>().state.showIntro) {
      showDialog(context: context, builder: (context) => IntroDialog());
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.view;
    final destinations = HomeView.values;
    final selectedIndex = destinations.indexOf(selected);
    final title = selected.getLabel(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < _mobileNavigationBreakpoint;
        final drawer = _HomeSidebar(
          destinations: destinations,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            if (isMobile) Navigator.of(context).pop();
            context.go(destinations[index].location);
          },
        );
        final content = Scaffold(
          appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
            title: Text(title),
            leading: isMobile
                ? IconButton(
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).openAppDrawerTooltip,
                    icon: const PhosphorIcon(PhosphorIconsLight.list),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  )
                : null,
          ),
          body: widget.child,
        );
        if (!isMobile) {
          return Material(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                drawer,
                Expanded(child: content),
              ],
            ),
          );
        }
        return Scaffold(
          key: _scaffoldKey,
          appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
            title: Text(title),
            leading: IconButton(
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              icon: const PhosphorIcon(PhosphorIconsLight.list),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          drawer: SafeArea(
            child: Drawer(width: _drawerWidth, child: drawer),
          ),
          body: widget.child,
        );
      },
    );
  }
}

class HomeViewPage extends StatelessWidget {
  final HomeView view;

  const HomeViewPage({super.key, required this.view});

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.all(16),
      child: switch (view) {
        HomeView.home => const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderHomeView(),
              SizedBox(height: 16),
              RecentHomeView(),
            ],
          ),
        ),
        HomeView.games => const PlayView(),
        HomeView.servers => const ServersView(),
        HomeView.library => const PacksView(),
      },
    ),
  );
}

class _HomeSidebar extends StatelessWidget {
  final List<HomeView> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const _HomeSidebar({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _drawerWidth,
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Image.asset('images/logo.png', height: 64, width: 64),
              ),
              leadingWidth: 42,
              title: const Text(applicationName, textAlign: TextAlign.center),
              centerTitle: true,
              automaticallyImplyLeading: false,
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final (index, view) in destinations.indexed)
                        _SidebarButton(
                          icon: view.icon,
                          label: view.getLabel(context),
                          selected: index == selectedIndex,
                          onTap: () => onDestinationSelected(index),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            const _AccountSelector(),
            _SidebarButton(
              icon: PhosphorIcons.gear,
              label: AppLocalizations.of(context).settings,
              selected: false,
              onTap: () => openSettings(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarButton extends StatelessWidget {
  final IconGetter icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.of(context);
    return ListTile(
      style: ListTileStyle.drawer,
      title: Text(label),
      leading: Icon(
        icon(selected ? PhosphorIconsStyle.fill : PhosphorIconsStyle.light),
      ),
      onTap: onTap,
      selected: selected,
      selectedColor: scheme.onSurface,
      selectedTileColor: scheme.primaryContainer.withAlpha(200),
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
    );
  }
}

class _AccountSelector extends StatefulWidget {
  const _AccountSelector();

  @override
  State<_AccountSelector> createState() => _AccountSelectorState();
}

class _AccountSelectorState extends State<_AccountSelector> {
  Future<List<SetonixAccount>>? _accountsFuture;
  String? _selected;

  @override
  void initState() {
    super.initState();
    _reloadAccounts();
  }

  void _reloadAccounts() {
    _accountsFuture = context.read<SetonixFileSystem>().getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: FutureBuilder<List<SetonixAccount>>(
        future: _accountsFuture,
        builder: (context, snapshot) {
          final accounts = snapshot.data ?? [];
          if (_selected == null && accounts.isNotEmpty) {
            _selected = accounts.first.name;
          }
          final selectedAccount = accounts
              .where((account) => account.name == _selected)
              .firstOrNull;
          final selectedName =
              selectedAccount?.name.substring(1) ??
              AppLocalizations.of(context).guest;
          return MenuAnchor(
            menuChildren: [
              for (final account in accounts)
                MenuItemButton(
                  leadingIcon: _AccountAvatar(name: account.name.substring(1)),
                  onPressed: () => setState(() => _selected = account.name),
                  child: Text(account.name.substring(1)),
                ),
              if (accounts.isNotEmpty) const Divider(),
              MenuItemButton(
                leadingIcon: const Icon(PhosphorIconsLight.users),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const AccountsDialog(),
                ).then((_) => setState(_reloadAccounts)),
                child: Text(AppLocalizations.of(context).accounts),
              ),
            ],
            builder: (context, controller, child) => Material(
              color: ColorScheme.of(context).surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () =>
                    controller.isOpen ? controller.close() : controller.open(),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _AccountAvatar(name: selectedName),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              AppLocalizations.of(context).accounts,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const Icon(PhosphorIconsLight.caretUpDown),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AccountAvatar extends StatelessWidget {
  final String name;

  const _AccountAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.of(context);
    final initial = name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();
    return CircleAvatar(
      radius: 16,
      backgroundColor: scheme.primaryContainer,
      foregroundColor: scheme.onPrimaryContainer,
      child: Text(initial),
    );
  }
}
