import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:minigamesparty/game/drawer.dart';
import 'package:minigamesparty/game/gamemode.dart';

class PlayersPage extends StatefulWidget {
  GameModeManager manager;

  PlayersPage({Key key, @required this.manager}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players"),

      ),
      drawer: GameDrawer(
        page: GamePage.players, game: widget.manager.currentGameMode,),
      body: ListView.builder(
          itemCount: widget.manager.players.length,
          itemBuilder: (context, i) {
            return widget.manager
            .
          }
      ),
    );
  }
}