import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/bloc/settings.dart';
import 'package:quokka/main.dart';
import 'package:quokka/pages/home/connect.dart';
import 'package:quokka/pages/home/packs.dart';
import 'package:quokka/pages/home/play.dart';

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
                            spacing: 12,
                            overflowSpacing: 8,
                            children: [
                              (
                                AppLocalizations.of(context).play,
                                PhosphorIconsLight.play,
                                () => showDialog(
                                    context: context,
                                    builder: (context) => const PlayDialog()),
                              ),
                              (
                                AppLocalizations.of(context).connect,
                                PhosphorIconsLight.plugsConnected,
                                () => showDialog(
                                    context: context,
                                    builder: (context) => AddConnectDialog()),
                              ),
                              (
                                AppLocalizations.of(context).packs,
                                PhosphorIconsLight.package,
                                () => showDialog(
                                      context: context,
                                      builder: (context) => const PacksDialog(),
                                    ),
                              ),
                              (
                                AppLocalizations.of(context).settings,
                                PhosphorIconsLight.gear,
                                () => openSettings(context),
                              ),
                            ]
                                .map((e) => Container(
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
