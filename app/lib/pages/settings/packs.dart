import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeck/cubits/settings.dart';
import 'package:qeck/widgets/window.dart';

class PacksSettingsPage extends StatelessWidget {
  final bool inView;

  const PacksSettingsPage({
    super.key,
    this.inView = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inView ? Colors.transparent : null,
      appBar: WindowTitleBar(
        inView: inView,
        backgroundColor: inView ? Colors.transparent : null,
        title: Text(AppLocalizations.of(context).packs),
      ),
      body: BlocBuilder<SettingsCubit, QeckSettings>(
        builder: (context, state) {
          return ListView(children: const []);
        },
      ),
    );
  }
}
