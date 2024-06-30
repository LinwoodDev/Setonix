import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/api/settings.dart';
import 'package:quokka/cubits/settings.dart';
import 'package:quokka/game/board/game.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, QuokkaSettings>(
        title: Text(AppLocalizations.of(context).game),
      ),
      drawer: Drawer(
        child: Center(
          child: Builder(
              builder: (context) => ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        leading: const Icon(PhosphorIconsLight.arrowLeft),
                        title: Text(AppLocalizations.of(context).game),
                        onTap: () => Scaffold.of(context).closeDrawer(),
                      ),
                      ListTile(
                        leading: const Icon(PhosphorIconsLight.gear),
                        title: Text(AppLocalizations.of(context).settings),
                        onTap: () => openSettings(context),
                      ),
                      ListTile(
                        leading: const Icon(PhosphorIconsLight.door),
                        title: Text(AppLocalizations.of(context).home),
                        onTap: () => GoRouter.of(context).go('/'),
                      ),
                    ],
                  )),
        ),
      ),
      body: GameWidget(
        game: BoardGame(),
      ),
    );
  }
}
