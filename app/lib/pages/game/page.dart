import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/api/settings.dart';
import 'package:quokka/bloc/board.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/bloc/settings.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/services/pack.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardBloc(),
      child: Scaffold(
        appBar: WindowTitleBar<SettingsCubit, QuokkaSettings>(
          title: Text(AppLocalizations.of(context).game),
          height: 50,
          actions: [
            Builder(
                builder: (context) => IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                      tooltip: AppLocalizations.of(context).addDeck,
                      onPressed: () =>
                          context.read<BoardBloc>().add(HandChanged()),
                    ))
          ],
        ),
        drawer: Drawer(
          child: Center(
            child: Builder(
                builder: (context) => ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          leading: const Icon(PhosphorIconsLight.arrowLeft),
                          title: Text(MaterialLocalizations.of(context)
                              .backButtonTooltip),
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
        body: Builder(
            builder: (context) => GameWidget(
                    game: BoardGame(
                  packService: PackService(),
                  bloc: context.read<BoardBloc>(),
                ))),
      ),
    );
  }
}
