import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/settings.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/main.dart';
import 'package:setonix/pages/home/accounts.dart';
import 'package:setonix/pages/home/background.dart';
import 'package:setonix/pages/home/connect.dart';
import 'package:setonix/pages/home/header.dart';
import 'package:setonix/pages/home/play.dart';
import 'package:setonix/pages/home/recent.dart';
import 'package:setonix/pages/packs/dialog.dart';
import 'package:setonix/pages/settings/intro.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

enum _HomeView {
  home(PhosphorIconsLight.house),
  games(PhosphorIconsLight.gameController),
  servers(PhosphorIconsLight.plugsConnected),
  library(PhosphorIconsLight.package);

  final IconData icon;

  const _HomeView(this.icon);

  String getLabel(BuildContext context) => switch (this) {
    _HomeView.home => AppLocalizations.of(context).home,
    _HomeView.games => AppLocalizations.of(context).games,
    _HomeView.servers => AppLocalizations.of(context).servers,
    _HomeView.library => AppLocalizations.of(context).library,
  };
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  _HomeView _view = _HomeView.home;

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildBody() => switch (_view) {
    _HomeView.home => ListView(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      children: const [HeaderHomeView(), SizedBox(height: 8), RecentHomeView()],
    ),
    _HomeView.games => const Padding(
      padding: EdgeInsets.all(16),
      child: PlayView(),
    ),
    _HomeView.servers => const Padding(
      padding: EdgeInsets.all(16),
      child: ServersView(),
    ),
    _HomeView.library => const Padding(
      padding: EdgeInsets.all(16),
      child: PacksView(),
    ),
  };

  @override
  Widget build(BuildContext context) {
    final destinations = _HomeView.values;
    final selectedIndex = destinations.indexOf(_view);
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
        title: Text(applicationName),
        onlyShowOnDesktop: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < LeapBreakpoints.medium;
          return Stack(
            children: [
              ListenableBuilder(
                listenable: _scrollController,
                builder: (context, child) => DotsBackground(
                  offset: _scrollController.hasClients
                      ? _scrollController.offset
                      : 0,
                ),
              ),
              SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HomeSidebar(
                      compact: compact,
                      destinations: destinations,
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() => _view = destinations[index]);
                      },
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(child: _buildBody()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HomeSidebar extends StatelessWidget {
  final bool compact;
  final List<_HomeView> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const _HomeSidebar({
    required this.compact,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: compact ? 84 : 244,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 18, 16, compact ? 18 : 10),
            child: Row(
              mainAxisAlignment: compact
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Image.asset('images/logo.png', width: 36, height: 36),
                if (!compact) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      applicationName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: destinations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final view = destinations[index];
                return _SidebarButton(
                  compact: compact,
                  icon: view.icon,
                  label: view.getLabel(context),
                  selected: index == selectedIndex,
                  onTap: () => onDestinationSelected(index),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: _SidebarButton(
              compact: compact,
              icon: PhosphorIconsLight.gear,
              label: AppLocalizations.of(context).settings,
              selected: false,
              onTap: () => openSettings(context),
            ),
          ),
          _AccountSelector(compact: compact),
        ],
      ),
    );
  }
}

class _SidebarButton extends StatelessWidget {
  final bool compact;
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarButton({
    required this.compact,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.of(context);
    final button = Material(
      color: selected ? scheme.secondaryContainer : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            mainAxisAlignment: compact
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(icon, color: selected ? scheme.onSecondaryContainer : null),
              if (!compact) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: selected ? scheme.onSecondaryContainer : null,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
    if (!compact) return button;
    return Tooltip(message: label, child: button);
  }
}

class _AccountSelector extends StatefulWidget {
  final bool compact;

  const _AccountSelector({required this.compact});

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
                    mainAxisAlignment: widget.compact
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      _AccountAvatar(name: selectedName),
                      if (!widget.compact) ...[
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
