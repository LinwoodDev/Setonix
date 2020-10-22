import 'package:flutter/material.dart';

class CreateOnlinePage extends StatelessWidget {
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
          Divider(),
        ],
      ),
    );
  }
}
