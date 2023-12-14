import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/api/settings.dart';
import 'package:qeck/game/board.dart';
import 'package:qeck/main.dart';
import 'package:qeck/pages/board/connect.dart';
import 'package:qeck/pages/board/create.dart';
import 'package:qeck/pages/board/servers.dart';
import 'package:qeck/services/messenger.dart';
import 'package:qeck/services/network.dart';
import 'package:qeck/widgets/window.dart';

class BoardPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final networkingService = context.read<NetworkingService>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: const WindowTitleBar(
        onlyShowOnDesktop: true,
        title: Text(applicationName),
      ),
      drawer: Drawer(
        child: Center(
          child: StreamBuilder<NetworkMessenger?>(
              stream: networkingService.stream,
              builder: (context, snapshot) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: const PhosphorIcon(PhosphorIconsLight.arrowLeft),
                      title: Text(
                          MaterialLocalizations.of(context).backButtonTooltip),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const PhosphorIcon(PhosphorIconsLight.house),
                      title: Text(AppLocalizations.of(context).home),
                      onTap: () {
                        Navigator.of(context).pop();
                        GoRouter.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const PhosphorIcon(PhosphorIconsLight.gear),
                      title: Text(AppLocalizations.of(context).settings),
                      onTap: () {
                        Navigator.of(context).pop();
                        openSettings(context);
                      },
                    ),
                    const Divider(),
                    if (snapshot.hasData) ...[
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.x),
                        title: Text(AppLocalizations.of(context).disconnect),
                        onTap: () {
                          networkingService.closeNetworking();
                          Navigator.of(context).pop();
                        },
                      ),
                    ] else ...[
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.list),
                        title: Text(AppLocalizations.of(context).servers),
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => const GameServersDialog(),
                          );
                          if (context.mounted) Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: const PhosphorIcon(
                            PhosphorIconsLight.plugsConnected),
                        title: Text(AppLocalizations.of(context).connect),
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => ConnectGameDialog(),
                          );
                          if (context.mounted) Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.plus),
                        title: Text(AppLocalizations.of(context).create),
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => CreateGameDialog(),
                          );
                          if (context.mounted) Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ],
                );
              }),
        ),
      ),
      body: GameWidget(
        game: BoardGame(
          networkingService: context.read<NetworkingService>(),
          onEscape: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        overlayBuilderMap: {
          'controls': (context, game) => isWindow
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: FloatingActionButton.small(
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      child: const PhosphorIcon(PhosphorIconsLight.list),
                    ),
                  ),
                ),
        },
        initialActiveOverlays: const ['controls'],
      ),
    );
  }
}
