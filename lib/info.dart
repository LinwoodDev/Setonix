import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minigamesparty/drawer.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(page: DrawerPage.info),
      appBar: AppBar(
        title: Text("MinigamesParty - Information"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            InkWell(
              child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(children: <Widget>[
                      Text(
                        "Project info",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        "GitLab: https://gitlab.com/codedoctorde/minigamesparty \r\n"
                        "MIT License \r\n"
                        "Contributors: CodeDoctorDE\r\n"
                        "(C) 2019",
                      ),
                      FutureBuilder(
                        future: getVersionNumber(),
                        builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) =>
                            Text(
                          snapshot.hasData ? snapshot.data : "Loading ...",
                          style: TextStyle(color: Colors.black38),
                        ),
                      ),
                    ])),
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

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    return version;
  }
}
