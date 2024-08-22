import 'package:flutter/material.dart';
import 'package:quokka_api/quokka_api.dart';

extension TeamColorVisualizer on TeamColor {
  Color get color => switch (this) {
        TeamColor.red => Colors.red,
        TeamColor.blue => Colors.blue,
        TeamColor.indigo => Colors.indigo,
        TeamColor.green => Colors.green,
        TeamColor.yellow => Colors.yellow,
        TeamColor.purple => Colors.purple,
        TeamColor.orange => Colors.orange,
        TeamColor.pink => Colors.pink,
        TeamColor.brown => Colors.brown,
        TeamColor.white => Colors.white,
        TeamColor.black => Colors.black,
      };
}
