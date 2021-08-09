import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoSettingsPage extends StatelessWidget {
  const InfoSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Information")),
        body: ListView(children: [
          ListTile(
              onTap: () => launch("https://github.com/codedoctorde/linwood_city"),
              title: const Text("GitHub Repository"),
              leading: const Icon(PhosphorIcons.codeLight),
              trailing: const Icon(PhosphorIcons.arrowSquareOutLight)),
          ListTile(
              title: const Text("Impress"),
              leading: const Icon(PhosphorIcons.wrenchLight),
              trailing: const Icon(PhosphorIcons.arrowSquareOutLight),
              onTap: () => launch("https://codedoctor.tk/impress", forceWebView: true)),
          ListTile(
              title: const Text("Privacy"),
              leading: const Icon(PhosphorIcons.shieldLight),
              trailing: const Icon(PhosphorIcons.arrowSquareOutLight),
              onTap: () => launch("https://codedoctor.tk/privacy", forceWebView: true)),
          ListTile(
              onTap: () => showAboutDialog(context: context),
              title: const Text("About"),
              leading: const Icon(PhosphorIcons.infoLight))
        ]));
  }
}
