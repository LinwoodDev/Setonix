import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Information")),
        body: ListView(children: [
          ListView(children: [
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
          ])
        ]));
  }
}
