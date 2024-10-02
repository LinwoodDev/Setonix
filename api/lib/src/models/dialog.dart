import 'package:dart_mappable/dart_mappable.dart';

part 'dialog.mapper.dart';

@MappableClass()
final class GameDialog with GameDialogMappable {
  final String title;
  final String id;
  final List<GameDialogComponent> components;

  GameDialog({
    required this.id,
    required this.title,
    this.components = const [],
  });
}

@MappableClass()
sealed class GameDialogComponent with GameDialogComponentMappable {}

@MappableClass()
final class GameDialogMarkdownComponent extends GameDialogComponent
    with GameDialogMarkdownComponentMappable {
  final String content;

  GameDialogMarkdownComponent(this.content);
}

@MappableClass()
final class GameDialogActionRowComponent extends GameDialogComponent
    with GameDialogActionRowComponentMappable {
  final List<GameDialogButton> actions;

  GameDialogActionRowComponent(this.actions);
}

@MappableClass()
final class GameDialogButton with GameDialogButtonMappable {
  final String label;
  final String? id;

  GameDialogButton(this.label, {this.id});
}

@MappableClass()
sealed class GameDialogValue with GameDialogValueMappable {
  String getAsString();
  bool getAsBool() => true;
  int getAsInt() => 0;
}

@MappableClass()
sealed class GameDialogButtonValue extends GameDialogValue
    with GameDialogButtonValueMappable {
  final String label;

  GameDialogButtonValue(this.label);

  @override
  String getAsString() => label;
}
