import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/window.dart';

class CreateServerPage extends StatefulWidget {
  const CreateServerPage({Key? key}) : super(key: key);

  @override
  _CreateServerPageState createState() => _CreateServerPageState();
}

class _CreateServerPageState extends State<CreateServerPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WindowTitleBar(title: Text("Create server")),
      body: Align(
          alignment: Alignment.topCenter,
          child: Container(
              padding: const EdgeInsets.all(16.0),
              constraints: const BoxConstraints(maxWidth: 800),
              child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Form(
                      key: _formKey,
                      child: Center(
                          child: Column(children: <Widget>[
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Name",
                                filled: true,
                                prefixIcon: Icon(PhosphorIcons.pencilLight)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This value can't be empty!";
                              }
                              return null;
                            }),
                        const SizedBox(height: 8),
                        TextFormField(
                            decoration: InputDecoration(
                                labelText: "Password",
                                filled: true,
                                prefixIcon: const Icon(PhosphorIcons.lockLight),
                                suffixIcon: IconButton(
                                  icon: Icon(_showPassword
                                      ? PhosphorIcons.eyeSlashLight
                                      : PhosphorIcons.eyeLight),
                                  onPressed: () => setState(
                                      () => _showPassword = !_showPassword),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This value can't be empty!";
                              }
                              return null;
                            },
                            obscureText: !_showPassword,
                            keyboardType: _showPassword
                                ? TextInputType.visiblePassword
                                : TextInputType.text),
                        const SizedBox(height: 8),
                        TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Description"),
                            maxLines: null,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This value can't be empty!";
                              }
                              return null;
                            })
                      ])))))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(PhosphorIcons.checkLight),
      ),
    );
  }
}
