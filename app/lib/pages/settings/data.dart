import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/services/file_system.dart';

import '../../bloc/settings.dart';

class DataSettingsPage extends StatelessWidget {
  final bool inView;
  const DataSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    Future<void> changePath(String newPath) async {
      final oldPath = settingsCubit.state.dataDirectory;
      final worldSystem = context.read<QuokkaFileSystem>().worldSystem;
      if (!(await worldSystem.moveAbsolute(oldPath, newPath))) {
        return;
      }
      settingsCubit.changeDataDirectory(newPath);
    }

    return Scaffold(
        backgroundColor: inView ? Colors.transparent : null,
        appBar: WindowTitleBar<SettingsCubit, QuokkaSettings>(
          inView: inView,
          backgroundColor: inView ? Colors.transparent : null,
          title: Text(AppLocalizations.of(context).data),
        ),
        body: BlocBuilder<SettingsCubit, QuokkaSettings>(
          builder: (context, state) {
            return ListView(children: [
              if (!kIsWeb)
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            leading:
                                const PhosphorIcon(PhosphorIconsLight.folder),
                            title: Text(
                                AppLocalizations.of(context).dataDirectory),
                            subtitle: state.dataDirectory.isNotEmpty
                                ? Text(state.dataDirectory)
                                : Text(
                                    AppLocalizations.of(context).defaultPath),
                            trailing: state.dataDirectory.isNotEmpty
                                ? IconButton(
                                    icon: const PhosphorIcon(
                                        PhosphorIconsLight.clockClockwise),
                                    tooltip: AppLocalizations.of(context)
                                        .defaultPath,
                                    onPressed: () => changePath(''),
                                  )
                                : null,
                            onTap: () async {
                              try {
                                final selectedDir = await getDirectoryPath();
                                if (selectedDir != null) {
                                  changePath(selectedDir);
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                          AppLocalizations.of(context).error),
                                      content: Text(
                                        e.toString(),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ]),
                  ),
                ),
            ]);
          },
        ));
  }
}
