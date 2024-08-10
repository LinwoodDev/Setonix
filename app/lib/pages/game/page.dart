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
import 'package:quokka/bloc/board_state.dart';
import 'package:quokka/bloc/settings.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/services/file_system.dart';

class GamePage extends StatefulWidget {
  final String? name;
  final QuokkaData? data;

  const GamePage({super.key, this.name, this.data});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final ContextMenuController _contextMenuController = ContextMenuController();
  QuokkaData? _data;

  @override
  void initState() {
    super.initState();
    _loadTable();
  }

  Future<void> _loadTable() async {
    final worldSystem = context.read<QuokkaFileSystem>().worldSystem;
    final name = widget.name;
    final data = (widget.data ??
            (name == null ? null : await worldSystem.getFile(name))) ??
        QuokkaData.empty();
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _contextMenuController.remove(),
      child: BlocProvider(
        create: (context) => BoardBloc(
          fileSystem: context.read<QuokkaFileSystem>(),
          name: widget.name,
          data: _data!,
        ),
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
                          BlocBuilder<BoardBloc, BoardState>(
                            buildWhen: (previous, current) =>
                                previous.name != current.name,
                            builder: (context, state) => Text(
                              state.name ?? '',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          const Divider(),
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
                    bloc: context.read<BoardBloc>(),
                    contextMenuController: _contextMenuController,
                  ))),
        ),
      ),
    );
  }
}
