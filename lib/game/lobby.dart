import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:minigamesparty/game/drawer.dart';
import 'package:minigamesparty/services/gamemode.dart';

class LobbyGame implements GameMode {
  
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  bool join(BluetoothDevice device) {
    return false;
  }

  @override
  Widget build() {
    return LobbyPage(game: this,);
  }

  @override
  // TODO: implement manager
  GameModeManager get manager => throw UnimplementedError();
}
class LobbyPage extends StatefulWidget {
  final LobbyGame game;
  LobbyPage({Key key, this.game}):super(key: key);
  @override
  _LobbyPageState createState() => _LobbyPageState();
}

enum GameModes { memory }

class _LobbyPageState extends State<LobbyPage> {
  GameModes _gameModes;
  Timer _timer;

  var _start;


@override
void dispose() {
  if(_timer != null)
    _timer.cancel();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lobby"),
        ),
        drawer: GameDrawer(manager: widget.game.manager, page: GamePage.game),
        body: Center(
            child: Column(children: <Widget>[
          Text(
            (_start != null) ? "Game starts in " + (_start).toString() +" seconds!" : "Please choose a game!",
            style: Theme.of(context).textTheme.headline6,
          ),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text('Memory card game'),
                subtitle: Text('2 players needed!'),
                trailing: Icon(MdiIcons.puzzleOutline),
                leading: Radio(
                  value: GameModes.memory,
                  groupValue: _gameModes,
                  onChanged: (GameModes value) {
                    setState(() {
                      _gameModes = (_gameModes != value) ? value : null;
                    });
                  },
                ),
              ),
            ],
          )
        ])),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Start game"),
          icon: Icon(MdiIcons.play),
          tooltip: "Start game",
          backgroundColor: (_gameModes == null || _start != null) ? Colors.grey : null,
          onPressed: (_gameModes == null || _start != null)
              ? null
              : () {
                  startTimer();
                },
        ));
  }

  void startTimer() {
    _start = 10;
    const oneSec = const Duration(seconds: 1);
    if(_timer != null)
      return;
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            _start = null;
            _timer = null;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }
}
