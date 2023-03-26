import 'package:flutter/material.dart';
import 'package:town/widgets/window.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: WindowTitleBar(
        title: Text("Devices"),
      ),
    );
  }
}
