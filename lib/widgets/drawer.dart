import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:minigamesparty/main.dart';
import 'package:minigamesparty/pages/create.dart';
import 'package:minigamesparty/pages/info.dart';

enum DrawerPage { home, info, settings, create, connect, example }

class HomeDrawer extends StatelessWidget {
  final DrawerPage page;

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
            selected: page == DrawerPage.connect,
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
            selected: page == DrawerPage.create,
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
            selected: page == DrawerPage.info,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoPage()),
              );
            },
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(MdiIcons.cogOutline),
            selected: page == DrawerPage.settings,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Example'),
            leading: Icon(MdiIcons.chatOutline),
            selected: page == DrawerPage.example,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
