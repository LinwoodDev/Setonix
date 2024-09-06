import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/bloc/world/local.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/bloc/multiplayer.dart';
import 'package:quokka/bloc/settings.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/pages/game/drawer.dart';
import 'package:quokka/pages/home/background.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka_api/quokka_api.dart';

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

typedef Blocs = (MultiplayerCubit, WorldBloc);

class _GamePageState extends State<GamePage> {
  Future<Blocs>? _bloc;
  final ContextMenuController _contextMenuController = ContextMenuController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _bloc = _loadTable();
      });
    });
  }

  Future<Blocs> _initBloc([QuokkaData? data]) async {
    final cubit = MultiplayerCubit();
    final address = widget.address;
    final world = WorldBloc(
      multiplayer: cubit,
      fileSystem: context.read<QuokkaFileSystem>(),
      name: widget.name,
      data: data,
      colorScheme: Theme.of(context).colorScheme,
    );
    await world.assetManager.loadPacks();
    if (address != null) {
      cubit.connect(address);
    }
    return (cubit, world);
  }

  Future<Blocs> _loadTable() async {
    final address = widget.address;
    if (address != null) {
      return _initBloc();
    }
    final worldSystem = context.read<QuokkaFileSystem>().worldSystem;
    final name = widget.name;
    final data = (widget.data ??
            (name == null ? null : await worldSystem.getFile(name))) ??
        QuokkaData.empty();
    return _initBloc(data);
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    final nextColorScheme = Theme.of(context).colorScheme;
    final bloc = await _bloc;
    if (nextColorScheme != bloc?.$2.state.colorScheme) {
      bloc?.$2.process(ColorSchemeChanged(nextColorScheme));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc?.then((bloc) {
      bloc.$1.close();
      bloc.$2.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Blocs>(
        future: _bloc,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final bloc = snapshot.data!;
          return Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (_) => _contextMenuController.remove(),
            child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: bloc.$1),
                  BlocProvider.value(value: bloc.$2),
                ],
                child: BlocBuilder<MultiplayerCubit, MultiplayerState>(
                  buildWhen: (previous, current) =>
                      previous is MultiplayerDisconnectedState !=
                          current is MultiplayerDisconnectedState ||
                      previous is MultiplayerConnectingState !=
                          current is MultiplayerConnectingState,
                  builder: (context, state) {
                    if (state is MultiplayerConnectingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is MultiplayerDisconnectedState) {
                      return _GameErrorView(
                        state: state,
                        onReconnect: () async => (await _bloc)?.$1.reconnect(),
                      );
                    }
                    return Scaffold(
                      appBar: WindowTitleBar<SettingsCubit, QuokkaSettings>(
                        title: Text(AppLocalizations.of(context).game),
                        height: 50,
                        actions: [
                          BlocBuilder<WorldBloc, ClientWorldState>(
                              buildWhen: (previous, current) =>
                                  previous.showHand != current.showHand ||
                                  previous.selectedCell != current.selectedCell,
                              builder: (context, state) {
                                final selected = state.showHand &&
                                    state.selectedCell == null;
                                return IconButton(
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.plusCircle),
                                  selectedIcon: const PhosphorIcon(
                                      PhosphorIconsFill.plusCircle),
                                  isSelected: selected,
                                  tooltip: selected
                                      ? AppLocalizations.of(context)
                                          .enterEditMode
                                      : AppLocalizations.of(context)
                                          .exitEditMode,
                                  onPressed: () => context
                                      .read<WorldBloc>()
                                      .process(HandChanged.toggle()),
                                );
                              })
                        ],
                      ),
                      drawer: const GameDrawer(),
                      body: BlocListener<WorldBloc, WorldState>(
                        listenWhen: (previous, current) =>
                            previous.messages != current.messages,
                        listener: (context, state) {
                          final message = state.messages.lastOrNull;
                          if (message == null) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              width: 300,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLocalizations.of(context).newMessage(
                                          message.author.toString()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(message.content,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Builder(
                            builder: (context) => GameWidget(
                                    game: BoardGame(
                                  bloc: context.read<WorldBloc>(),
                                  contextMenuController: _contextMenuController,
                                  onEscape: () =>
                                      Scaffold.of(context).openDrawer(),
                                ))),
                      ),
                    );
                  },
                )),
          );
        });
  }
}

class _GameErrorView extends StatelessWidget {
  final MultiplayerDisconnectedState state;
  final VoidCallback onReconnect;

  const _GameErrorView({
    required this.state,
    required this.onReconnect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final error = state.error;
    var message = AppLocalizations.of(context).disconnectedMessage;
    if (error is FatalServerEventError) {
      message = switch (error) {
        InvalidPacksError() => AppLocalizations.of(context).invalidPacks,
      };
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const DotsBackground(),
          Card.filled(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: LeapBreakpoints.large,
              ),
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context).disconnected,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall,
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilledButton(
                          onPressed: onReconnect,
                          child: Text(AppLocalizations.of(context).reconnect),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => GoRouter.of(context).go('/'),
                          child: Text(AppLocalizations.of(context).home),
                        ),
                      ],
                    ),
                    if (state.error != null) ...[
                      const SizedBox(height: 16),
                      Text(state.error.toString()),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
