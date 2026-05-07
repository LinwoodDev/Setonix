import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/pages/home/accounts.dart';
import 'package:setonix/pages/home/recent.dart';
import 'package:setonix/pages/settings/intro.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/main.dart';
import 'package:setonix/pages/home/background.dart';
import 'package:setonix/pages/home/connect.dart';
import 'package:setonix/pages/home/header.dart';
import 'package:setonix/pages/packs/dialog.dart';
import 'package:setonix/pages/home/play.dart';

import '../../api/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

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

  List<HomeAction> _getItems(BuildContext context) => [
    HomeAction(
      title: AppLocalizations.of(context).singleplayer,
      subtitle: AppLocalizations.of(context).homeSingleplayerDescription,
      icon: PhosphorIconsLight.gameController,
      onTap: () => showDialog(
        context: context,
        builder: (context) => const PlayDialog(),
      ),
    ),
    HomeAction(
      title: AppLocalizations.of(context).multiplayer,
      subtitle: AppLocalizations.of(context).homeMultiplayerDescription,
      icon: PhosphorIconsLight.plugsConnected,
      onTap: () => showDialog(
        context: context,
        builder: (context) => const ServersDialog(),
      ),
    ),
    HomeAction(
      title: AppLocalizations.of(context).packs,
      subtitle: AppLocalizations.of(context).homePacksDescription,
      icon: PhosphorIconsLight.package,
      onTap: () => showDialog(
        context: context,
        builder: (context) => const PacksDialog(),
      ),
    ),
    HomeAction(
      title: AppLocalizations.of(context).accounts,
      subtitle: AppLocalizations.of(context).homeAccountsDescription,
      icon: PhosphorIconsLight.users,
      onTap: () => showDialog(
        context: context,
        builder: (context) => const AccountsDialog(),
      ),
    ),
    HomeAction(
      title: AppLocalizations.of(context).settings,
      subtitle: AppLocalizations.of(context).homeSettingsDescription,
      icon: PhosphorIconsLight.gear,
      onTap: () => openSettings(context),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final items = _getItems(context);
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
        title: Text(applicationName),
        onlyShowOnDesktop: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final controls = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  AppLocalizations.of(context).homeActionPrompt,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              ...items.map((item) => HomeListCard(action: item)),
            ],
          );
          final recently = RecentHomeView();
          return Stack(
            alignment: Alignment.center,
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
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: LeapBreakpoints.expanded,
                  ),
                  child: ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 32),
                    children: [
                      HeaderHomeView(),
                      const SizedBox(height: 8),
                      constraints.maxWidth >= LeapBreakpoints.medium
                          ? Row(
                              spacing: 12,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1, child: controls),
                                Expanded(flex: 2, child: recently),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                controls,
                                const SizedBox(height: 16),
                                recently,
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HomeAction {
  final String title, subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const HomeAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
}

class HomeListCard extends StatelessWidget {
  final HomeAction action;

  const HomeListCard({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: action.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(action.icon, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      action.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      action.subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
