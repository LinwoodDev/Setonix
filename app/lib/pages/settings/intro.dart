import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/pages/home/connect.dart';
import 'package:setonix/pages/home/create.dart';
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
          Image.asset('images/logo.png', width: 88, height: 88),
          Text(
            AppLocalizations.of(context).welcomeContent,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _IntroFeature(
            icon: PhosphorIconsLight.playCircle,
            title: AppLocalizations.of(context).singleplayer,
            description: AppLocalizations.of(context)
                .homeSingleplayerDescription,
          ),
          _IntroFeature(
            icon: PhosphorIconsLight.usersThree,
            title: AppLocalizations.of(context).multiplayer,
            description: AppLocalizations.of(context)
                .homeMultiplayerDescription,
          ),
          _IntroFeature(
            icon: PhosphorIconsLight.package,
            title: AppLocalizations.of(context).library,
            description: AppLocalizations.of(context).homePacksDescription,
          ),
          ExpansionTile(
            leading: const Icon(PhosphorIconsLight.slidersHorizontal),
            title: Text(AppLocalizations.of(context).settings),
            children: [
              SwitchListTile(
                value: _loadDefaultServers,
                onChanged: (e) => setState(() => _loadDefaultServers = e),
                title: Text(AppLocalizations.of(context).loadDefaultServerList),
                subtitle: Text(
                  AppLocalizations.of(context).loadDefaultServerListDescription,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _finishWith(const ServersDialog()),
                icon: const PhosphorIcon(PhosphorIconsLight.usersThree),
                label: Text(AppLocalizations.of(context).multiplayer),
              ),
              FilledButton.icon(
                onPressed: () => _finishWith(const CreateDialog()),
                icon: const PhosphorIcon(PhosphorIconsLight.play),
                label: Text(AppLocalizations.of(context).singleplayer),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _finishWith(Widget dialog) {
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    Navigator.of(context).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(context: rootContext, builder: (context) => dialog);
    });
  }
}

class _IntroFeature extends StatelessWidget {
  final IconData icon;
  final String title, description;

  const _IntroFeature({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(child: Icon(icon)),
    title: Text(title),
    subtitle: Text(description),
  );
}
