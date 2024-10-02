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
final class GameDialogTextFieldComponent extends GameDialogComponent
    with GameDialogTextFieldComponentMappable {
  final String label;
  final String? id;
  final String? placeholder;
  final bool multiline;
  final bool password;

  GameDialogTextFieldComponent(
    this.label, {
    this.id,
    this.placeholder,
    this.multiline = false,
    this.password = false,
  });

  String get idOrLabel => id ?? label;
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

  String get idOrLabel => id ?? label;
}

@MappableClass()
base class GameDialogValue with GameDialogValueMappable {
  final Map<String, GameDialogComponentValue> values;

  GameDialogValue([this.values = const {}]);

  bool hasValue(String key) => values.containsKey(key);
  GameDialogComponentValue getValue(String key) =>
      values[key] ??
      GameDialogComponentValue(
        component: -1,
      );
}

@MappableClass()
base class GameDialogComponentValue with GameDialogComponentValueMappable {
  final int component;

  GameDialogComponentValue({required this.component});
  String getAsString() => '';
  bool getAsBool() => false;
  int getAsInt() => 0;
}

@MappableClass()
final class GameDialogTextFieldValue extends GameDialogComponentValue
    with GameDialogTextFieldValueMappable {
  final String value;

  GameDialogTextFieldValue({
    required this.value,
    required super.component,
  });

  @override
  String getAsString() => value;
  @override
  bool getAsBool() => value.isNotEmpty;
  @override
  int getAsInt() => int.tryParse(value) ?? 0;
}

@MappableClass()
final class GameDialogButtonValue extends GameDialogComponentValue
    with GameDialogButtonValueMappable {
  final String label;
  final int index;

  GameDialogButtonValue({
    required this.label,
    required this.index,
    required super.component,
  });

  @override
  String getAsString() => label;

  @override
  int getAsInt() => index;

  @override
  bool getAsBool() => true;
}
