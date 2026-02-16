import 'package:dart_mappable/dart_mappable.dart';

part 'dialog.mapper.dart';

@MappableClass()
final class GameDialog with GameDialogMappable {
  final String title;
  final String id;
  final List<GameDialogComponent> components;
  final List<GameDialogButton>? actions;
  final String? image;

  GameDialog({
    required this.id,
    required this.title,
    this.image,
    this.components = const [],
    this.actions,
  });

  GameDialog withImage(String image) => copyWith(image: image);

  GameDialog markdown(String content) =>
      copyWith.components.add(GameDialogMarkdownComponent(content));

  GameDialog textField(
    String label, {
    String? id,
    String? placeholder,
    bool multiline = false,
    bool password = false,
  }) => copyWith.components.add(
    GameDialogTextFieldComponent(
      label,
      id: id,
      placeholder: placeholder,
      multiline: multiline,
      password: password,
    ),
  );

  GameDialog checkbox(String label, {String? id, bool initialValue = false}) =>
      copyWith.components.add(
        GameDialogCheckboxComponent(label, id: id, initialValue: initialValue),
      );

  GameDialog dropdown(
    String label,
    List<GameDialogDropdownOption> options, {
    String? id,
    String? initialValue,
  }) => copyWith.components.add(
    GameDialogDropdownComponent(
      label,
      options,
      id: id,
      initialValue: initialValue,
    ),
  );

  GameDialog action(GameDialogButton action) =>
      copyWith(actions: [...(actions ?? []), action]);

  bool isValid() =>
      (actions?.length ?? 1) <= 10 &&
      components.length <= 20 &&
      components.every((e) {
        switch (e) {
          case GameDialogMarkdownComponent():
            return e.content.length <= 5000;
          case GameDialogTextFieldComponent():
            return e.label.length <= 50 &&
                (e.id?.length ?? 0) <= 100 &&
                (e.placeholder?.length ?? 0) <= 50;
          case GameDialogCheckboxComponent():
            return e.label.length <= 50 && (e.id?.length ?? 0) <= 100;
          case GameDialogDropdownComponent():
            return e.label.length <= 50 &&
                (e.id?.length ?? 0) <= 100 &&
                e.options.length <= 20 &&
                e.options.every((o) => o.isValid());
        }
      }) &&
      (actions ?? []).every(
        (e) => e.label.length <= 50 && (e.id?.length ?? 0) <= 100,
      );
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
final class GameDialogCheckboxComponent extends GameDialogComponent
    with GameDialogCheckboxComponentMappable {
  final String label;
  final String? id;
  final bool initialValue;

  GameDialogCheckboxComponent(this.label, {this.id, this.initialValue = false});

  String get idOrLabel => id ?? label;
}

@MappableClass()
final class GameDialogDropdownComponent extends GameDialogComponent
    with GameDialogDropdownComponentMappable {
  final String label;
  final String? id;
  final List<GameDialogDropdownOption> options;
  final String? initialValue;

  GameDialogDropdownComponent(
    this.label,
    this.options, {
    this.id,
    this.initialValue,
  });

  String get idOrLabel => id ?? label;
}

@MappableClass()
final class GameDialogDropdownOption with GameDialogDropdownOptionMappable {
  final String? label;
  final String value;

  GameDialogDropdownOption({this.label, required this.value});

  bool isValid() => (label?.length ?? 0) <= 50 && value.length <= 50;

  String get idOrLabel => label ?? value;
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
  final String buttonPressed;
  final Map<String, GameDialogComponentValue> values;

  GameDialogValue([this.values = const {}, this.buttonPressed = '']);

  bool hasValue(String key) => values.containsKey(key);
  GameDialogComponentValue getValue(String key) =>
      values[key] ?? GameDialogComponentValue(component: -1);
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

  GameDialogTextFieldValue({required this.value, required super.component});

  @override
  String getAsString() => value;
  @override
  bool getAsBool() => value.isNotEmpty;
  @override
  int getAsInt() => int.tryParse(value) ?? 0;
}

@MappableClass()
final class GameDialogCheckboxValue extends GameDialogComponentValue
    with GameDialogCheckboxValueMappable {
  final bool value;

  GameDialogCheckboxValue({required this.value, required super.component});

  @override
  String getAsString() => value.toString();
  @override
  bool getAsBool() => value;
  @override
  int getAsInt() => value ? 1 : 0;
}

@MappableClass()
final class GameDialogDropdownValue extends GameDialogComponentValue
    with GameDialogDropdownValueMappable {
  final String value;

  GameDialogDropdownValue({required this.value, required super.component});

  @override
  String getAsString() => value;
  @override
  bool getAsBool() => value.isNotEmpty;
  @override
  int getAsInt() => int.tryParse(value) ?? 0;
}
