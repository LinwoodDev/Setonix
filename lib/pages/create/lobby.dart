import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:minigamesparty/pages/create/online.dart';
import 'package:minigamesparty/services/game/system/types.dart';

class CreateLobbyPage extends StatefulWidget {
  CreateLobbyPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _CreateLobbyPageState createState() => _CreateLobbyPageState();
}

class _CreateLobbyPageState extends State<CreateLobbyPage> {
  ConnectionType _typeController;
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _maxPlayerCountController = TextEditingController(text: "10");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create minigame lobby"),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
                key: _formKey,
                child: Center(
                    child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration:
                            InputDecoration(labelText: "Name", icon: Icon(MdiIcons.pencilOutline)),
                        validator: (value) {
                          if (value.isEmpty) return "This value can't be empty!";
                          return null;
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Password",
                            icon: Icon(MdiIcons.lockOutline),
                            suffixIcon: IconButton(
                              icon: Icon(_showPassword ? MdiIcons.eyeOff : MdiIcons.eye),
                              onPressed: () => setState(() => _showPassword = !_showPassword),
                            )),
                        validator: (value) {
                          if (value.isEmpty) return "This value can't be empty!";
                          return null;
                        },
                        obscureText: !_showPassword,
                        keyboardType:
                            _showPassword ? TextInputType.visiblePassword : TextInputType.text),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Maximum number of players",
                            icon: Icon(MdiIcons.accountMultipleOutline)),
                        keyboardType: TextInputType.number,
                        controller: _maxPlayerCountController,
                        onChanged: (text) => _maxPlayerCountController.value,
                        validator: (value) {
                          var number = int.parse(value);
                          if (number > 100)
                            return "Invalid max player count! You can't set this value above 100";
                          if (number < 2)
                            return "Invalid max player count! The value need to be over 1!";
                          return null;
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                    DropdownButtonFormField<ConnectionType>(
                        value: _typeController,
                        itemHeight: 1000,
                        validator: (value) {
                          if (value == null) return "This value can't be empty!";
                          return null;
                        },
                        items: ConnectionType.values
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.getName()),
                                  value: label,
                                ))
                            .toList(),
                        decoration: InputDecoration(
                            labelText: "Connection type",
                            helperText: "Choose where you want to host your game",
                            icon: Icon(MdiIcons.networkOutline)),
                        onChanged: (value) {
                          setState(() {
                            _typeController = value;
                          });
                        }),
                    SizedBox(height: 20),
                    Text(_typeController != null ? _typeController.getDescription() : '',
                        textAlign: TextAlign.center)
                  ],
                )))),
        floatingActionButton: Builder(builder: (BuildContext context) {
          return FloatingActionButton(
            child: Icon(MdiIcons.arrowRight),
            onPressed: () async {
              if (_formKey.currentState.validate())
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CreateOnlinePage()));
              // FlutterBlue.instance.state.listen((state) {
              //   if (state != BluetoothState.on) {
              //     Scaffold.of(context).showSnackBar(
              //       SnackBar(content: Text("You need to activate bluetooth for this.")),
              //     );
              //     return;
              //   }
              //   var gameModeManager = GameModeManager();
              //   gameModeManager.startScan();
              //   Scaffold.of(context).showSnackBar(SnackBar(
              //     content: Column(children: <Widget>[
              //       Icon(MdiIcons.bluetooth),
              //       Text("Successfully started game!")
              //     ]),
              //   ));
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => gameModeManager.currentGameMode.build()),
              //   ).then((value) => gameModeManager.stopScan());
              // });
            },
          );
        }));
  }
}
