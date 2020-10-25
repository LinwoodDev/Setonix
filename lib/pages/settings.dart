import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView(children: [
              ListTile(
                  tileColor: Theme.of(context).primaryColor,
                  onTap: () => launch("https://github.com/codedoctorde/minigamesparty"),
                  title: Text(
                    "GitHub Repository",
                    style: Theme.of(context).primaryTextTheme.subtitle1,
                  ),
                  trailing: Icon(MdiIcons.chevronRight,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size)),
              ListTile(
                tileColor: Theme.of(context).primaryColor,
                title: Text("Impress", style: Theme.of(context).primaryTextTheme.subtitle1),
                trailing: Icon(MdiIcons.openInNew,
                    color: Theme.of(context).primaryIconTheme.color,
                    size: Theme.of(context).primaryIconTheme.size),
                onTap: () => launch("https://codedoctor.tk/impress", forceWebView: true),
              ),
              ListTile(
                tileColor: Theme.of(context).primaryColor,
                title: Text("Privacy", style: Theme.of(context).primaryTextTheme.subtitle1),
                trailing: Icon(MdiIcons.openInNew,
                    color: Theme.of(context).primaryIconTheme.color,
                    size: Theme.of(context).primaryIconTheme.size),
                onTap: () => launch("https://codedoctor.tk/privacy", forceWebView: true),
              ),
              ListTile(
                onTap: () => showAboutDialog(context: context),
                title: Text(
                  "About",
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
                trailing: Icon(MdiIcons.informationOutline,
                    color: Theme.of(context).primaryIconTheme.color,
                    size: Theme.of(context).primaryIconTheme.size),
              ),
              ListTile(
                onTap: () => showAboutDialog(context: context),
                title: Text(
                  "Language",
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
                trailing: Icon(MdiIcons.translate,
                    color: Theme.of(context).primaryIconTheme.color,
                    size: Theme.of(context).primaryIconTheme.size),
              )
            ])));
  }
}
