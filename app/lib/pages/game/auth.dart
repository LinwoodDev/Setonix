import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/settings.dart';
import 'package:setonix/pages/settings/home.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';

class AuthGameView extends StatelessWidget {
  const AuthGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withValues(alpha: 0.5),
          ),
        ),
        ResponsiveAlertDialog(
          title: Text(AppLocalizations.of(context).authenticate),
          constraints: BoxConstraints(
            maxWidth: LeapBreakpoints.medium,
          ),
          headerActions: [
            IconButton(
              icon: const Icon(PhosphorIconsLight.gear),
              onPressed: () {
                openSettings(context, view: SettingsView.accounts);
              },
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context).authenticateDescription),
            ],
          ),
        )
      ],
    );
  }
}
