// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dialog.dart';

class GameDialogMapper extends ClassMapperBase<GameDialog> {
  GameDialogMapper._();

  static GameDialogMapper? _instance;
  static GameDialogMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameDialogMapper._());
      GameDialogComponentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialog';

  static String _$id(GameDialog v) => v.id;
  static const Field<GameDialog, String> _f$id = Field('id', _$id);
  static String _$title(GameDialog v) => v.title;
  static const Field<GameDialog, String> _f$title = Field('title', _$title);
  static List<GameDialogComponent> _$components(GameDialog v) => v.components;
  static const Field<GameDialog, List<GameDialogComponent>> _f$components =
      Field('components', _$components, opt: true, def: const []);

  @override
  final MappableFields<GameDialog> fields = const {
    #id: _f$id,
    #title: _f$title,
    #components: _f$components,
  };

  static GameDialog _instantiate(DecodingData data) {
    return GameDialog(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        components: data.dec(_f$components));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialog fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialog>(map);
  }

  static GameDialog fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialog>(json);
  }
}

mixin GameDialogMappable {
  String toJson() {
    return GameDialogMapper.ensureInitialized()
        .encodeJson<GameDialog>(this as GameDialog);
  }

  Map<String, dynamic> toMap() {
    return GameDialogMapper.ensureInitialized()
        .encodeMap<GameDialog>(this as GameDialog);
  }

  GameDialogCopyWith<GameDialog, GameDialog, GameDialog> get copyWith =>
      _GameDialogCopyWithImpl(this as GameDialog, $identity, $identity);
  @override
  String toString() {
    return GameDialogMapper.ensureInitialized()
        .stringifyValue(this as GameDialog);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogMapper.ensureInitialized()
        .equalsValue(this as GameDialog, other);
  }

  @override
  int get hashCode {
    return GameDialogMapper.ensureInitialized().hashValue(this as GameDialog);
  }
}

extension GameDialogValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialog, $Out> {
  GameDialogCopyWith<$R, GameDialog, $Out> get $asGameDialog =>
      $base.as((v, t, t2) => _GameDialogCopyWithImpl(v, t, t2));
}

abstract class GameDialogCopyWith<$R, $In extends GameDialog, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      GameDialogComponent,
      GameDialogComponentCopyWith<$R, GameDialogComponent,
          GameDialogComponent>> get components;
  $R call({String? id, String? title, List<GameDialogComponent>? components});
  GameDialogCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameDialogCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialog, $Out>
    implements GameDialogCopyWith<$R, GameDialog, $Out> {
  _GameDialogCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialog> $mapper =
      GameDialogMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      GameDialogComponent,
      GameDialogComponentCopyWith<$R, GameDialogComponent,
          GameDialogComponent>> get components => ListCopyWith(
      $value.components,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(components: v));
  @override
  $R call({String? id, String? title, List<GameDialogComponent>? components}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (components != null) #components: components
      }));
  @override
  GameDialog $make(CopyWithData data) => GameDialog(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      components: data.get(#components, or: $value.components));

  @override
  GameDialogCopyWith<$R2, GameDialog, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameDialogCopyWithImpl($value, $cast, t);
}

class GameDialogComponentMapper extends ClassMapperBase<GameDialogComponent> {
  GameDialogComponentMapper._();

  static GameDialogComponentMapper? _instance;
  static GameDialogComponentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameDialogComponentMapper._());
      GameDialogMarkdownComponentMapper.ensureInitialized();
      GameDialogActionRowComponentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogComponent';

  @override
  final MappableFields<GameDialogComponent> fields = const {};

  static GameDialogComponent _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('GameDialogComponent');
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogComponent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogComponent>(map);
  }

  static GameDialogComponent fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogComponent>(json);
  }
}

mixin GameDialogComponentMappable {
  String toJson();
  Map<String, dynamic> toMap();
  GameDialogComponentCopyWith<GameDialogComponent, GameDialogComponent,
      GameDialogComponent> get copyWith;
}

abstract class GameDialogComponentCopyWith<$R, $In extends GameDialogComponent,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  GameDialogComponentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class GameDialogMarkdownComponentMapper
    extends ClassMapperBase<GameDialogMarkdownComponent> {
  GameDialogMarkdownComponentMapper._();

  static GameDialogMarkdownComponentMapper? _instance;
  static GameDialogMarkdownComponentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = GameDialogMarkdownComponentMapper._());
      GameDialogComponentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogMarkdownComponent';

  static String _$content(GameDialogMarkdownComponent v) => v.content;
  static const Field<GameDialogMarkdownComponent, String> _f$content =
      Field('content', _$content);

  @override
  final MappableFields<GameDialogMarkdownComponent> fields = const {
    #content: _f$content,
  };

  static GameDialogMarkdownComponent _instantiate(DecodingData data) {
    return GameDialogMarkdownComponent(data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogMarkdownComponent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogMarkdownComponent>(map);
  }

  static GameDialogMarkdownComponent fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogMarkdownComponent>(json);
  }
}

mixin GameDialogMarkdownComponentMappable {
  String toJson() {
    return GameDialogMarkdownComponentMapper.ensureInitialized()
        .encodeJson<GameDialogMarkdownComponent>(
            this as GameDialogMarkdownComponent);
  }

  Map<String, dynamic> toMap() {
    return GameDialogMarkdownComponentMapper.ensureInitialized()
        .encodeMap<GameDialogMarkdownComponent>(
            this as GameDialogMarkdownComponent);
  }

  GameDialogMarkdownComponentCopyWith<GameDialogMarkdownComponent,
          GameDialogMarkdownComponent, GameDialogMarkdownComponent>
      get copyWith => _GameDialogMarkdownComponentCopyWithImpl(
          this as GameDialogMarkdownComponent, $identity, $identity);
  @override
  String toString() {
    return GameDialogMarkdownComponentMapper.ensureInitialized()
        .stringifyValue(this as GameDialogMarkdownComponent);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogMarkdownComponentMapper.ensureInitialized()
        .equalsValue(this as GameDialogMarkdownComponent, other);
  }

  @override
  int get hashCode {
    return GameDialogMarkdownComponentMapper.ensureInitialized()
        .hashValue(this as GameDialogMarkdownComponent);
  }
}

extension GameDialogMarkdownComponentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialogMarkdownComponent, $Out> {
  GameDialogMarkdownComponentCopyWith<$R, GameDialogMarkdownComponent, $Out>
      get $asGameDialogMarkdownComponent => $base
          .as((v, t, t2) => _GameDialogMarkdownComponentCopyWithImpl(v, t, t2));
}

abstract class GameDialogMarkdownComponentCopyWith<
    $R,
    $In extends GameDialogMarkdownComponent,
    $Out> implements GameDialogComponentCopyWith<$R, $In, $Out> {
  @override
  $R call({String? content});
  GameDialogMarkdownComponentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GameDialogMarkdownComponentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialogMarkdownComponent, $Out>
    implements
        GameDialogMarkdownComponentCopyWith<$R, GameDialogMarkdownComponent,
            $Out> {
  _GameDialogMarkdownComponentCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialogMarkdownComponent> $mapper =
      GameDialogMarkdownComponentMapper.ensureInitialized();
  @override
  $R call({String? content}) =>
      $apply(FieldCopyWithData({if (content != null) #content: content}));
  @override
  GameDialogMarkdownComponent $make(CopyWithData data) =>
      GameDialogMarkdownComponent(data.get(#content, or: $value.content));

  @override
  GameDialogMarkdownComponentCopyWith<$R2, GameDialogMarkdownComponent, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GameDialogMarkdownComponentCopyWithImpl($value, $cast, t);
}

class GameDialogActionRowComponentMapper
    extends ClassMapperBase<GameDialogActionRowComponent> {
  GameDialogActionRowComponentMapper._();

  static GameDialogActionRowComponentMapper? _instance;
  static GameDialogActionRowComponentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = GameDialogActionRowComponentMapper._());
      GameDialogComponentMapper.ensureInitialized();
      GameDialogButtonMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogActionRowComponent';

  static List<GameDialogButton> _$actions(GameDialogActionRowComponent v) =>
      v.actions;
  static const Field<GameDialogActionRowComponent, List<GameDialogButton>>
      _f$actions = Field('actions', _$actions);

  @override
  final MappableFields<GameDialogActionRowComponent> fields = const {
    #actions: _f$actions,
  };

  static GameDialogActionRowComponent _instantiate(DecodingData data) {
    return GameDialogActionRowComponent(data.dec(_f$actions));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogActionRowComponent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogActionRowComponent>(map);
  }

  static GameDialogActionRowComponent fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogActionRowComponent>(json);
  }
}

mixin GameDialogActionRowComponentMappable {
  String toJson() {
    return GameDialogActionRowComponentMapper.ensureInitialized()
        .encodeJson<GameDialogActionRowComponent>(
            this as GameDialogActionRowComponent);
  }

  Map<String, dynamic> toMap() {
    return GameDialogActionRowComponentMapper.ensureInitialized()
        .encodeMap<GameDialogActionRowComponent>(
            this as GameDialogActionRowComponent);
  }

  GameDialogActionRowComponentCopyWith<GameDialogActionRowComponent,
          GameDialogActionRowComponent, GameDialogActionRowComponent>
      get copyWith => _GameDialogActionRowComponentCopyWithImpl(
          this as GameDialogActionRowComponent, $identity, $identity);
  @override
  String toString() {
    return GameDialogActionRowComponentMapper.ensureInitialized()
        .stringifyValue(this as GameDialogActionRowComponent);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogActionRowComponentMapper.ensureInitialized()
        .equalsValue(this as GameDialogActionRowComponent, other);
  }

  @override
  int get hashCode {
    return GameDialogActionRowComponentMapper.ensureInitialized()
        .hashValue(this as GameDialogActionRowComponent);
  }
}

extension GameDialogActionRowComponentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialogActionRowComponent, $Out> {
  GameDialogActionRowComponentCopyWith<$R, GameDialogActionRowComponent, $Out>
      get $asGameDialogActionRowComponent => $base.as(
          (v, t, t2) => _GameDialogActionRowComponentCopyWithImpl(v, t, t2));
}

abstract class GameDialogActionRowComponentCopyWith<
    $R,
    $In extends GameDialogActionRowComponent,
    $Out> implements GameDialogComponentCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, GameDialogButton,
          GameDialogButtonCopyWith<$R, GameDialogButton, GameDialogButton>>
      get actions;
  @override
  $R call({List<GameDialogButton>? actions});
  GameDialogActionRowComponentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GameDialogActionRowComponentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialogActionRowComponent, $Out>
    implements
        GameDialogActionRowComponentCopyWith<$R, GameDialogActionRowComponent,
            $Out> {
  _GameDialogActionRowComponentCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialogActionRowComponent> $mapper =
      GameDialogActionRowComponentMapper.ensureInitialized();
  @override
  ListCopyWith<$R, GameDialogButton,
          GameDialogButtonCopyWith<$R, GameDialogButton, GameDialogButton>>
      get actions => ListCopyWith($value.actions,
          (v, t) => v.copyWith.$chain(t), (v) => call(actions: v));
  @override
  $R call({List<GameDialogButton>? actions}) =>
      $apply(FieldCopyWithData({if (actions != null) #actions: actions}));
  @override
  GameDialogActionRowComponent $make(CopyWithData data) =>
      GameDialogActionRowComponent(data.get(#actions, or: $value.actions));

  @override
  GameDialogActionRowComponentCopyWith<$R2, GameDialogActionRowComponent, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GameDialogActionRowComponentCopyWithImpl($value, $cast, t);
}

class GameDialogButtonMapper extends ClassMapperBase<GameDialogButton> {
  GameDialogButtonMapper._();

  static GameDialogButtonMapper? _instance;
  static GameDialogButtonMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameDialogButtonMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogButton';

  static String _$label(GameDialogButton v) => v.label;
  static const Field<GameDialogButton, String> _f$label =
      Field('label', _$label);
  static String? _$id(GameDialogButton v) => v.id;
  static const Field<GameDialogButton, String> _f$id =
      Field('id', _$id, opt: true);

  @override
  final MappableFields<GameDialogButton> fields = const {
    #label: _f$label,
    #id: _f$id,
  };

  static GameDialogButton _instantiate(DecodingData data) {
    return GameDialogButton(data.dec(_f$label), id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogButton fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogButton>(map);
  }

  static GameDialogButton fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogButton>(json);
  }
}

mixin GameDialogButtonMappable {
  String toJson() {
    return GameDialogButtonMapper.ensureInitialized()
        .encodeJson<GameDialogButton>(this as GameDialogButton);
  }

  Map<String, dynamic> toMap() {
    return GameDialogButtonMapper.ensureInitialized()
        .encodeMap<GameDialogButton>(this as GameDialogButton);
  }

  GameDialogButtonCopyWith<GameDialogButton, GameDialogButton, GameDialogButton>
      get copyWith => _GameDialogButtonCopyWithImpl(
          this as GameDialogButton, $identity, $identity);
  @override
  String toString() {
    return GameDialogButtonMapper.ensureInitialized()
        .stringifyValue(this as GameDialogButton);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogButtonMapper.ensureInitialized()
        .equalsValue(this as GameDialogButton, other);
  }

  @override
  int get hashCode {
    return GameDialogButtonMapper.ensureInitialized()
        .hashValue(this as GameDialogButton);
  }
}

extension GameDialogButtonValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialogButton, $Out> {
  GameDialogButtonCopyWith<$R, GameDialogButton, $Out>
      get $asGameDialogButton =>
          $base.as((v, t, t2) => _GameDialogButtonCopyWithImpl(v, t, t2));
}

abstract class GameDialogButtonCopyWith<$R, $In extends GameDialogButton, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? label, String? id});
  GameDialogButtonCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GameDialogButtonCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialogButton, $Out>
    implements GameDialogButtonCopyWith<$R, GameDialogButton, $Out> {
  _GameDialogButtonCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialogButton> $mapper =
      GameDialogButtonMapper.ensureInitialized();
  @override
  $R call({String? label, Object? id = $none}) => $apply(FieldCopyWithData(
      {if (label != null) #label: label, if (id != $none) #id: id}));
  @override
  GameDialogButton $make(CopyWithData data) =>
      GameDialogButton(data.get(#label, or: $value.label),
          id: data.get(#id, or: $value.id));

  @override
  GameDialogButtonCopyWith<$R2, GameDialogButton, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameDialogButtonCopyWithImpl($value, $cast, t);
}

class GameDialogValueMapper extends ClassMapperBase<GameDialogValue> {
  GameDialogValueMapper._();

  static GameDialogValueMapper? _instance;
  static GameDialogValueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameDialogValueMapper._());
      GameDialogButtonValueMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogValue';

  @override
  final MappableFields<GameDialogValue> fields = const {};

  static GameDialogValue _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('GameDialogValue');
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogValue fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogValue>(map);
  }

  static GameDialogValue fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogValue>(json);
  }
}

mixin GameDialogValueMappable {
  String toJson();
  Map<String, dynamic> toMap();
  GameDialogValueCopyWith<GameDialogValue, GameDialogValue, GameDialogValue>
      get copyWith;
}

abstract class GameDialogValueCopyWith<$R, $In extends GameDialogValue, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  GameDialogValueCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class GameDialogButtonValueMapper
    extends ClassMapperBase<GameDialogButtonValue> {
  GameDialogButtonValueMapper._();

  static GameDialogButtonValueMapper? _instance;
  static GameDialogButtonValueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameDialogButtonValueMapper._());
      GameDialogValueMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogButtonValue';

  static String _$label(GameDialogButtonValue v) => v.label;
  static const Field<GameDialogButtonValue, String> _f$label =
      Field('label', _$label);

  @override
  final MappableFields<GameDialogButtonValue> fields = const {
    #label: _f$label,
  };

  static GameDialogButtonValue _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('GameDialogButtonValue');
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogButtonValue fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogButtonValue>(map);
  }

  static GameDialogButtonValue fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogButtonValue>(json);
  }
}

mixin GameDialogButtonValueMappable {
  String toJson();
  Map<String, dynamic> toMap();
  GameDialogButtonValueCopyWith<GameDialogButtonValue, GameDialogButtonValue,
      GameDialogButtonValue> get copyWith;
}

abstract class GameDialogButtonValueCopyWith<
    $R,
    $In extends GameDialogButtonValue,
    $Out> implements GameDialogValueCopyWith<$R, $In, $Out> {
  @override
  $R call({String? label});
  GameDialogButtonValueCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}
