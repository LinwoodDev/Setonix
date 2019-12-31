import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:minigamesparty/game/drawer.dart';
import 'package:minigamesparty/game/gamemode.dart';

class LobbyPage extends GameMode {
  LobbyPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _LobbyPageState createState() => _LobbyPageState();

  @override
  bool join(BluetoothDevice device) {
    return false;
  }
}
enum GameModes{
  memory
}

class _LobbyPageState extends State<LobbyPage> {
  GameModes _gameModes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lobby"),
        ),
        drawer: GameDrawer(manager: widget.manager,page: GamePage.game),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                  "Please choose a game!"
              ),
              ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Memory'),
                    trailing: Icon(
                      MdiIcons.memory
                    ),
                    leading: Radio(
                      value: GameModes.memory,
                      groupValue: _gameModes,
                      onChanged: (GameModes value) {
                        setState(() { _gameModes = value; });
                      },
                    ),
                  ),
                ],
              )
            ]
          )
        )
    );
  }
}
