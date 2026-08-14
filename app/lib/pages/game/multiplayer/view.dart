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
                DropdownMenu<Duration?>(
                  initialSelection: duration,
                  expandedInsets: EdgeInsets.zero,
                  label: Text(AppLocalizations.of(context).banDuration),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(
                      value: null,
                      label: AppLocalizations.of(context).permanent,
                    ),
                    DropdownMenuEntry(
                      value: const Duration(hours: 1),
                      label: AppLocalizations.of(context).oneHour,
                    ),
                    DropdownMenuEntry(
                      value: const Duration(days: 1),
                      label: AppLocalizations.of(context).oneDay,
                    ),
                    DropdownMenuEntry(
                      value: const Duration(days: 7),
                      label: AppLocalizations.of(context).sevenDays,
                    ),
                  ],
                  onSelected: (value) => setState(() => duration = value),
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

  void _toggleServerRole(BuildContext context, PlayerInfo player, String role) {
    final updatedRoles = Set<String>.from(player.serverRoles);
    if (updatedRoles.contains(role)) {
      updatedRoles.remove(role);
    } else {
      updatedRoles.add(role);
    }
    unawaited(
      context.read<WorldBloc>().process(
        ServerRoleChangeRequest(player.id, roles: updatedRoles),
      ),
    );
  }

  Future<void> _changePlayerName(
    BuildContext context,
    PlayerInfo player,
  ) async {
    final controller = TextEditingController(text: player.name ?? '');
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).rename),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).name,
          ),
          onSubmitted: (_) => Navigator.pop(context, true),
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
    final name = controller.text.trim();
    controller.dispose();
    if (confirmed != true || name.isEmpty || !context.mounted) return;
    unawaited(
      context.read<WorldBloc>().process(
        PlayerNameChangeRequest(player.id, name),
      ),
    );
  }

  Future<void> _unbanUser(BuildContext context, BannedUserInfo user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).unban),
        content: Text(user.name),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context).unban),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    unawaited(context.read<WorldBloc>().process(UnbanPlayerRequest(user.id)));
  }

  String _formatBanExpiration(BuildContext context, DateTime expiresAt) {
    final local = expiresAt.toLocal();
    final material = MaterialLocalizations.of(context);
    final formatted =
        '${material.formatMediumDate(local)} '
        '${material.formatTimeOfDay(TimeOfDay.fromDateTime(local))}';
    return AppLocalizations.of(context).banExpiresAt(formatted);
  }

  @override
  Widget build(BuildContext context) {
    final multiplayer = context.read<MultiplayerCubit>();
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
      stream: Rx.merge([
        ?state.clientChange,
        state.userManager.changes.map((_) => multiplayer.clients),
      ]),
      initialData: multiplayer.clients,
      builder: (context, connectionSnapshot) => BlocBuilder<WorldBloc, ClientWorldState>(
        buildWhen: (previous, current) =>
            previous.world.serverState != current.world.serverState ||
            previous.world.gameRoleMembers != current.world.gameRoleMembers,
        builder: (context, worldState) {
          final serverState = worldState.world.serverState;
          final players = state.isServer
              ? (connectionSnapshot.data ?? const <Channel>{})
                    .map(
                      (channel) => PlayerInfo(
                        id: channel,
                        name: state.userManager.getUser(channel)?.name,
                        serverRoles:
                            state.userManager.getUser(channel)?.roles ??
                            const {kDefaultServerRole},
                        manageable: true,
                      ),
                    )
                    .toList(growable: false)
              : serverState.players;
          final canViewBans = serverState.permissions.contains(
            ServerPermission.banPlayers,
          );
          final playerList = players.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    AppLocalizations.of(context).noConnections,
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
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
                    final isCurrentUser = player.id == worldState.world.id;
                    final canRename =
                        isCurrentUser ||
                        (player.manageable &&
                            (state.isServer || canManageGameRoles));
                    final hasModerationActions =
                        canKick ||
                        canBan ||
                        canManageRoles ||
                        canManageGameRoles;
                    return ListTile(
                      title: Text(
                        player.name ??
                            AppLocalizations.of(
                              context,
                            ).defaultUserName(player.id),
                      ),
                      subtitle: Text(
                        [
                          if (isCurrentUser) AppLocalizations.of(context).you,
                          roleNames.join(', '),
                          if (gameRoleNames.isNotEmpty)
                            gameRoleNames.join(', '),
                        ].join(' · '),
                      ),
                      trailing: canRename || hasModerationActions
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (canRename)
                                  IconButton(
                                    tooltip: AppLocalizations.of(
                                      context,
                                    ).rename,
                                    icon: const PhosphorIcon(
                                      PhosphorIconsLight.pencilSimple,
                                    ),
                                    onPressed: () =>
                                        _changePlayerName(context, player),
                                  ),
                                if (hasModerationActions)
                                  MenuAnchor(
                                    builder: defaultMenuButton(
                                      tooltip: MaterialLocalizations.of(
                                        context,
                                      ).showMenuTooltip,
                                    ),
                                    menuChildren: [
                                      if (canKick)
                                        MenuItemButton(
                                          leadingIcon: const PhosphorIcon(
                                            PhosphorIconsLight.userMinus,
                                          ),
                                          onPressed: () => _moderatePlayer(
                                            context,
                                            player,
                                            ban: false,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context).kick,
                                          ),
                                        ),
                                      if (canBan)
                                        MenuItemButton(
                                          leadingIcon: const PhosphorIcon(
                                            PhosphorIconsLight.gavel,
                                          ),
                                          onPressed: () => _moderatePlayer(
                                            context,
                                            player,
                                            ban: true,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context).ban,
                                          ),
                                        ),
                                      if (canManageGameRoles)
                                        MenuItemButton(
                                          leadingIcon: const PhosphorIcon(
                                            PhosphorIconsLight.gameController,
                                          ),
                                          onPressed: () => _changeGameRoles(
                                            context,
                                            player,
                                            gameRoles,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            ).gameRoles,
                                          ),
                                        ),
                                      if (canManageRoles)
                                        SubmenuButton(
                                          leadingIcon: const PhosphorIcon(
                                            PhosphorIconsLight
                                                .identificationBadge,
                                          ),
                                          menuChildren: serverState
                                              .serverRoles
                                              .entries
                                              .where(
                                                (entry) => serverState
                                                    .assignableServerRoles
                                                    .contains(entry.key),
                                              )
                                              .map((entry) {
                                                final translatedRole =
                                                    worldState.assetManager
                                                        .getRoleTranslation(
                                                          entry.key,
                                                          fallback:
                                                              entry.value.name,
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
                                                return CheckboxMenuButton(
                                                  value: player.serverRoles
                                                      .contains(entry.key),
                                                  closeOnActivate: false,
                                                  onChanged:
                                                      entry.key ==
                                                          kDefaultServerRole
                                                      ? null
                                                      : (_) =>
                                                            _toggleServerRole(
                                                              context,
                                                              player,
                                                              entry.key,
                                                            ),
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    dense: true,
                                                    title: Text(translatedRole),
                                                    subtitle:
                                                        translatedPermissions
                                                            .isEmpty
                                                        ? null
                                                        : Text(
                                                            translatedPermissions,
                                                          ),
                                                  ),
                                                );
                                              })
                                              .toList(growable: false),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            ).serverRoles,
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            )
                          : null,
                    );
                  },
                );
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              playerList,
              if (canViewBans) ...[
                const Divider(),
                ExpansionTile(
                  leading: const PhosphorIcon(PhosphorIconsLight.gavel),
                  title: Text(AppLocalizations.of(context).bannedUsers),
                  initiallyExpanded: serverState.bannedUsers.isNotEmpty,
                  children: serverState.bannedUsers.isEmpty
                      ? [
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context).noBannedUsers,
                            ),
                          ),
                        ]
                      : serverState.bannedUsers
                            .map(
                              (user) => ListTile(
                                title: Text(user.name),
                                subtitle: Text(
                                  [
                                    ?user.reason,
                                    if (user.expiresAt case final expiresAt?)
                                      _formatBanExpiration(context, expiresAt)
                                    else
                                      AppLocalizations.of(context).permanent,
                                  ].join('\n'),
                                ),
                                trailing: IconButton.filledTonal(
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.lockOpen,
                                  ),
                                  tooltip: AppLocalizations.of(context).unban,
                                  onPressed: () => _unbanUser(context, user),
                                ),
                              ),
                            )
                            .toList(growable: false),
                ),
              ],
            ],
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
