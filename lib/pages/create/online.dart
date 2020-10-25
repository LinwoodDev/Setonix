import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:minigamesparty/models/server.dart';
import 'package:minigamesparty/pages/create/server.dart';

class CreateOnlinePage extends StatelessWidget {
  final List<Server> _servers = [Server(name: "Test1", password: "abc", address: "example.com")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose a server")),
      body: ListView(
        children: [
          ListTile(
            title: Text("Europe server"),
            subtitle: Text("The official europe server"),
          ),
          ListTile(
            title: Text("Linwood cloud server"),
            subtitle: Text("Play games and save your stats in the linwood database"),
          ),
          Divider(
            thickness: 1.0,
            color: Theme.of(context).primaryColor,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _servers.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => ListTile(
                title: Text(_servers[index].name), subtitle: Text(_servers[index].address)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add server"),
        icon: Icon(MdiIcons.plus),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateServerPage()));
        },
      ),
    );
  }
}
