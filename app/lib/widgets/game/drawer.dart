import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linwood_city/pages/games/players.dart';
import 'package:linwood_city/services/game/system.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum GamePage { game, chat, players }

class GameDrawer extends StatelessWidget {
  final GameSystem manager;
  final GamePage? page;

  GameDrawer({this.page, required this.manager});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            child: Text('Minigames Party - Ingame'),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: ExactAssetImage('assets/logo.png'),
              fit: BoxFit.fill,
            )),
            height: 200,
          ),
          ListTile(
            title: Text('Game'),
            leading: Icon(PhosphorIcons.gameControllerLight),
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
            title: Text('Chat'),
            subtitle: Text("Coming soon..."),
            enabled: false,
            leading: Icon(PhosphorIcons.chatLight),
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
            title: Text('Players'),
            leading: Icon(PhosphorIcons.usersLight),
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
