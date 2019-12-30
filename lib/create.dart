import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:minigamesparty/game/gamemode.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var _selectedGamemode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Enter a name'),
              ),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Enter the description'),
              ),
              DropdownButtonFormField<GameMode>(
                items: GameMode.values.map((GameMode value) {
                  return new DropdownMenuItem<GameMode>(
                      value: value,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            child: Icon(MdiIcons.gamepad),
                            padding: EdgeInsets.all(5),
                          ),
                          Text(value.toString())
                        ],
                      ));
                }).toList(),
                value: _selectedGamemode,
                onChanged: (newValue) {
                  setState(() {
                    _selectedGamemode = newValue;
                  });
                },
                decoration: InputDecoration(labelText: "Select a gamemode"),
              )
            ],
          ),
        ),
        floatingActionButton: new Builder(builder: (BuildContext context) {
          return new FloatingActionButton(
            child: Icon(MdiIcons.check),
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty &&
                  _selectedGamemode != null)
                create();
              else
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Please fill the input fields!"),
                  duration: Duration(seconds: 5),
                ));
            },
          );
        }));
  }

  void create() {}
}
