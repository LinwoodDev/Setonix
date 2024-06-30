import 'package:flame/components.dart';

mixin Focusable on Component {
  bool get focused => findParent<FocusComponent>()?.focusedComponent == this;

  void focus() {
    findParent<FocusComponent>()?.focus(this);
  }

  void unfocus() {
    findParent<FocusComponent>()?.unfocus();
  }

  void onFocused() {}
  void onUnfocused() {}
}

class FocusComponent extends Component {
  Component? _focusedComponent;

  Component? get focusedComponent => _focusedComponent;

  void focus(Component component) {
    final old = _focusedComponent;
    if (old is Focusable) {
      old.onUnfocused();
    }
    _focusedComponent = component;
  }

  void unfocus() {
    final old = _focusedComponent;
    if (old is Focusable) {
      old.onUnfocused();
    }
    _focusedComponent = null;
  }
}
