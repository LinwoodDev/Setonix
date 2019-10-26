

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minigamesparty/drawer.dart';
import 'package:url_launcher/url_launcher.dart';


class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: HomeDrawer(page: Page.info),
      appBar: AppBar(
        title: Text("MinigamesParty - Information"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            InkWell(
              child:
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(children: <Widget>[
                    Text(
                      "Information about this open source project",
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      "GitLab: https://gitlab.com/codedoctorde/minigamesparty \r\n"
                          "MIT License \r\n"
                          "Contributors: CodeDoctorDE\r\n"
                          "(C) 2019",

                    ),
                  ]),
                ),
              ),
              onTap: () {
                launch("https://gitlab.com/codedoctorde/minigamesparty");
              },
            ),
          ],
        ),
      ),
    );
  }
}
