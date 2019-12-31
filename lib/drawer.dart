import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:minigamesparty/create.dart';
import 'package:minigamesparty/info.dart';

enum Page { home, info, settings, create, connect }

class HomeDrawer extends StatelessWidget {
  final Page page;

  HomeDrawer({this.page});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: ExactAssetImage('assets/logo.png'),
              fit: BoxFit.fill,
            )),
            height: 200,
          ),
          ListTile(
            title: Text('Connect'),
            leading: Icon(MdiIcons.transitConnection),
            selected: page == Page.connect,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePage()),
              );
            },
          ),
          ListTile(
            title: Text('Create'),
            leading: Icon(MdiIcons.plus),
            selected: page == Page.create,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Info'),
            leading: Icon(MdiIcons.informationOutline),
            selected: page == Page.info,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoPage()),
              );
            },
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(MdiIcons.settingsOutline),
            selected: page == Page.settings,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
