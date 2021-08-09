import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linwood_city/pages/create/online.dart';
import 'package:linwood_city/services/game/system/types.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateLobbyPage extends StatefulWidget {
  const CreateLobbyPage({Key? key}) : super(key: key);

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
  ConnectionType _typeController = ConnectionType.socket;
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _maxPlayerCountController = TextEditingController(text: "10");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create game lobby"),
        ),
        body: Align(
            alignment: Alignment.topCenter,
            child: Container(
                padding: const EdgeInsets.all(16.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Form(
                        key: _formKey,
                        child: Center(
                            child: Column(children: <Widget>[
                          TextFormField(
                              decoration:
                                  const InputDecoration(labelText: "Name", icon: Icon(PhosphorIcons.pencilLight)),
                              validator: (value) {
                                if (value!.isEmpty) return "This value can't be empty!";
                                return null;
                              }),
                          TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  icon: const Icon(PhosphorIcons.lockLight),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword ? PhosphorIcons.eyeSlashLight : PhosphorIcons.eyeLight),
                                    onPressed: () => setState(() => _showPassword = !_showPassword),
                                  )),
                              obscureText: !_showPassword,
                              keyboardType: _showPassword ? TextInputType.visiblePassword : TextInputType.text),
                          TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Maximum number of players", icon: Icon(PhosphorIcons.usersLight)),
                              keyboardType: TextInputType.number,
                              controller: _maxPlayerCountController,
                              onChanged: (text) => _maxPlayerCountController.value,
                              validator: (value) {
                                var number = int.parse(value!);
                                if (number > 100) return "Invalid max player count! You can't set this value above 100";
                                if (number < 2) return "Invalid max player count! The value need to be over 1!";
                                return null;
                              },
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]),
                          const SizedBox(height: 10),
                          const Divider(),
                          ListTile(
                            title: const Text("Connection type"),
                            subtitle: Text(_typeController.getName()),
                            leading: const Icon(PhosphorIcons.shareNetworkLight),
                            onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text("Choose where you want to host your game",
                                            style: Theme.of(context).textTheme.headline5),
                                      ),
                                      ...ConnectionType.values
                                          .map((label) => ListTile(
                                                title: Text(label.getName()),
                                                subtitle: Text(label.getDescription()),
                                                onTap: () {
                                                  setState(() => _typeController = label);
                                                  Navigator.of(context).pop();
                                                },
                                              ))
                                          .toList()
                                    ]))),
                          )
                        ])))))),
        floatingActionButton: Builder(builder: (BuildContext context) {
          return FloatingActionButton(
            child: const Icon(PhosphorIcons.arrowRightLight),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateOnlinePage()));
              }
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
