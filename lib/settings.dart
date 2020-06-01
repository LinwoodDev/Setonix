import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(MdiIcons.translate),
              title: Text("Language"),
              trailing: Icon(MdiIcons.arrowRight),
              onTap: (){
                showBottomSheet(context: context, builder: (context){
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
