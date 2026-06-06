import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:setonix/pages/game/auth.dart';
import 'package:setonix/pages/game/dialog.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/board/game.dart';
import 'package:setonix/pages/game/chat.dart';
import 'package:setonix/pages/game/drawer.dart';
import 'package:setonix/pages/game/error.dart';
import 'package:setonix/pages/game/filter.dart';
import 'package:setonix/pages/game/notes.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_plugin/setonix_plugin.dart';
import 'package:window_manager/window_manager.dart';

class GamePage extends StatefulWidget {
  final String? name;
  final String? address;
  final bool secure;
  final SetonixData? data;

  const GamePage({
    super.key,
    this.name,
    this.data,
    this.address,
    this.secure = true,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

typedef Blocs = (MultiplayerCubit, WorldBloc);

class _GamePageState extends State<GamePage>
    with WidgetsBindingObserver, WindowListener {
  Future<Blocs>? _bloc;
  Future<void>? _closeFuture;
  bool _allowPop = false;
  final ContextMenuController _contextMenuController = ContextMenuController();
  final FocusNode _focusNode = FocusNode();

  String? _trimmedOrNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  String _displayLabelFromPath(String value) {
    final normalized = value.replaceAll('\\', '/');
    final segments = normalized
        .split('/')
        .where((segment) => segment.isNotEmpty);
    return segments.isEmpty ? value : segments.last;
  }

  String _resolvePageTitle(BuildContext context, ClientWorldState state) {
    final metadataName = _trimmedOrNull(state.metadata.name);
    if (metadataName != null) return metadataName;

    final gameName = _trimmedOrNull(state.name);
    if (gameName != null) return _displayLabelFromPath(gameName);

    final address = _trimmedOrNull(widget.address);
    if (address != null) {
      final uri = Uri.tryParse(address);
      final host = _trimmedOrNull(uri?.host);
      if (host != null) return host;
      return address;
    }

    return AppLocalizations.of(context).game;
  }

  bool get _canInterceptWindowClose =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (_canInterceptWindowClose) {
      windowManager.addListener(this);
      unawaited(windowManager.setPreventClose(true));
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _bloc = _loadTable();
      });
    });
  }

  Future<void> _closeBlocs() {
    return _closeFuture ??= () async {
      final bloc = await _bloc;
      if (bloc == null) return;
      await bloc.$2.close();
      await bloc.$1.close();
    }();
  }

  Future<void> _releaseWindowCloseInterception() async {
    if (_canInterceptWindowClose) {
      await windowManager.setPreventClose(false);
    }
  }

  Future<void> _goHome() async {
    await _closeBlocs();
    await _releaseWindowCloseInterception();
    if (!mounted) return;
    GoRouter.of(context).go('/');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      unawaited(_closeBlocs());
    }
  }

  @override
  Future<void> onWindowClose() async {
    await _closeBlocs();
    await _releaseWindowCloseInterception();
    await windowManager.close();
  }

  Future<Blocs> _initBloc([SetonixData? data]) async {
    final cubit = MultiplayerCubit(context.read<NetworkService>());
    final address = widget.address;
    final world = WorldBloc(
      multiplayer: cubit,
      fileSystem: context.read<SetonixFileSystem>(),
      name: widget.name,
      data: data,
      colorScheme: Theme.of(context).colorScheme,
      gameState: address == null ? GameState.play : GameState.configuration,
    );
    final name = world.state.name;
    final uri = address != null ? Uri.parse(address) : null;
    if (name != null) {
      context.read<SettingsCubit>().addRecentGame(name, uri ?? Uri.file(name));
    }
    await world.state.assetManager.loadPacks();
    await world.init();
    if (uri != null) {
      cubit.connect(buildServerAddress(uri, widget.secure));
    }
    return (cubit, world);
  }

  Future<Blocs> _loadTable() async {
    final address = widget.address;
    if (address != null) {
      return _initBloc();
    }
    final worldSystem = context.read<SetonixFileSystem>().worldSystem;
    final name = widget.name;
    final data =
        (widget.data ??
            (name == null ? null : await worldSystem.getFile(name))) ??
        SetonixData.empty();
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
    WidgetsBinding.instance.removeObserver(this);
    if (_canInterceptWindowClose) {
      windowManager.removeListener(this);
      unawaited(windowManager.setPreventClose(false));
    }
    super.dispose();
    _focusNode.dispose();
    unawaited(_closeBlocs());
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
                  return GameErrorView(
                    state: state,
                    onReconnect: () async => (await _bloc)?.$1.reconnect(),
                    onHome: _goHome,
                  );
                }
                final game = BoardGame(
                  bloc: context.read<WorldBloc>(),
                  settingsCubit: context.read<SettingsCubit>(),
                  contextMenuController: _contextMenuController,
                  onEscape: () => Scaffold.of(context).openDrawer(),
                );
                return PopScope(
                  canPop: _allowPop,
                  onPopInvokedWithResult: (didPop, result) async {
                    if (didPop) return;
                    await _closeBlocs();
                    await _releaseWindowCloseInterception();
                    if (!context.mounted) return;
                    setState(() => _allowPop = true);
                    Navigator.of(context).pop(result);
                  },
                  child: Scaffold(
                    appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
                      title: BlocBuilder<WorldBloc, ClientWorldState>(
                        buildWhen: (previous, current) =>
                            previous.metadata.name != current.metadata.name ||
                            previous.name != current.name,
                        builder: (context, state) =>
                            Text(_resolvePageTitle(context, state)),
                      ),
                      height: 50,
                      actions: [
                        BlocBuilder<WorldBloc, ClientWorldState>(
                          buildWhen: (previous, current) =>
                              previous.world.toolbar.actions !=
                              current.world.toolbar.actions,
                          builder: (context, state) {
                            final actions = state.world.toolbar.actions;
                            if (actions.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return MenuAnchor(
                              menuChildren: actions
                                  .map(
                                    (action) => MenuItemButton(
                                      onPressed: () {
                                        context.read<WorldBloc>().process(
                                          ToolbarActionRequest(action.id),
                                        );
                                      },
                                      child: Text(action.label),
                                    ),
                                  )
                                  .toList(),
                              builder: defaultFilledMenuButton(
                                icon: Icon(PhosphorIconsLight.play),
                              ),
                            );
                          },
                        ),
                        BlocBuilder<WorldBloc, ClientWorldState>(
                          buildWhen: (previous, current) =>
                              previous.showHand != current.showHand ||
                              previous.selectedCell != current.selectedCell ||
                              previous.world.toolbar.editable !=
                                  current.world.toolbar.editable,
                          builder: (context, state) {
                            if (!state.world.toolbar.editable) {
                              return const SizedBox.shrink();
                            }
                            final selected =
                                state.showHand && state.selectedCell == null;
                            return IconButton(
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.plusCircle,
                              ),
                              selectedIcon: const PhosphorIcon(
                                PhosphorIconsFill.plusCircle,
                              ),
                              isSelected: selected,
                              tooltip: selected
                                  ? AppLocalizations.of(context).enterEditMode
                                  : AppLocalizations.of(context).exitEditMode,
                              onPressed: () {
                                context.read<WorldBloc>().process(
                                  HandChanged.toggle(),
                                );
                                _focusNode.requestFocus();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    drawer: GameDrawer(game: game, onHome: _goHome),
                    endDrawer: BlocBuilder<WorldBloc, ClientWorldState>(
                      buildWhen: (previous, current) =>
                          previous.drawerView != current.drawerView,
                      builder: (context, state) => switch (state.drawerView) {
                        DrawerView.chat => const GameChatDrawer(),
                        DrawerView.notes => const GameNotesDrawer(),
                      },
                    ),
                    body: BlocConsumer<WorldBloc, ClientWorldState>(
                      listenWhen: (previous, current) =>
                          previous.messages.length != current.messages.length,
                      listener: (context, state) {
                        final message = state.messages.lastOrNull;
                        if (message == null || message.author == state.id) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            width: 300,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context).newMessage(
                                    AppLocalizations.of(
                                      context,
                                    ).defaultPlayerName(message.author),
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  message.content,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            action: SnackBarAction(
                              label: AppLocalizations.of(context).open,
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      buildWhen: (previous, current) =>
                          previous.world.gameState != current.world.gameState,
                      builder: (context, state) {
                        final showPluginSystemNote =
                            (kIsWeb || !isPluginSystemInitialized) &&
                            !state.multiplayer.isClient &&
                            state.world.info.gameMode != null;
                        return Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (state.world.gameState ==
                                  GameState.configuration)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    const SizedBox(height: 16),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      ).configuringGame,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ],
                                )
                              else
                                GameWidget(
                                  game: game,
                                  focusNode: _focusNode,
                                  initialActiveOverlays: ['dialogs', 'filter'],
                                  overlayBuilderMap: {
                                    'dialogs': (context, game) =>
                                        GameDialogOverlay(),
                                    'filter': (context, game) =>
                                        GameFilterView(),
                                  },
                                ),
                              if (showPluginSystemNote)
                                Positioned(
                                  left: 16,
                                  right: 16,
                                  top: 16,
                                  child: SafeArea(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxWidth: 560,
                                        ),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.surfaceContainerHigh,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.outlineVariant,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                PhosphorIcon(
                                                  PhosphorIconsLight.info,
                                                  size: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                                const SizedBox(width: 8),
                                                Flexible(
                                                  child: Text(
                                                    kIsWeb
                                                        ? 'Scripted game mode unavailable on web.'
                                                        : 'Scripted game mode unavailable: plugin system failed to load.',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .onSurfaceVariant,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              AuthGameView(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
