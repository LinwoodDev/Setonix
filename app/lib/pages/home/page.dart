import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:town/main.dart';
import 'package:town/models/server.dart';
import 'package:town/services/connection.dart';
import 'package:town/widgets/window.dart';

import 'game.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WindowTitleBar(
          title: const Text(shortApplicationName),
          actions: [
            IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.gear),
              onPressed: () => context.push('/settings'),
            )
          ],
        ),
        body: StreamBuilder<List<GameServer>>(
          stream: context.read<ConnectionService>().fetchServers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final servers = snapshot.data ?? [];
            return ListView.builder(
              itemCount: servers.length,
              itemBuilder: (context, index) {
                final server = servers[index];
                return ListTile(
                  title: Text(server.property.name),
                  subtitle: Text(server.address),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showLeapBottomSheet(
            context: context,
            title: AppLocalizations.of(context).servers,
            childrenBuilder: (context) => [
              ListTile(
                title: Text(AppLocalizations.of(context).connect),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context).create),
                onTap: () async {
                  await showDialog<GameProperty>(
                    context: context,
                    builder: (context) => const CreateGameDialog(),
                  );
                },
              ),
            ],
          ),
          child: const Icon(Icons.add),
        ));
  }
}
