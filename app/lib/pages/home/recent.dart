import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';

class RecentHomeView extends StatelessWidget {
  const RecentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<SettingsCubit, SetonixSettings>(
          buildWhen: (previous, current) =>
              previous.recentGames != current.recentGames,
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(PhosphorIconsLight.clockCounterClockwise),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).recentGames,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            AppLocalizations.of(context).recentGamesDescription,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (state.recentGames.isEmpty)
                  _RecentEmptyState()
                else
                  ...state.recentGames.map(
                    (e) => ListTile(
                      leading: const Icon(PhosphorIconsLight.diceFive),
                      title: Text(e.name),
                      subtitle: Text(
                        e.lastPlayed != null
                            ? DateFormat.yMMMd().format(e.lastPlayed!)
                            : AppLocalizations.of(context).notPlayedYet,
                      ),
                      onTap: () {
                        GoRouter.of(context).goNamed(
                          'game',
                          pathParameters: {'name': e.name},
                          queryParameters: {
                            if (e.isMultiplayer)
                              'address': e.location.toString(),
                          },
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RecentEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(PhosphorIconsLight.cards, size: 42),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context).noRecentGames,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            AppLocalizations.of(context).noRecentGamesDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
