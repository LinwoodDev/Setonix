import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/api/open.dart';
import 'package:quokka/bloc/settings.dart';
import 'package:quokka/main.dart';
import 'package:quokka/pages/home/background.dart';
import 'package:quokka/pages/home/connect.dart';
import 'package:quokka/pages/home/packs.dart';
import 'package:quokka/pages/home/play.dart';

import '../../api/settings.dart';

class HomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  HomePage({super.key});

  List<(String, IconData, VoidCallback, Widget?)> _getItems(
          BuildContext context) =>
      [
        (
          AppLocalizations.of(context).play,
          PhosphorIconsLight.play,
          () => showDialog(
              context: context, builder: (context) => const PlayDialog()),
          null,
        ),
        (
          AppLocalizations.of(context).connect,
          PhosphorIconsLight.plugsConnected,
          () => showDialog(
              context: context, builder: (context) => AddConnectDialog()),
          null,
        ),
        (
          AppLocalizations.of(context).packs,
          PhosphorIconsLight.package,
          () => showDialog(
                context: context,
                builder: (context) => const PacksDialog(),
              ),
          null,
        ),
        (
          AppLocalizations.of(context).documentation,
          PhosphorIconsLight.book,
          () => openHelp(['intro']),
          null,
        ),
        (
          AppLocalizations.of(context).releaseNotes,
          PhosphorIconsLight.flag,
          () => openReleaseNotes(),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox();
              return Text(snapshot.data?.version ?? '');
            },
          ),
        ),
        (
          AppLocalizations.of(context).settings,
          PhosphorIconsLight.gear,
          () => openSettings(context),
          null,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final items = _getItems(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const WindowTitleBar<SettingsCubit, QuokkaSettings>(
        title: Text(shortApplicationName),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            ListenableBuilder(
              listenable: _scrollController,
              builder: (context, child) => DotsBackground(
                offset:
                    _scrollController.hasClients ? _scrollController.offset : 0,
              ),
            ),
            SingleChildScrollView(
              controller: _scrollController,
              child: Align(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: LeapBreakpoints.expanded,
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (constraints.maxWidth < LeapBreakpoints.compact)
                        Card(
                          clipBehavior: Clip.antiAlias,
                          child: ListView(
                            shrinkWrap: true,
                            children: items.map((item) {
                              return ListTile(
                                title: Text(item.$1),
                                subtitle: item.$4,
                                leading: Icon(item.$2,
                                    color: theme.colorScheme.primary),
                                onTap: item.$3,
                              );
                            }).toList(),
                          ),
                        )
                      else
                        GridView.extent(
                          shrinkWrap: true,
                          maxCrossAxisExtent: 500,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: items.map((item) {
                            return LayoutBuilder(
                                builder: (context, constraints) =>
                                    Card.outlined(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: item.$3,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Icon(
                                                item.$2,
                                                size: constraints.maxWidth / 2,
                                                color:
                                                    theme.colorScheme.primary,
                                              )),
                                              SizedBox(
                                                height: 64,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        item.$1,
                                                        style: theme.textTheme
                                                            .headlineSmall,
                                                      ),
                                                    ),
                                                    if (item.$4 != null)
                                                      DefaultTextStyle(
                                                        style: (theme.textTheme
                                                                    .headlineSmall ??
                                                                const TextStyle())
                                                            .copyWith(
                                                          color: theme
                                                              .colorScheme
                                                              .primaryFixed,
                                                        ),
                                                        child: item.$4!,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                          }).toList(),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
