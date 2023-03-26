import 'package:flutter/material.dart';
import 'package:town/models/server.dart';
import 'package:town/pages/create/server.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/window.dart';

class CreateOnlinePage extends StatelessWidget {
  final List<GameServer> _servers = [
    const GameServer(name: "Test1", address: "example.com")
  ];

  CreateOnlinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WindowTitleBar(title: Text("Choose a server")),
      body: Align(
          alignment: Alignment.topCenter,
          child: Container(
              padding: const EdgeInsets.all(16.0),
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView(children: [
                const ListTile(
                  title: Text("Europe server"),
                  subtitle: Text("The official europe server"),
                ),
                const ListTile(
                  title: Text("Linwood cloud server"),
                  subtitle: Text(
                      "Play games and save your stats in the linwood database"),
                ),
                const Divider(thickness: 1.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _servers.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ListTile(
                      title: Text(_servers[index].name),
                      subtitle: Text(_servers[index].address)),
                )
              ]))),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add server"),
        icon: const Icon(PhosphorIcons.plusLight),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateServerPage()));
        },
      ),
    );
  }
}
