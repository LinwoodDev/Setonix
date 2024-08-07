import 'package:flame/components.dart';
import 'package:flame/events.dart';

mixin ScrollCallbacks on Component {
  bool onScroll(PointerScrollInfo info) => false;
}
