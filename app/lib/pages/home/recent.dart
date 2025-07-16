import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';

class RecentHomeView extends StatelessWidget {
  const RecentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<SettingsCubit, SetonixSettings>(
              buildWhen: (previous, current) =>
                  previous.recentGames != current.recentGames,
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Recent Games',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    if (state.recentGames.isEmpty)
                      Text(
                        AppLocalizations.of(context).noRecentGames,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    else
                      ...state.recentGames.map(
                        (e) => ListTile(
                          title: Text(e.name),
                          subtitle: Text(
                            e.lastPlayed != null
                                ? DateFormat.yMMMd().format(e.lastPlayed!)
                                : '',
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
        ),
      ],
    );
  }
}
