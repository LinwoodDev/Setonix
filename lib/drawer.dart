import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Page { home, info }

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
                  Text("Knowledge-Wiki",
                      style: Theme.of(context).textTheme.headline),
                  Text("gitlab.com/knowledge-wiki",
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
        ],
      ),
    );
  }
}
