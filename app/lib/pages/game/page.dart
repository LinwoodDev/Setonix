import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:town/widgets/window.dart';

import 'logic/logic.dart';
import 'players.dart';

class GamePage extends StatefulWidget {
  final GameConnection connection;

  const GamePage({super.key, required this.connection});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.connection.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowTitleBar(
        title: Text(AppLocalizations.of(context).game),
        actions: [
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.users),
            onPressed: () => showDialog(
              context: context,
              builder: (context) =>
                  PlayersDialog(connection: widget.connection),
            ),
          ),
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.door),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
