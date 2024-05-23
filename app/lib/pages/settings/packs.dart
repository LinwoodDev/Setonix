import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/cubits/settings.dart';
import 'package:quokka/widgets/window.dart';

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
      body: BlocBuilder<SettingsCubit, QuokkaSettings>(
        builder: (context, state) {
          return ListView(children: const []);
        },
      ),
    );
  }
}
