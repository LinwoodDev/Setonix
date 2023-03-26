import 'package:flutter/material.dart';
import 'package:town/services/game/system.dart';
import 'package:town/widgets/game/drawer.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/window.dart';

class PlayersPage extends StatefulWidget {
  final GameSystem manager;

  const PlayersPage({Key? key, required this.manager}) : super(key: key);

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
      appBar: const WindowTitleBar(
        title: Text("Players"),
      ),
      drawer: GameDrawer(
        manager: widget.manager,
        page: GamePage.players,
      ),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                          title: Text(snapshot.data[index].name),
                          subtitle: Text(snapshot.data[index].id.id),
                        ))
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  PhosphorIcons.warningLight,
                  color: Theme.of(context).colorScheme.error,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = <Widget>[
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            );
          }),
    );
  }
}
