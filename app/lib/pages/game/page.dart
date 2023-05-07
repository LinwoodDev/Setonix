import 'package:flutter/material.dart';
import 'package:town/pages/game/logic.dart';

class GamePage extends StatefulWidget {
  final GameConnection connection;

  const GamePage({super.key, required this.connection});

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
