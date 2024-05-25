import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/cubits/settings.dart';
import 'package:quokka/main.dart';
import 'package:quokka/pages/packs/dialog.dart';

import '../../api/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WindowTitleBar<SettingsCubit, QuokkaSettings>(
        title: Text(shortApplicationName),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Align(
            child: Container(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    applicationName,
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OverflowBar(
                            overflowAlignment: OverflowBarAlignment.center,
                            children: [
                              (
                                'Play',
                                PhosphorIconsLight.play,
                                () => context.push('/board'),
                              ),
                              (
                                'Connect',
                                PhosphorIconsLight.plugsConnected,
                                () => context.push('/board'),
                              ),
                              (
                                'Packs',
                                PhosphorIconsLight.package,
                                () => showDialog(
                                      context: context,
                                      builder: (context) => const PacksDialog(),
                                    ),
                              ),
                              (
                                'Options',
                                PhosphorIconsLight.gear,
                                () => openSettings(context),
                              ),
                            ]
                                .map((e) => Container(
                                      padding: const EdgeInsets.all(8.0),
                                      constraints:
                                          const BoxConstraints(minWidth: 250),
                                      child: OutlinedButton.icon(
                                        icon: Icon(e.$2),
                                        style: ButtonStyle(
                                          padding: WidgetStateProperty.all(
                                              const EdgeInsets.symmetric(
                                                  vertical: 16,
                                                  horizontal: 32)),
                                        ),
                                        label: Text(
                                          e.$1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                        onPressed: e.$3,
                                      ),
                                    ))
                                .toList()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
