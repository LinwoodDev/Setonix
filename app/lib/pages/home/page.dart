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

  List<(String, IconData, VoidCallback)> _getItems(BuildContext context) => [
    (
      AppLocalizations.of(context).singleplayer,
      PhosphorIconsLight.gameController,
      () => showDialog(
        context: context,
        builder: (context) => const PlayDialog(),
      ),
    ),
    (
      AppLocalizations.of(context).multiplayer,
      PhosphorIconsLight.plugsConnected,
      () => showDialog(
        context: context,
        builder: (context) => const ServersDialog(),
      ),
    ),
    (
      AppLocalizations.of(context).packs,
      PhosphorIconsLight.package,
      () => showDialog(
        context: context,
        builder: (context) => const PacksDialog(),
      ),
    ),
    (
      AppLocalizations.of(context).accounts,
      PhosphorIconsLight.users,
      () => showDialog(
        context: context,
        builder: (context) => const AccountsDialog(),
      ),
    ),
    (
      AppLocalizations.of(context).settings,
      PhosphorIconsLight.gear,
      () => openSettings(context),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...items.map(
                (item) => HomeListCard(
                  icon: Icon(item.$2),
                  title: Text(item.$1),
                  onTap: item.$3,
                ),
              ),
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
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: LeapBreakpoints.expanded),
                child: ListView(
                  controller: _scrollController,
                  children: [
                    HeaderHomeView(),
                    const SizedBox(height: 16),
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
            ],
          );
        },
      ),
    );
  }
}

class HomeListCard extends StatelessWidget {
  final Widget icon, title;
  final VoidCallback onTap;

  const HomeListCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconTheme(
                data: Theme.of(context).iconTheme.copyWith(size: 32),
                child: icon,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DefaultTextStyle(
                  style: TextTheme.of(context).titleLarge ?? const TextStyle(),
                  child: title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
