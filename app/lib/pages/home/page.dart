import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/main.dart';
import 'package:qeck/models/server.dart';
import 'package:qeck/services/network.dart';
import 'package:qeck/widgets/window.dart';

import '../../api/settings.dart';
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
            onPressed: () => openSettings(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Align(
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  applicationName,
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      (
                        AppLocalizations.of(context).connect,
                        PhosphorIconsLight.globe,
                        () async {
                          final address = await showDialog<Uri>(
                            context: context,
                            builder: (context) => const ConnectGameDialog(),
                          );
                          if (address == null) return;
                          if (context.mounted) {
                            final connection =
                                ClientGameConnection.connect(address);
                            context.push('/game', extra: connection);
                          }
                        },
                      ),
                      if (!kIsWeb)
                        (
                          AppLocalizations.of(context).create,
                          PhosphorIconsLight.plus,
                          () async {
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
                    ]
                        .map((e) => SizedBox(
                              height: 200,
                              width: 200,
                              child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: e.$3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(e.$2, size: 48),
                                          const SizedBox(height: 16),
                                          Text(
                                            e.$1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ))
                        .toList()),
                StreamBuilder<List<GameServer>>(
                  stream: context.read<NetworkingService>().fetchServers(),
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
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
