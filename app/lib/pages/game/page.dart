import 'package:flutter/material.dart';
import 'package:town/models/server.dart';

class GamePage extends StatefulWidget {
  final String address;
  final GameProperty property;

  const GamePage(
      {super.key, this.address = '', this.property = const GameProperty()});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
