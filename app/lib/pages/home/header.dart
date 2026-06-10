import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/pages/home/connect.dart';
import 'package:setonix/pages/home/create.dart';

class HeaderHomeView extends StatefulWidget {
  const HeaderHomeView({super.key});

  @override
  State<HeaderHomeView> createState() => _HeaderHomeViewState();
}

class _HeaderHomeViewState extends State<HeaderHomeView> {
  late final Future<bool> _hasNewerVersionFuture;
  late final SettingsCubit _settingsCubit;

  @override
  void initState() {
    super.initState();
    _settingsCubit = context.read<SettingsCubit>();
    _hasNewerVersionFuture = _settingsCubit.hasNewerVersion();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMedium = constraints.maxWidth >= LeapBreakpoints.medium;
        return FutureBuilder(
          future: _hasNewerVersionFuture,
          builder: (context, snapshot) {
            final hasNewerVersion = snapshot.data ?? false;
            void openNew() {
              openReleaseNotes();
              _settingsCubit.updateLastVersion();
            }

            void createGame() {
              showDialog<bool>(
                context: context,
                builder: (context) => const CreateDialog(),
              );
            }

            void joinGame() {
              showDialog<void>(
                context: context,
                builder: (context) => const ServersDialog(),
              );
            }

            final textColumn = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isMedium
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context).welcome,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: isMedium ? TextAlign.start : TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context).homeWelcomeDescription,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: isMedium ? TextAlign.start : TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context).homeActionPrompt,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: isMedium ? TextAlign.start : TextAlign.center,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: isMedium
                      ? WrapAlignment.start
                      : WrapAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: createGame,
                      icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                      label: Text(LeapLocalizations.of(context).create),
                    ),
                    OutlinedButton.icon(
                      onPressed: joinGame,
                      icon: const PhosphorIcon(
                        PhosphorIconsLight.plugsConnected,
                      ),
                      label: Text(AppLocalizations.of(context).multiplayer),
                    ),
                    if (hasNewerVersion)
                      TextButton.icon(
                        onPressed: openNew,
                        icon: const PhosphorIcon(PhosphorIconsLight.sparkle),
                        label: Text(AppLocalizations.of(context).whatsNew),
                      ),
                    TextButton.icon(
                      onPressed: () => openHelp(['intro']),
                      icon: const PhosphorIcon(PhosphorIconsLight.bookOpen),
                      label: Text(AppLocalizations.of(context).documentation),
                    ),
                  ],
                ),
              ],
            );
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Flex(
                  direction: isMedium ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/logo.png', width: isMedium ? 132 : 96),
                    if (isMedium) const SizedBox(width: 48),
                    if (!isMedium) const SizedBox(height: 24),
                    if (isMedium) Flexible(child: textColumn) else textColumn,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
