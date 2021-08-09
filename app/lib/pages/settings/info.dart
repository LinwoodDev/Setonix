import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Information")),
        body: ListView(children: [
          ListTile(
              onTap: () => launch("https://github.com/codedoctorde/linwood_city"),
              title: Text("GitHub Repository"),
              leading: Icon(PhosphorIcons.codeLight),
              trailing: Icon(PhosphorIcons.arrowSquareOutLight)),
          ListTile(
              title: Text("Impress"),
              leading: Icon(PhosphorIcons.wrenchLight),
              trailing: Icon(PhosphorIcons.arrowSquareOutLight),
              onTap: () => launch("https://codedoctor.tk/impress", forceWebView: true)),
          ListTile(
              title: Text("Privacy"),
              leading: Icon(PhosphorIcons.shieldLight),
              trailing: Icon(PhosphorIcons.arrowSquareOutLight),
              onTap: () => launch("https://codedoctor.tk/privacy", forceWebView: true)),
          ListTile(
              onTap: () => showAboutDialog(context: context),
              title: Text("About"),
              leading: Icon(PhosphorIcons.infoLight))
        ]));
  }
}
