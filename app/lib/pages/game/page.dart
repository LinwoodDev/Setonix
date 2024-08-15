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
import 'package:quokka/bloc/multiplayer.dart';
import 'package:quokka/bloc/settings.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/helpers/asset.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/pages/game/multiplayer.dart';
import 'package:quokka/services/file_system.dart';

class GamePage extends StatefulWidget {
  final String? name;
  final String? address;
  final QuokkaData? data;

  const GamePage({
    super.key,
    this.name,
    this.data,
    this.address,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  (MultiplayerCubit, BoardBloc)? _bloc;
  final ContextMenuController _contextMenuController = ContextMenuController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadTable());
  }

  void _initBloc([QuokkaData? data]) => setState(() {
        final cubit = MultiplayerCubit();
        final address = widget.address;
        if (address != null) {
          cubit.connect(address);
        }
        _bloc = (
          cubit,
          BoardBloc(
            multiplayer: cubit,
            fileSystem: context.read<QuokkaFileSystem>(),
            name: widget.name,
            data: data,
            colorScheme: Theme.of(context).colorScheme,
          )
        );
      });

  Future<void> _loadTable() async {
    final address = widget.address;
    if (address != null) {
      _initBloc();
      return;
    }
    final worldSystem = context.read<QuokkaFileSystem>().worldSystem;
    final name = widget.name;
    final data = (widget.data ??
            (name == null ? null : await worldSystem.getFile(name))) ??
        QuokkaData.empty();
    _initBloc(data);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final nextColorScheme = Theme.of(context).colorScheme;
    if (nextColorScheme != _bloc?.$2.state.colorScheme) {
      _bloc?.$2.send(ColorSchemeChanged(nextColorScheme));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _contextMenuController.remove(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _bloc!.$1),
          BlocProvider.value(value: _bloc!.$2),
          RepositoryProvider(
            create: (context) => AssetManager(
              bloc: context.read<BoardBloc>(),
            ),
          ),
        ],
        child: Scaffold(
          appBar: WindowTitleBar<SettingsCubit, QuokkaSettings>(
            title: Text(AppLocalizations.of(context).game),
            height: 50,
            actions: [
              BlocBuilder<BoardBloc, BoardState>(
                  buildWhen: (previous, current) =>
                      previous.showHand != current.showHand ||
                      previous.selectedCell != current.selectedCell,
                  builder: (context, state) => IconButton(
                        icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                        selectedIcon:
                            const PhosphorIcon(PhosphorIconsFill.plusCircle),
                        isSelected:
                            state.showHand && state.selectedCell == null,
                        tooltip: AppLocalizations.of(context).addDeck,
                        onPressed: () => context
                            .read<BoardBloc>()
                            .send(HandChanged.toggle()),
                      ))
            ],
          ),
          drawer: Drawer(
            child: Center(
              child: ListView(
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
                    title: Text(
                        MaterialLocalizations.of(context).backButtonTooltip),
                    onTap: () => Scaffold.of(context).closeDrawer(),
                  ),
                  BlocBuilder<BoardBloc, BoardState>(
                    buildWhen: (previous, current) =>
                        previous.table.background != current.table.background,
                    builder: (context, state) {
                      final assetManager = context.read<AssetManager>();
                      final background = state.table.background;
                      return ListTile(
                          leading: const Icon(PhosphorIconsLight.image),
                          title: Text(AppLocalizations.of(context).background),
                          subtitle: background == null
                              ? null
                              : Text(assetManager
                                  .getTranslations(background.namespace)
                                  .getBackgroundTranslation(background.id)
                                  .name),
                          onTap: () => showLeapBottomSheet(
                              context: context,
                              title: AppLocalizations.of(context).background,
                              childrenBuilder: (_) => assetManager.packs
                                      .expand((e) =>
                                          e.value.getBackgroundItems(e.key))
                                      .map((entry) {
                                    final translation = assetManager
                                        .getTranslations(entry.namespace)
                                        .getBackgroundTranslation(entry.id);
                                    return ListTile(
                                      title: Text(translation.name),
                                      subtitle: translation.description == null
                                          ? null
                                          : Text(translation.description!),
                                      onTap: () {
                                        context.read<BoardBloc>().send(
                                            BackgroundChanged(entry.location));
                                        Navigator.of(context).pop();
                                      },
                                      selected: background == entry.location,
                                    );
                                  }).toList()));
                    },
                  ),
                  Builder(
                      builder: (context) => ListTile(
                            leading: const Icon(PhosphorIconsLight.users),
                            title:
                                Text(AppLocalizations.of(context).multiplayer),
                            onTap: () {
                              Scaffold.of(context).closeDrawer();
                              final multiplayer =
                                  context.read<MultiplayerCubit>();
                              showDialog(
                                context: context,
                                builder: (context) => BlocProvider.value(
                                    value: multiplayer,
                                    child: const MultiplayerDialog()),
                              );
                            },
                          )),
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
              ),
            ),
          ),
          body: Builder(
              builder: (context) => GameWidget(
                      game: BoardGame(
                    bloc: context.read<BoardBloc>(),
                    assetManager: context.read<AssetManager>(),
                    contextMenuController: _contextMenuController,
                    onEscape: () => Scaffold.of(context).openDrawer(),
                  ))),
        ),
      ),
    );
  }
}
