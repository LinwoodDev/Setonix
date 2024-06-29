import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/settings.dart';

class DataSettingsPage extends StatelessWidget {
  final bool inView;
  const DataSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
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
                          title:
                              Text(AppLocalizations.of(context).dataDirectory),
                          subtitle: const Text(''),
                          onTap: () {},
                        ),
                      ]),
                ),
              ),
            ]);
          },
        ));
  }
}
