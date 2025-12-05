// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'toolbar.dart';

class GameToolbarMapper extends ClassMapperBase<GameToolbar> {
  GameToolbarMapper._();

  static GameToolbarMapper? _instance;
  static GameToolbarMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameToolbarMapper._());
      ToolbarActionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameToolbar';

  static bool _$editable(GameToolbar v) => v.editable;
  static const Field<GameToolbar, bool> _f$editable = Field(
    'editable',
    _$editable,
    opt: true,
    def: true,
  );
  static List<ToolbarAction> _$actions(GameToolbar v) => v.actions;
  static const Field<GameToolbar, List<ToolbarAction>> _f$actions = Field(
    'actions',
    _$actions,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<GameToolbar> fields = const {
    #editable: _f$editable,
    #actions: _f$actions,
  };

  static GameToolbar _instantiate(DecodingData data) {
    return GameToolbar(
      editable: data.dec(_f$editable),
      actions: data.dec(_f$actions),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GameToolbar fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameToolbar>(map);
  }

  static GameToolbar fromJson(String json) {
    return ensureInitialized().decodeJson<GameToolbar>(json);
  }
}

mixin GameToolbarMappable {
  String toJson() {
    return GameToolbarMapper.ensureInitialized().encodeJson<GameToolbar>(
      this as GameToolbar,
    );
  }

  Map<String, dynamic> toMap() {
    return GameToolbarMapper.ensureInitialized().encodeMap<GameToolbar>(
      this as GameToolbar,
    );
  }

  GameToolbarCopyWith<GameToolbar, GameToolbar, GameToolbar> get copyWith =>
      _GameToolbarCopyWithImpl<GameToolbar, GameToolbar>(
        this as GameToolbar,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GameToolbarMapper.ensureInitialized().stringifyValue(
      this as GameToolbar,
    );
  }

  @override
  bool operator ==(Object other) {
    return GameToolbarMapper.ensureInitialized().equalsValue(
      this as GameToolbar,
      other,
    );
  }

  @override
  int get hashCode {
    return GameToolbarMapper.ensureInitialized().hashValue(this as GameToolbar);
  }
}

extension GameToolbarValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameToolbar, $Out> {
  GameToolbarCopyWith<$R, GameToolbar, $Out> get $asGameToolbar =>
      $base.as((v, t, t2) => _GameToolbarCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GameToolbarCopyWith<$R, $In extends GameToolbar, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ToolbarAction,
    ToolbarActionCopyWith<$R, ToolbarAction, ToolbarAction>
  >
  get actions;
  $R call({bool? editable, List<ToolbarAction>? actions});
  GameToolbarCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameToolbarCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameToolbar, $Out>
    implements GameToolbarCopyWith<$R, GameToolbar, $Out> {
  _GameToolbarCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameToolbar> $mapper =
      GameToolbarMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ToolbarAction,
    ToolbarActionCopyWith<$R, ToolbarAction, ToolbarAction>
  >
  get actions => ListCopyWith(
    $value.actions,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(actions: v),
  );
  @override
  $R call({bool? editable, List<ToolbarAction>? actions}) => $apply(
    FieldCopyWithData({
      if (editable != null) #editable: editable,
      if (actions != null) #actions: actions,
    }),
  );
  @override
  GameToolbar $make(CopyWithData data) => GameToolbar(
    editable: data.get(#editable, or: $value.editable),
    actions: data.get(#actions, or: $value.actions),
  );

  @override
  GameToolbarCopyWith<$R2, GameToolbar, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GameToolbarCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ToolbarActionMapper extends ClassMapperBase<ToolbarAction> {
  ToolbarActionMapper._();

  static ToolbarActionMapper? _instance;
  static ToolbarActionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ToolbarActionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ToolbarAction';

  static String _$id(ToolbarAction v) => v.id;
  static const Field<ToolbarAction, String> _f$id = Field('id', _$id);
  static String _$label(ToolbarAction v) => v.label;
  static const Field<ToolbarAction, String> _f$label = Field('label', _$label);
  static bool _$enabled(ToolbarAction v) => v.enabled;
  static const Field<ToolbarAction, bool> _f$enabled = Field(
    'enabled',
    _$enabled,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<ToolbarAction> fields = const {
    #id: _f$id,
    #label: _f$label,
    #enabled: _f$enabled,
  };

  static ToolbarAction _instantiate(DecodingData data) {
    return ToolbarAction(
      id: data.dec(_f$id),
      label: data.dec(_f$label),
      enabled: data.dec(_f$enabled),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ToolbarAction fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ToolbarAction>(map);
  }

  static ToolbarAction fromJson(String json) {
    return ensureInitialized().decodeJson<ToolbarAction>(json);
  }
}

mixin ToolbarActionMappable {
  String toJson() {
    return ToolbarActionMapper.ensureInitialized().encodeJson<ToolbarAction>(
      this as ToolbarAction,
    );
  }

  Map<String, dynamic> toMap() {
    return ToolbarActionMapper.ensureInitialized().encodeMap<ToolbarAction>(
      this as ToolbarAction,
    );
  }

  ToolbarActionCopyWith<ToolbarAction, ToolbarAction, ToolbarAction>
  get copyWith => _ToolbarActionCopyWithImpl<ToolbarAction, ToolbarAction>(
    this as ToolbarAction,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ToolbarActionMapper.ensureInitialized().stringifyValue(
      this as ToolbarAction,
    );
  }

  @override
  bool operator ==(Object other) {
    return ToolbarActionMapper.ensureInitialized().equalsValue(
      this as ToolbarAction,
      other,
    );
  }

  @override
  int get hashCode {
    return ToolbarActionMapper.ensureInitialized().hashValue(
      this as ToolbarAction,
    );
  }
}

extension ToolbarActionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ToolbarAction, $Out> {
  ToolbarActionCopyWith<$R, ToolbarAction, $Out> get $asToolbarAction =>
      $base.as((v, t, t2) => _ToolbarActionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ToolbarActionCopyWith<$R, $In extends ToolbarAction, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? label, bool? enabled});
  ToolbarActionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ToolbarActionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ToolbarAction, $Out>
    implements ToolbarActionCopyWith<$R, ToolbarAction, $Out> {
  _ToolbarActionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ToolbarAction> $mapper =
      ToolbarActionMapper.ensureInitialized();
  @override
  $R call({String? id, String? label, bool? enabled}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (label != null) #label: label,
      if (enabled != null) #enabled: enabled,
    }),
  );
  @override
  ToolbarAction $make(CopyWithData data) => ToolbarAction(
    id: data.get(#id, or: $value.id),
    label: data.get(#label, or: $value.label),
    enabled: data.get(#enabled, or: $value.enabled),
  );

  @override
  ToolbarActionCopyWith<$R2, ToolbarAction, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ToolbarActionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

