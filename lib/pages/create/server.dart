import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateServerPage extends StatefulWidget {
  @override
  _CreateServerPageState createState() => _CreateServerPageState();
}

class _CreateServerPageState extends State<CreateServerPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create server")),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Form(
              key: _formKey,
              child: Center(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Name", prefixIcon: Icon(MdiIcons.pencilOutline)),
                      validator: (value) {
                        if (value!.isEmpty) return "This value can't be empty!";
                        return null;
                      }),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(MdiIcons.lockOutline),
                          suffixIcon: IconButton(
                            icon: Icon(_showPassword ? MdiIcons.eyeOff : MdiIcons.eye),
                            onPressed: () => setState(() => _showPassword = !_showPassword),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) return "This value can't be empty!";
                        return null;
                      },
                      obscureText: !_showPassword,
                      keyboardType:
                          _showPassword ? TextInputType.visiblePassword : TextInputType.text),
                  TextFormField(
                      decoration: InputDecoration(labelText: "Description"),
                      maxLines: null,
                      validator: (value) {
                        if (value!.isEmpty) return "This value can't be empty!";
                        return null;
                      }),
                ],
              )))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(MdiIcons.check),
      ),
    );
  }
}
