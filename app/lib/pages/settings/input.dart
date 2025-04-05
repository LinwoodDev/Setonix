import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:setonix/theme.dart';

import '../../bloc/settings.dart';

class InputsSettingsPage extends StatelessWidget {
  final bool inView;
  const InputsSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: inView ? Colors.transparent : null,
        appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
          inView: inView,
          backgroundColor: inView ? Colors.transparent : null,
          title: Text(AppLocalizations.of(context).inputs),
        ),
        body: BlocBuilder<SettingsCubit, SetonixSettings>(
          builder: (context, state) {
            return ListView(children: [
              if (!kIsWeb)
                Card(
                  margin: settingsCardMargin,
                  child: Padding(
                    padding: settingsCardPadding,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ExactSlider(
                            min: 10,
                            max: 1000,
                            defaultValue: 100,
                            value: state.scrollSensitivity * 100,
                            header: Text(AppLocalizations.of(context).scroll),
                            fractionDigits: 0,
                            onChangeEnd: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeScrollSensitivity(value / 100);
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
