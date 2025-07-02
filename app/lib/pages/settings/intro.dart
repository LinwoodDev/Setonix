import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';

class IntroDialog extends StatefulWidget {
  const IntroDialog({super.key});

  @override
  State<IntroDialog> createState() => _IntroDialogState();
}

class _IntroDialogState extends State<IntroDialog> {
  bool _loadDefaultServers = true;
  late final SettingsCubit _settingsCubit;

  @override
  void initState() {
    super.initState();
    _settingsCubit = context.read<SettingsCubit>();
  }

  @override
  void dispose() async {
    super.dispose();
    await _settingsCubit.changeShowIntro(false);
    if (_loadDefaultServers) {
      await _settingsCubit.addServersToList(getDefaultServerList(), true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).welcome),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: ListView(
        shrinkWrap: true,
        children: [
          Image.asset('images/logo.png', width: 100, height: 100),
          Text(
            AppLocalizations.of(context).welcomeContent,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Divider(),
          SwitchListTile(
            value: _loadDefaultServers,
            onChanged: (e) => setState(() => _loadDefaultServers = e),
            title: Text(AppLocalizations.of(context).loadDefaultServerList),
            subtitle: Text(
              AppLocalizations.of(context).loadDefaultServerListDescription,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const PhosphorIcon(PhosphorIconsLight.check),
            label: Text(AppLocalizations.of(context).confirm),
          ),
        ],
      ),
    );
  }
}
