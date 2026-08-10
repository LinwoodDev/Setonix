part of 'dialog.dart';

class ViewMultiplayerDialog extends StatelessWidget {
  final MultiplayerConnectedState state;

  const ViewMultiplayerDialog({super.key, required this.state});

  Future<void> _moderatePlayer(
    BuildContext context,
    PlayerInfo player, {
    required bool ban,
  }) async {
    final reasonController = TextEditingController();
    var duration = ban ? const Duration(days: 1) : null;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            ban
                ? AppLocalizations.of(context).ban
                : AppLocalizations.of(context).kick,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                player.name ??
                    AppLocalizations.of(context).defaultUserName(player.id),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).reason,
                ),
              ),
              if (ban) ...[
                const SizedBox(height: 12),
                DropdownButtonFormField<Duration?>(
                  initialValue: duration,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).banDuration,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(AppLocalizations.of(context).permanent),
                    ),
                    DropdownMenuItem(
                      value: const Duration(hours: 1),
                      child: Text(AppLocalizations.of(context).oneHour),
                    ),
                    DropdownMenuItem(
                      value: const Duration(days: 1),
                      child: Text(AppLocalizations.of(context).oneDay),
                    ),
                    DropdownMenuItem(
                      value: const Duration(days: 7),
                      child: Text(AppLocalizations.of(context).sevenDays),
                    ),
                  ],
                  onChanged: (value) => setState(() => duration = value),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                ban
                    ? AppLocalizations.of(context).ban
                    : AppLocalizations.of(context).kick,
              ),
            ),
          ],
        ),
      ),
    );
    final reason = reasonController.text.trim();
    reasonController.dispose();
    if (confirmed != true || !context.mounted) return;
    unawaited(
      context.read<WorldBloc>().process(
        ban
            ? BanPlayerRequest(
                player.id,
                reason: reason.isEmpty ? null : reason,
                expiresAt: duration == null
                    ? null
                    : DateTime.now().add(duration!),
              )
            : KickPlayerRequest(
                player.id,
                reason: reason.isEmpty ? null : reason,
              ),
      ),
    );
  }

  Future<void> _changeGameRoles(
    BuildContext context,
    PlayerInfo player,
    Set<String> currentRoles,
  ) async {
    final controller = TextEditingController(text: currentRoles.join(', '));
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).gameRoles),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).commaSeparatedRoles,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(MaterialLocalizations.of(context).saveButtonLabel),
          ),
        ],
      ),
    );
    final roles = controller.text
        .split(',')
        .map((role) => role.trim())
        .where((role) => role.isNotEmpty)
        .toSet();
    controller.dispose();
    if (confirmed != true || !context.mounted) return;
    unawaited(
      context.read<WorldBloc>().process(
        GameRolesChangeRequest(player.id, roles),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final info = FutureBuilder<Uri>(
      future: Future.value(state.getShareAddress()),
      builder: (context, snapshot) {
        final address = snapshot.data?.toString() ?? '?';
        final connect = getConnectUri(address).toString();
        final qr = Barcode.qrCode();
        final svg = qr.toSvg(connect, width: 256, height: 256);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 208,
              width: 208,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                radius: 12,
                onTap: () {
                  exportFile(
                    context: context,
                    bytes: Uint8List.fromList(svg.codeUnits),
                    fileExtension: 'svg',
                    mimeType: 'image/svg',
                    uniformTypeIdentifier: 'public.svg-image',
                    share: true,
                    fileName: 'output',
                    label: AppLocalizations.of(context).export,
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      ColoredBox(color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.string(svg),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              title: Text(AppLocalizations.of(context).url),
              subtitle: Text(address),
              onTap: () => saveToClipboard(context, connect),
            ),
          ],
        );
      },
    );
    final userList = StreamBuilder<Set<Channel>>(
      stream: state.clientChange,
      initialData: context.read<MultiplayerCubit>().clients,
      builder: (context, connectionSnapshot) =>
          BlocBuilder<WorldBloc, ClientWorldState>(
            buildWhen: (previous, current) =>
                previous.world.serverState != current.world.serverState ||
                previous.world.gameRoleMembers != current.world.gameRoleMembers,
            builder: (context, worldState) {
              final serverState = worldState.world.serverState;
              final players = serverState.players.isNotEmpty
                  ? serverState.players
                  : state.isServer
                  ? (connectionSnapshot.data ?? const <Channel>{})
                        .map(
                          (channel) => PlayerInfo(
                            id: channel,
                            name: state.userManager.getUser(channel)?.name,
                          ),
                        )
                        .toList(growable: false)
                  : const <PlayerInfo>[];
              if (players.isEmpty) {
                return Text(
                  AppLocalizations.of(context).noConnections,
                  textAlign: TextAlign.center,
                );
              }
              return ListView.builder(
                itemCount: players.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final player = players[index];
                  final gameRoles = worldState.world.getGameRoles(player.id);
                  final roleNames = player.serverRoles
                      .map(
                        (role) => worldState.assetManager
                            .getRoleTranslation(
                              role,
                              fallback: serverState.serverRoles[role]?.name,
                            )
                            .name,
                      )
                      .toList(growable: false);
                  final gameRoleNames = gameRoles
                      .map(
                        (role) => worldState.assetManager
                            .getRoleTranslation(role)
                            .name,
                      )
                      .toList(growable: false);
                  final canKick =
                      player.manageable &&
                      serverState.permissions.contains(
                        ServerPermission.kickPlayers,
                      );
                  final canBan =
                      player.registered &&
                      player.manageable &&
                      serverState.permissions.contains(
                        ServerPermission.banPlayers,
                      );
                  final canManageRoles =
                      player.manageable &&
                      serverState.permissions.contains(
                        ServerPermission.manageRoles,
                      );
                  final canManageGameRoles = serverState.permissions.contains(
                    ServerPermission.manageWorld,
                  );
                  final canManage =
                      canKick || canBan || canManageRoles || canManageGameRoles;
                  return ListTile(
                    title: Text(
                      player.name ??
                          AppLocalizations.of(
                            context,
                          ).defaultUserName(player.id),
                    ),
                    subtitle: Text(
                      [
                        roleNames.join(', '),
                        if (gameRoleNames.isNotEmpty) gameRoleNames.join(', '),
                      ].join(' · '),
                    ),
                    trailing: canManage
                        ? PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'kick') {
                                _moderatePlayer(context, player, ban: false);
                              } else if (value == 'ban') {
                                _moderatePlayer(context, player, ban: true);
                              } else if (value == 'gameRoles') {
                                _changeGameRoles(context, player, gameRoles);
                              } else if (value.startsWith('role:')) {
                                final role = value.substring(5);
                                final updatedRoles = Set<String>.from(
                                  player.serverRoles,
                                );
                                if (updatedRoles.contains(role) &&
                                    role != kDefaultServerRole) {
                                  updatedRoles.remove(role);
                                } else {
                                  updatedRoles.add(role);
                                }
                                unawaited(
                                  context.read<WorldBloc>().process(
                                    ServerRoleChangeRequest(
                                      player.id,
                                      roles: updatedRoles,
                                    ),
                                  ),
                                );
                              }
                            },
                            itemBuilder: (context) => [
                              if (canKick)
                                PopupMenuItem(
                                  value: 'kick',
                                  child: Text(
                                    AppLocalizations.of(context).kick,
                                  ),
                                ),
                              if (canBan)
                                PopupMenuItem(
                                  value: 'ban',
                                  child: Text(AppLocalizations.of(context).ban),
                                ),
                              if (canManageGameRoles)
                                PopupMenuItem(
                                  value: 'gameRoles',
                                  child: Text(
                                    AppLocalizations.of(context).gameRoles,
                                  ),
                                ),
                              if (canManageRoles)
                                ...serverState.serverRoles.entries
                                    .where(
                                      (entry) => serverState
                                          .assignableServerRoles
                                          .contains(entry.key),
                                    )
                                    .map((entry) {
                                      final translatedRole = worldState
                                          .assetManager
                                          .getRoleTranslation(
                                            entry.key,
                                            fallback: entry.value.name,
                                          )
                                          .name;
                                      final translatedPermissions = entry
                                          .value
                                          .permissions
                                          .map(
                                            (permission) => worldState
                                                .assetManager
                                                .getPermissionTranslation(
                                                  permission,
                                                )
                                                .name,
                                          )
                                          .join(', ');
                                      return CheckedPopupMenuItem(
                                        value: 'role:${entry.key}',
                                        checked: player.serverRoles.contains(
                                          entry.key,
                                        ),
                                        enabled:
                                            entry.key != kDefaultServerRole,
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          dense: true,
                                          title: Text(translatedRole),
                                          subtitle:
                                              translatedPermissions.isEmpty
                                              ? null
                                              : Text(translatedPermissions),
                                        ),
                                      );
                                    }),
                            ],
                          )
                        : null,
                  );
                },
              );
            },
          ),
    );
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < LeapBreakpoints.medium;
    return ResponsiveAlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context).multiplayer),
          Text(
            state.isServer
                ? AppLocalizations.of(context).server
                : AppLocalizations.of(context).client,
            style: TextTheme.of(context).labelLarge,
          ),
        ],
      ),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      ),
      constraints: BoxConstraints(
        maxWidth: LeapBreakpoints.medium,
        maxHeight: 500,
      ),
      content: isMobile
          ? ListView(children: [info, const Divider(), userList])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(child: SingleChildScrollView(child: info)),
                ),
                const VerticalDivider(),
                Expanded(child: SingleChildScrollView(child: userList)),
              ],
            ),
      actions: [
        OutlinedButton(
          child: Text(AppLocalizations.of(context).stop),
          onPressed: () {
            context.read<MultiplayerCubit>().disconnect();
          },
        ),
        TextButton(
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
