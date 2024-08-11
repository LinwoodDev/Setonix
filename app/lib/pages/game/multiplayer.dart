import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/bloc/multiplayer.dart';

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
            Text(AppLocalizations.of(context).multiplayerNote),
            const SizedBox(height: 16),
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
          else
            ElevatedButton.icon(
              onPressed: () {
                context.read<MultiplayerCubit>().create();
              },
              label: Text(AppLocalizations.of(context).start),
              icon: const Icon(PhosphorIconsLight.play),
            ),
        ],
      );
    });
  }
}
