import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/bloc/settings.dart';

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
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: LeapBreakpoints.expanded),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= LeapBreakpoints.medium;
            return FutureBuilder(
              future: _hasNewerVersionFuture,
              builder: (context, snapshot) {
                final hasNewerVersion = snapshot.data ?? true;
                final actions = Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () => openHelp(['intro']),
                      icon: const PhosphorIcon(PhosphorIconsLight.bookOpen),
                      label: Text(AppLocalizations.of(context).documentation),
                    ),
                  ],
                );
                void openNew() {
                  openReleaseNotes();
                  _settingsCubit.updateLastVersion();
                }

                final whatsNew = hasNewerVersion
                    ? FilledButton.icon(
                        onPressed: openNew,
                        icon: const Icon(PhosphorIconsLight.sparkle),
                        label: Text(AppLocalizations.of(context).whatsNew),
                      )
                    : const SizedBox.shrink();
                final logo = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/logo.png', width: 64),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).welcome,
                            style: TextTheme.of(context).titleLarge,
                            overflow: TextOverflow.clip,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            AppLocalizations.of(context).homeWelcomeDescription,
                            style: TextTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
                final innerCard = LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile =
                        constraints.maxWidth < LeapBreakpoints.compact;
                    if (isMobile) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          logo,
                          if (hasNewerVersion) ...[
                            const SizedBox(height: 18),
                            whatsNew,
                          ],
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: logo),
                        if (hasNewerVersion) ...[
                          const SizedBox(width: 24),
                          whatsNew,
                        ],
                      ],
                    );
                  },
                );
                final card = Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: innerCard,
                  ),
                );
                final child = isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: card),
                          const SizedBox(width: 24),
                          actions,
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [card, const SizedBox(height: 20), actions],
                      );
                return Column(
                  children: [
                    const SizedBox(height: 64),
                    child,
                    const SizedBox(height: 48),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
