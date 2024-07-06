import 'package:flame/components.dart';
import 'package:quokka/game/board/game.dart';
import 'package:quokka/models/table.dart';

class GameHand extends Component with HasGameRef<BoardGame> {
  final List<GameObject>? _objects = null;

  @override
  void update(double dt) {
    if (_objects == null) {
      return;
    }
  }
}
