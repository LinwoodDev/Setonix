import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../pages.dart';

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
  static const settingsPages = [
    {
      "name": "Appeareance",
      "icon": MdiIcons.monitorEdit,
      "description": "Dark mode, Quality, ..",
      "route": RoutePages.appeareance
    },
    {
      "name": "Accounts",
      "icon": MdiIcons.accountMultipleOutline,
      "description": "Add account, remove account, ...",
      "route": RoutePages.settings
    },
    {"name": "Data", "icon": MdiIcons.database, "description": "Load, save, ..."},
    {
      "name": "Info",
      "icon": MdiIcons.informationOutline,
      "description": "Licenses, Legal, ...",
      "route": RoutePages.info
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ResponsiveGridList(
                desiredItemWidth: 100,
                minSpacing: 10,
                scroll: true,
                rowMainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    settingsPages.length,
                    (index) => Container(
                        alignment: Alignment(0, 0),
                        child: OutlineButton(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(settingsPages[index]["icon"],
                                      color: Theme.of(context).primaryColor)),
                              Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(settingsPages[index]["name"],
                                      textAlign: TextAlign.center,
                                      textWidthBasis: TextWidthBasis.parent,
                                      softWrap: false,
                                      style: Theme.of(context).textTheme.button)),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(settingsPages[index]["description"],
                                    style: Theme.of(context).textTheme.caption),
                              ),
                            ],
                          ),
                          onPressed: () =>
                              Navigator.of(context).pushNamed(settingsPages[index]["route"]),
                        ))))));
  }
}
