import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/settings.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/pages/settings/home.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

class AuthGameView extends StatefulWidget {
  const AuthGameView({super.key});

  @override
  State<AuthGameView> createState() => _AuthGameViewState();
}

class _AuthGameViewState extends State<AuthGameView> {
  late final SetonixFileSystem _fileSystem;
  Future<List<SetonixAccount>>? _keysFuture;

  @override
  void initState() {
    super.initState();
    _fileSystem = context.read<SetonixFileSystem>();
    _buildKeysFuture();
  }

  void _buildKeysFuture() {
    _keysFuture = _fileSystem.getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, ClientWorldState>(
        buildWhen: (previous, current) =>
            previous.world.authRequest != current.world.authRequest,
        builder: (context, state) {
          final authRequest = state.world.authRequest;
          if (authRequest == null) {
            return const SizedBox.shrink();
          }
          return Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),
              ResponsiveAlertDialog(
                title: Text(AppLocalizations.of(context).authenticate),
                constraints: BoxConstraints(
                  maxWidth: LeapBreakpoints.medium,
                ),
                headerActions: [
                  IconButton(
                    icon: const Icon(PhosphorIconsLight.gear),
                    onPressed: () async {
                      await openSettings(context, view: SettingsView.accounts);
                      setState(() {
                        _buildKeysFuture();
                      });
                    },
                  ),
                ],
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context).authenticateDescription),
                    if (authRequest.isRequired)
                      Text(
                        AppLocalizations.of(context).authenticateRequired,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.red,
                            ),
                      ),
                    Flexible(
                      child: FutureBuilder<List<SetonixAccount>>(
                        future: _keysFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                AppLocalizations.of(context).error,
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child:
                                  Text(AppLocalizations.of(context).noAccount),
                            );
                          } else {
                            final accounts = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: accounts.length,
                              itemBuilder: (context, index) {
                                final account = accounts[index];
                                return ListTile(
                                  title: Text(account.name),
                                  subtitle: Text(account.getFingerprint(true)),
                                  onTap: () {
                                    context
                                        .read<WorldBloc>()
                                        .authenticate(account);
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
