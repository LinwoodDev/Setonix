import 'package:flutter/cupertino.dart';
import 'package:minigamesparty/game/gamemode.dart';

class TicTacToePage extends StatefulWidget {
  final GameModeManager manager;

  TicTacToePage(this.manager, {Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Table(children: <TableRow>[
            TableRow(children: <Widget>[
              TableCell(
                child: Text("X"),
              )
            ]),
          ])
        ],
      ),
    );
  }
}
