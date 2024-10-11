import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:networker/networker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/bloc/settings.dart';

class MultiplayerDialog extends StatelessWidget {
  const MultiplayerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiplayerCubit, MultiplayerState>(
        builder: (context, state) {
      return ResponsiveAlertDialog(
        title: Text(AppLocalizations.of(context).multiplayer),
        leading: IconButton.outlined(
          icon: const Icon(PhosphorIconsLight.x),
          onPressed: () => Navigator.of(context).pop(),
        ),
        constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state is MultiplayerConnectedState) ...[
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  suffix: IconButton(
                    icon: const Icon(PhosphorIconsLight.copy),
                    onPressed: () => saveToClipboard(
                      context,
                      state.networker.address.toString(),
                    ),
                  ),
                ),
                controller: TextEditingController(
                    text: state.networker.address.toString()),
              ),
              StreamBuilder(
                stream: state.clientChange,
                builder: (context, snapshot) {
                  final networker = state.networker;
                  if (networker is NetworkerServer) {
                    final connections = (snapshot.data ?? {}).toList();
                    return Column(
                      children: [
                        Text(AppLocalizations.of(context)
                            .areConnected(connections.length)),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: connections.length,
                          itemBuilder: (context, index) {
                            final connection = connections[index];
                            final info =
                                networker.getConnectionInfo(connection);
                            if (info == null) return const SizedBox();
                            return ListTile(
                              title: Text(info.address.toString()),
                              trailing: IconButton(
                                icon: const Icon(PhosphorIconsLight.door),
                                tooltip:
                                    AppLocalizations.of(context).disconnect,
                                onPressed: () {
                                  info.close();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return Text(
                        AppLocalizations.of(context).successfullyConnected);
                  }
                },
              ),
            ] else ...[
              if (kIsWeb)
                Text(AppLocalizations.of(context).webNotSupported)
              else
                Text(AppLocalizations.of(context).multiplayerNote),
            ],
          ],
        ),
        actions: [
          if (state.isConnected)
            ElevatedButton.icon(
              onPressed: () {
                context.read<MultiplayerCubit>().disconnect();
              },
              label: Text(AppLocalizations.of(context).disconnect),
              icon: const Icon(PhosphorIconsLight.x),
            )
          else if (!kIsWeb)
            FilledButton.icon(
              onPressed: () {
                final settings = context.read<SettingsCubit>().state;
                context
                    .read<MultiplayerCubit>()
                    .create(property: settings.gameProperty);
              },
              label: Text(AppLocalizations.of(context).start),
              icon: const Icon(PhosphorIconsLight.play),
            ),
        ],
      );
    });
  }
}
