import 'dart:ui';

import 'package:flutter/material.dart';

import '../pages/settings/home.dart';

Future<void> openSettings(
  BuildContext context, {
  SettingsView view = SettingsView.general,
}) =>
    showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          ScaffoldMessenger(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 800, maxWidth: 1000),
              child: SettingsPage(
                isDialog: true,
                view: view,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Animate the dialog from bottom to center
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutQuart)).animate(animation),
          child: child,
        );
      },
    );
