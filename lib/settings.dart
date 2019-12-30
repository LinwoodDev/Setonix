import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            InkWell(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(children: <Widget>[
                    Text(
                      "Information about this open source project",
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      "GitLab: https://gitlab.com/codedoctorde/minigamesparty \r\n"
                      "MIT License \r\n"
                      "Contributors: CodeDoctorDE\r\n"
                      "(C) 2019",
                    ),
                  ]),
                ),
              ),
              onTap: () {
                launch("https://gitlab.com/codedoctorde/minigamesparty");
              },
            ),
          ],
        ),
      ),
    );
  }
}
