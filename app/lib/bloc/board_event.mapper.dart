// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'board_event.dart';

class BoardEventMapper extends ClassMapperBase<BoardEvent> {
  BoardEventMapper._();

  static BoardEventMapper? _instance;
  static BoardEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardEventMapper._());
      CellSwitchedMapper.ensureInitialized();
      HandChangedMapper.ensureInitialized();
      ObjectsSpawnedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardEvent';

  @override
  final MappableFields<BoardEvent> fields = const {};

  static BoardEvent _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('BoardEvent');
  }

  @override
  final Function instantiate = _instantiate;

  static BoardEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardEvent>(map);
  }

  static BoardEvent fromJson(String json) {
    return ensureInitialized().decodeJson<BoardEvent>(json);
  }
}

mixin BoardEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  BoardEventCopyWith<BoardEvent, BoardEvent, BoardEvent> get copyWith;
}

abstract class BoardEventCopyWith<$R, $In extends BoardEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  BoardEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class CellSwitchedMapper extends ClassMapperBase<CellSwitched> {
  CellSwitchedMapper._();

  static CellSwitchedMapper? _instance;
  static CellSwitchedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellSwitchedMapper._());
      BoardEventMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellSwitched';

  static VectorDefinition? _$cell(CellSwitched v) => v.cell;
  static const Field<CellSwitched, VectorDefinition> _f$cell =
      Field('cell', _$cell);
  static bool _$toggle(CellSwitched v) => v.toggle;
  static const Field<CellSwitched, bool> _f$toggle =
      Field('toggle', _$toggle, opt: true, def: false);

  @override
  final MappableFields<CellSwitched> fields = const {
    #cell: _f$cell,
    #toggle: _f$toggle,
  };

  static CellSwitched _instantiate(DecodingData data) {
    return CellSwitched(data.dec(_f$cell), toggle: data.dec(_f$toggle));
  }

  @override
  final Function instantiate = _instantiate;

  static CellSwitched fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellSwitched>(map);
  }

  static CellSwitched fromJson(String json) {
    return ensureInitialized().decodeJson<CellSwitched>(json);
  }
}

mixin CellSwitchedMappable {
  String toJson() {
    return CellSwitchedMapper.ensureInitialized()
        .encodeJson<CellSwitched>(this as CellSwitched);
  }

  Map<String, dynamic> toMap() {
    return CellSwitchedMapper.ensureInitialized()
        .encodeMap<CellSwitched>(this as CellSwitched);
  }

  CellSwitchedCopyWith<CellSwitched, CellSwitched, CellSwitched> get copyWith =>
      _CellSwitchedCopyWithImpl(this as CellSwitched, $identity, $identity);
  @override
  String toString() {
    return CellSwitchedMapper.ensureInitialized()
        .stringifyValue(this as CellSwitched);
  }

  @override
  bool operator ==(Object other) {
    return CellSwitchedMapper.ensureInitialized()
        .equalsValue(this as CellSwitched, other);
  }

  @override
  int get hashCode {
    return CellSwitchedMapper.ensureInitialized()
        .hashValue(this as CellSwitched);
  }
}

extension CellSwitchedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellSwitched, $Out> {
  CellSwitchedCopyWith<$R, CellSwitched, $Out> get $asCellSwitched =>
      $base.as((v, t, t2) => _CellSwitchedCopyWithImpl(v, t, t2));
}

abstract class CellSwitchedCopyWith<$R, $In extends CellSwitched, $Out>
    implements BoardEventCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get cell;
  @override
  $R call({VectorDefinition? cell, bool? toggle});
  CellSwitchedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CellSwitchedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellSwitched, $Out>
    implements CellSwitchedCopyWith<$R, CellSwitched, $Out> {
  _CellSwitchedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellSwitched> $mapper =
      CellSwitchedMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get cell =>
      $value.cell?.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({Object? cell = $none, bool? toggle}) => $apply(FieldCopyWithData(
      {if (cell != $none) #cell: cell, if (toggle != null) #toggle: toggle}));
  @override
  CellSwitched $make(CopyWithData data) =>
      CellSwitched(data.get(#cell, or: $value.cell),
          toggle: data.get(#toggle, or: $value.toggle));

  @override
  CellSwitchedCopyWith<$R2, CellSwitched, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CellSwitchedCopyWithImpl($value, $cast, t);
}

class HandChangedMapper extends ClassMapperBase<HandChanged> {
  HandChangedMapper._();

  static HandChangedMapper? _instance;
  static HandChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HandChangedMapper._());
      BoardEventMapper.ensureInitialized();
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HandChanged';

  static ItemLocation? _$deck(HandChanged v) => v.deck;
  static const Field<HandChanged, ItemLocation> _f$deck =
      Field('deck', _$deck, opt: true);
  static bool? _$show(HandChanged v) => v.show;
  static const Field<HandChanged, bool> _f$show =
      Field('show', _$show, opt: true, def: true);

  @override
  final MappableFields<HandChanged> fields = const {
    #deck: _f$deck,
    #show: _f$show,
  };

  static HandChanged _instantiate(DecodingData data) {
    return HandChanged(deck: data.dec(_f$deck), show: data.dec(_f$show));
  }

  @override
  final Function instantiate = _instantiate;

  static HandChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HandChanged>(map);
  }

  static HandChanged fromJson(String json) {
    return ensureInitialized().decodeJson<HandChanged>(json);
  }
}

mixin HandChangedMappable {
  String toJson() {
    return HandChangedMapper.ensureInitialized()
        .encodeJson<HandChanged>(this as HandChanged);
  }

  Map<String, dynamic> toMap() {
    return HandChangedMapper.ensureInitialized()
        .encodeMap<HandChanged>(this as HandChanged);
  }

  HandChangedCopyWith<HandChanged, HandChanged, HandChanged> get copyWith =>
      _HandChangedCopyWithImpl(this as HandChanged, $identity, $identity);
  @override
  String toString() {
    return HandChangedMapper.ensureInitialized()
        .stringifyValue(this as HandChanged);
  }

  @override
  bool operator ==(Object other) {
    return HandChangedMapper.ensureInitialized()
        .equalsValue(this as HandChanged, other);
  }

  @override
  int get hashCode {
    return HandChangedMapper.ensureInitialized().hashValue(this as HandChanged);
  }
}

extension HandChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HandChanged, $Out> {
  HandChangedCopyWith<$R, HandChanged, $Out> get $asHandChanged =>
      $base.as((v, t, t2) => _HandChangedCopyWithImpl(v, t, t2));
}

abstract class HandChangedCopyWith<$R, $In extends HandChanged, $Out>
    implements BoardEventCopyWith<$R, $In, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get deck;
  @override
  $R call({ItemLocation? deck, bool? show});
  HandChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HandChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HandChanged, $Out>
    implements HandChangedCopyWith<$R, HandChanged, $Out> {
  _HandChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HandChanged> $mapper =
      HandChangedMapper.ensureInitialized();
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get deck =>
      $value.deck?.copyWith.$chain((v) => call(deck: v));
  @override
  $R call({Object? deck = $none, bool? show}) => $apply(FieldCopyWithData(
      {if (deck != $none) #deck: deck, if (show != null) #show: show}));
  @override
  HandChanged $make(CopyWithData data) => HandChanged(
      deck: data.get(#deck, or: $value.deck),
      show: data.get(#show, or: $value.show));

  @override
  HandChangedCopyWith<$R2, HandChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HandChangedCopyWithImpl($value, $cast, t);
}

class ObjectsSpawnedMapper extends ClassMapperBase<ObjectsSpawned> {
  ObjectsSpawnedMapper._();

  static ObjectsSpawnedMapper? _instance;
  static ObjectsSpawnedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsSpawnedMapper._());
      BoardEventMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
      GameObjectMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectsSpawned';

  static VectorDefinition _$cell(ObjectsSpawned v) => v.cell;
  static const Field<ObjectsSpawned, VectorDefinition> _f$cell =
      Field('cell', _$cell);
  static List<GameObject> _$objects(ObjectsSpawned v) => v.objects;
  static const Field<ObjectsSpawned, List<GameObject>> _f$objects =
      Field('objects', _$objects);

  @override
  final MappableFields<ObjectsSpawned> fields = const {
    #cell: _f$cell,
    #objects: _f$objects,
  };

  static ObjectsSpawned _instantiate(DecodingData data) {
    return ObjectsSpawned(data.dec(_f$cell), data.dec(_f$objects));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectsSpawned fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectsSpawned>(map);
  }

  static ObjectsSpawned fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectsSpawned>(json);
  }
}

mixin ObjectsSpawnedMappable {
  String toJson() {
    return ObjectsSpawnedMapper.ensureInitialized()
        .encodeJson<ObjectsSpawned>(this as ObjectsSpawned);
  }

  Map<String, dynamic> toMap() {
    return ObjectsSpawnedMapper.ensureInitialized()
        .encodeMap<ObjectsSpawned>(this as ObjectsSpawned);
  }

  ObjectsSpawnedCopyWith<ObjectsSpawned, ObjectsSpawned, ObjectsSpawned>
      get copyWith => _ObjectsSpawnedCopyWithImpl(
          this as ObjectsSpawned, $identity, $identity);
  @override
  String toString() {
    return ObjectsSpawnedMapper.ensureInitialized()
        .stringifyValue(this as ObjectsSpawned);
  }

  @override
  bool operator ==(Object other) {
    return ObjectsSpawnedMapper.ensureInitialized()
        .equalsValue(this as ObjectsSpawned, other);
  }

  @override
  int get hashCode {
    return ObjectsSpawnedMapper.ensureInitialized()
        .hashValue(this as ObjectsSpawned);
  }
}

extension ObjectsSpawnedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectsSpawned, $Out> {
  ObjectsSpawnedCopyWith<$R, ObjectsSpawned, $Out> get $asObjectsSpawned =>
      $base.as((v, t, t2) => _ObjectsSpawnedCopyWithImpl(v, t, t2));
}

abstract class ObjectsSpawnedCopyWith<$R, $In extends ObjectsSpawned, $Out>
    implements BoardEventCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get cell;
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
      get objects;
  @override
  $R call({VectorDefinition? cell, List<GameObject>? objects});
  ObjectsSpawnedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ObjectsSpawnedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectsSpawned, $Out>
    implements ObjectsSpawnedCopyWith<$R, ObjectsSpawned, $Out> {
  _ObjectsSpawnedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectsSpawned> $mapper =
      ObjectsSpawnedMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get cell =>
      $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
      get objects => ListCopyWith($value.objects,
          (v, t) => v.copyWith.$chain(t), (v) => call(objects: v));
  @override
  $R call({VectorDefinition? cell, List<GameObject>? objects}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (objects != null) #objects: objects
      }));
  @override
  ObjectsSpawned $make(CopyWithData data) => ObjectsSpawned(
      data.get(#cell, or: $value.cell), data.get(#objects, or: $value.objects));

  @override
  ObjectsSpawnedCopyWith<$R2, ObjectsSpawned, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectsSpawnedCopyWithImpl($value, $cast, t);
}
