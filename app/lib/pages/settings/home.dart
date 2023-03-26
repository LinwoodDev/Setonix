import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/window.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
  static const settingsPages = [
    {
      "name": "Appearance",
      "icon": PhosphorIcons.monitorLight,
      "description": "Dark mode, Quality, ..",
      "route": "/settings/appearance"
    },
    {
      "name": "Accounts",
      "icon": PhosphorIcons.usersLight,
      "description": "Add account, remove account, ...",
      "route": "/settings/accounts"
    },
    {
      "name": "Data",
      "icon": PhosphorIcons.databaseLight,
      "description": "Load, save, ...",
      "route": "/settings/data"
    },
    {
      "name": "Info",
      "icon": PhosphorIcons.infoLight,
      "description": "Licenses, Legal, ...",
      "route": "/settings/info"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const WindowTitleBar(
          title: Text("Settings"),
        ),
        body: Column(
            children: List.generate(
                settingsPages.length,
                (index) => ListTile(
                      leading: Icon(settingsPages[index]["icon"] as IconData?),
                      title: Text(settingsPages[index]["name"] as String),
                      subtitle: Text(
                          settingsPages[index]["description"] as String,
                          style: Theme.of(context).textTheme.bodySmall),
                      onTap: () => GoRouter.of(context)
                          .push(settingsPages[index]["route"] as String),
                    ))));
  }
}
