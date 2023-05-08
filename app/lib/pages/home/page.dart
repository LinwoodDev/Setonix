import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/main.dart';
import 'package:qeck/models/server.dart';
import 'package:qeck/services/connection.dart';
import 'package:qeck/widgets/window.dart';

import '../../logic/connection/client.dart';
import '../../logic/connection/server.dart';
import 'connect.dart';
import 'create.dart';

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
                onTap: () async {
                  final address = await showDialog<Uri>(
                    context: context,
                    builder: (context) => const ConnectGameDialog(),
                  );
                  if (address == null) return;
                  if (context.mounted) {
                    final connection = ClientGameConnection.connect(address);
                    context.push('/game', extra: connection);
                  }
                },
              ),
              if (!kIsWeb)
                ListTile(
                  title: Text(AppLocalizations.of(context).create),
                  onTap: () async {
                    final property = await showDialog<GameProperty>(
                      context: context,
                      builder: (context) => const CreateGameDialog(),
                    );
                    if (property == null) return;
                    if (context.mounted) {
                      final connection =
                          await ClientServerGameConnection.create();
                      if (context.mounted) {
                        context.push('/game', extra: connection);
                      }
                    }
                  },
                ),
            ],
          ),
          child: const Icon(Icons.add),
        ));
  }
}
