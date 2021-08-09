import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linwood_city/pages/games/players.dart';
import 'package:linwood_city/services/game/system.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum GamePage { game, chat, players }

class GameDrawer extends StatelessWidget {
  final GameSystem manager;
  final GamePage? page;

  const GameDrawer({Key? key, this.page, required this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            child: const Text('Minigames Party - Ingame'),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: ExactAssetImage('assets/logo.png'),
              fit: BoxFit.fill,
            )),
            height: 200,
          ),
          ListTile(
            title: const Text('Game'),
            leading: const Icon(PhosphorIcons.gameControllerLight),
            selected: page == GamePage.game,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => manager.currentMode!.build(context)),
              );
            },
          ),
          ListTile(
            title: const Text('Chat'),
            subtitle: const Text("Coming soon..."),
            enabled: false,
            leading: const Icon(PhosphorIcons.chatLight),
            selected: page == GamePage.chat,
            onTap: () {
              // Navigator.pop(context);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => CreatePage()),
              // );
            },
          ),
          ListTile(
            title: const Text('Players'),
            leading: const Icon(PhosphorIcons.usersLight),
            selected: page == GamePage.players,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PlayersPage(
                          manager: manager,
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}
