import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:minigamesparty/info.dart';
import 'package:minigamesparty/main.dart';

enum Page { home, info, settings, create, connect }

class HomeDrawer extends StatelessWidget {
  final Page page;

  HomeDrawer({this.page});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 250,
            child: (DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/icon.png",
                    height: 70,
                  ),
                  Text("MinigamesParty",
                      style: Theme.of(context).textTheme.headline),
                  Text("gitlab.com/codedoctorde/minigamesparty",
                      style: Theme.of(context).textTheme.subhead),
                  /*    ListTile(
                    trailing: Icon(MdiIcons.swapHorizontal),
                    title: Text(api.server.address),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ServerPage()),
                      );
                    },
                  ), */
                ],
              ),
            )),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(MdiIcons.home),
            selected: page == Page.home,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            title: Text('Connect'),
            leading: Icon(MdiIcons.transitConnection),
            selected: page == Page.connect,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            title: Text('Create'),
            leading: Icon(MdiIcons.plus),
            selected: page == Page.create,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          Divider(

          ),
          ListTile(
            title: Text('Info'),
            leading: Icon(MdiIcons.informationOutline),
            selected: page == Page.info,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
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
              Navigator.of(context).pop();
              Navigator.pushReplacement(
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
