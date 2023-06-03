import 'package:flutter/material.dart';

import '../pages/settings/page.dart';

Future<void> openSettings(BuildContext context) => showDialog<void>(
    context: context,
    builder: (context) => Dialog(
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 600, maxWidth: 800),
            child: const SettingsPage(isDialog: true))));
