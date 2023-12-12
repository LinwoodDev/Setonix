import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/api/settings.dart';
import 'package:qeck/game/board.dart';
import 'package:qeck/main.dart';
import 'package:qeck/services/network.dart';
import 'package:qeck/widgets/window.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WindowTitleBar(
        onlyShowOnDesktop: true,
        title: Text(applicationName),
      ),
      drawer: Drawer(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: const PhosphorIcon(PhosphorIconsLight.arrowLeft),
                title:
                    Text(MaterialLocalizations.of(context).backButtonTooltip),
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
            ],
          ),
        ),
      ),
      body: GameWidget(
        game: BoardGame(
          networkingService: context.read<NetworkingService>(),
        ),
        overlayBuilderMap: {
          'controls': (context, game) => isWindow
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: FloatingActionButton.small(
                      onPressed: () => Scaffold.of(context).openDrawer(),
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
