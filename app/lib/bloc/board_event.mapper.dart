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
      TableChangedMapper.ensureInitialized();
      CellSwitchedMapper.ensureInitialized();
      ColorSchemeChangedMapper.ensureInitialized();
      HandChangedMapper.ensureInitialized();
      ObjectsSpawnedMapper.ensureInitialized();
      ObjectsMovedMapper.ensureInitialized();
      CellHideChangedMapper.ensureInitialized();
      CellShuffledMapper.ensureInitialized();
      ObjectIndexChangedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardEvent';

  static bool _$isRemoteEvent(BoardEvent v) => v.isRemoteEvent;
  static const Field<BoardEvent, bool> _f$isRemoteEvent =
      Field('isRemoteEvent', _$isRemoteEvent, opt: true, def: false);

  @override
  final MappableFields<BoardEvent> fields = const {
    #isRemoteEvent: _f$isRemoteEvent,
  };

  @override
  final MappingHook hook = const IgnoreKeysHook({'isRemoteEvent'});
  static BoardEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'BoardEvent', 'type', '${data.value['type']}');
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
  $R call({bool? isRemoteEvent});
  BoardEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class TableChangedMapper extends SubClassMapperBase<TableChanged> {
  TableChangedMapper._();

  static TableChangedMapper? _instance;
  static TableChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableChangedMapper._());
      BoardEventMapper.ensureInitialized().addSubMapper(_instance!);
      GameTableMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TableChanged';

  static GameTable _$table(TableChanged v) => v.table;
  static const Field<TableChanged, GameTable> _f$table =
      Field('table', _$table);
  static bool _$isRemoteEvent(TableChanged v) => v.isRemoteEvent;
  static const Field<TableChanged, bool> _f$isRemoteEvent =
      Field('isRemoteEvent', _$isRemoteEvent, opt: true, def: false);

  @override
  final MappableFields<TableChanged> fields = const {
    #table: _f$table,
    #isRemoteEvent: _f$isRemoteEvent,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TableChanged';
  @override
  late final ClassMapperBase superMapper = BoardEventMapper.ensureInitialized();

  @override
  final MappingHook superHook = const IgnoreKeysHook({'isRemoteEvent'});

  static TableChanged _instantiate(DecodingData data) {
    return TableChanged(data.dec(_f$table),
        isRemoteEvent: data.dec(_f$isRemoteEvent));
  }

  @override
  final Function instantiate = _instantiate;

  static TableChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableChanged>(map);
  }

  static TableChanged fromJson(String json) {
    return ensureInitialized().decodeJson<TableChanged>(json);
  }
}

mixin TableChangedMappable {
  String toJson() {
    return TableChangedMapper.ensureInitialized()
        .encodeJson<TableChanged>(this as TableChanged);
  }

  Map<String, dynamic> toMap() {
    return TableChangedMapper.ensureInitialized()
        .encodeMap<TableChanged>(this as TableChanged);
  }

  TableChangedCopyWith<TableChanged, TableChanged, TableChanged> get copyWith =>
      _TableChangedCopyWithImpl(this as TableChanged, $identity, $identity);
  @override
  String toString() {
    return TableChangedMapper.ensureInitialized()
        .stringifyValue(this as TableChanged);
  }

  @override
  bool operator ==(Object other) {
    return TableChangedMapper.ensureInitialized()
        .equalsValue(this as TableChanged, other);
  }

  @override
  int get hashCode {
    return TableChangedMapper.ensureInitialized()
        .hashValue(this as TableChanged);
  }
}

extension TableChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TableChanged, $Out> {
  TableChangedCopyWith<$R, TableChanged, $Out> get $asTableChanged =>
      $base.as((v, t, t2) => _TableChangedCopyWithImpl(v, t, t2));
}

abstract class TableChangedCopyWith<$R, $In extends TableChanged, $Out>
    implements BoardEventCopyWith<$R, $In, $Out> {
  GameTableCopyWith<$R, GameTable, GameTable> get table;
  @override
  $R call({GameTable? table, bool? isRemoteEvent});
  TableChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TableChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableChanged, $Out>
    implements TableChangedCopyWith<$R, TableChanged, $Out> {
  _TableChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableChanged> $mapper =
      TableChangedMapper.ensureInitialized();
  @override
  GameTableCopyWith<$R, GameTable, GameTable> get table =>
      $value.table.copyWith.$chain((v) => call(table: v));
  @override
  $R call({GameTable? table, bool? isRemoteEvent}) => $apply(FieldCopyWithData({
        if (table != null) #table: table,
        if (isRemoteEvent != null) #isRemoteEvent: isRemoteEvent
      }));
  @override
  TableChanged $make(CopyWithData data) =>
      TableChanged(data.get(#table, or: $value.table),
          isRemoteEvent: data.get(#isRemoteEvent, or: $value.isRemoteEvent));

  @override
  TableChangedCopyWith<$R2, TableChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableChangedCopyWithImpl($value, $cast, t);
}

class CellSwitchedMapper extends SubClassMapperBase<CellSwitched> {
  CellSwitchedMapper._();

  static CellSwitchedMapper? _instance;
  static CellSwitchedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellSwitchedMapper._());
      BoardEventMapper.ensureInitialized().addSubMapper(_instance!);
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
  static bool _$isRemoteEvent(CellSwitched v) => v.isRemoteEvent;
  static const Field<CellSwitched, bool> _f$isRemoteEvent =
      Field('isRemoteEvent', _$isRemoteEvent, opt: true, def: false);

  @override
  final MappableFields<CellSwitched> fields = const {
    #cell: _f$cell,
    #toggle: _f$toggle,
    #isRemoteEvent: _f$isRemoteEvent,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellSwitched';
  @override
  late final ClassMapperBase superMapper = BoardEventMapper.ensureInitialized();

  @override
  final MappingHook superHook = const IgnoreKeysHook({'isRemoteEvent'});

  static CellSwitched _instantiate(DecodingData data) {
    return CellSwitched(data.dec(_f$cell),
        toggle: data.dec(_f$toggle), isRemoteEvent: data.dec(_f$isRemoteEvent));
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
  $R call({VectorDefinition? cell, bool? toggle, bool? isRemoteEvent});
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
  $R call({Object? cell = $none, bool? toggle, bool? isRemoteEvent}) =>
      $apply(FieldCopyWithData({
        if (cell != $none) #cell: cell,
        if (toggle != null) #toggle: toggle,
        if (isRemoteEvent != null) #isRemoteEvent: isRemoteEvent
      }));
  @override
  CellSwitched $make(CopyWithData data) =>
      CellSwitched(data.get(#cell, or: $value.cell),
          toggle: data.get(#toggle, or: $value.toggle),
          isRemoteEvent: data.get(#isRemoteEvent, or: $value.isRemoteEvent));

  @override
  CellSwitchedCopyWith<$R2, CellSwitched, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CellSwitchedCopyWithImpl($value, $cast, t);
}

class ColorSchemeChangedMapper extends SubClassMapperBase<ColorSchemeChanged> {
  ColorSchemeChangedMapper._();

  static ColorSchemeChangedMapper? _instance;
  static ColorSchemeChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ColorSchemeChangedMapper._());
      BoardEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'ColorSchemeChanged';

  static ColorScheme? _$colorScheme(ColorSchemeChanged v) => v.colorScheme;
  static const Field<ColorSchemeChanged, ColorScheme> _f$colorScheme =
      Field('colorScheme', _$colorScheme);
  static bool _$isRemoteEvent(ColorSchemeChanged v) => v.isRemoteEvent;
  static const Field<ColorSchemeChanged, bool> _f$isRemoteEvent =
      Field('isRemoteEvent', _$isRemoteEvent, opt: true, def: false);

  @override
  final MappableFields<ColorSchemeChanged> fields = const {
    #colorScheme: _f$colorScheme,
    #isRemoteEvent: _f$isRemoteEvent,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ColorSchemeChanged';
  @override
  late final ClassMapperBase superMapper = BoardEventMapper.ensureInitialized();

  @override
  final MappingHook superHook = const IgnoreKeysHook({'isRemoteEvent'});

  static ColorSchemeChanged _instantiate(DecodingData data) {
    return ColorSchemeChanged(data.dec(_f$colorScheme),
        isRemoteEvent: data.dec(_f$isRemoteEvent));
  }

  @override
  final Function instantiate = _instantiate;

  static ColorSchemeChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ColorSchemeChanged>(map);
  }

  static ColorSchemeChanged fromJson(String json) {
    return ensureInitialized().decodeJson<ColorSchemeChanged>(json);
  }
}

mixin ColorSchemeChangedMappable {
  String toJson() {
    return ColorSchemeChangedMapper.ensureInitialized()
        .encodeJson<ColorSchemeChanged>(this as ColorSchemeChanged);
  }

  Map<String, dynamic> toMap() {
    return ColorSchemeChangedMapper.ensureInitialized()
        .encodeMap<ColorSchemeChanged>(this as ColorSchemeChanged);
  }

  ColorSchemeChangedCopyWith<ColorSchemeChanged, ColorSchemeChanged,
          ColorSchemeChanged>
      get copyWith => _ColorSchemeChangedCopyWithImpl(
          this as ColorSchemeChanged, $identity, $identity);
  @override
  String toString() {
    return ColorSchemeChangedMapper.ensureInitialized()
        .stringifyValue(this as ColorSchemeChanged);
  }

  @override
  bool operator ==(Object other) {
    return ColorSchemeChangedMapper.ensureInitialized()
        .equalsValue(this as ColorSchemeChanged, other);
  }

  @override
  int get hashCode {
    return ColorSchemeChangedMapper.ensureInitialized()
        .hashValue(this as ColorSchemeChanged);
  }
}

extension ColorSchemeChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ColorSchemeChanged, $Out> {
  ColorSchemeChangedCopyWith<$R, ColorSchemeChanged, $Out>
      get $asColorSchemeChanged =>
          $base.as((v, t, t2) => _ColorSchemeChangedCopyWithImpl(v, t, t2));
}

abstract class ColorSchemeChangedCopyWith<$R, $In extends ColorSchemeChanged,
    $Out> implements BoardEventCopyWith<$R, $In, $Out> {
  @override
  $R call({ColorScheme? colorScheme, bool? isRemoteEvent});
  ColorSchemeChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ColorSchemeChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ColorSchemeChanged, $Out>
    implements ColorSchemeChangedCopyWith<$R, ColorSchemeChanged, $Out> {
  _ColorSchemeChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ColorSchemeChanged> $mapper =
      ColorSchemeChangedMapper.ensureInitialized();
  @override
  $R call({Object? colorScheme = $none, bool? isRemoteEvent}) =>
      $apply(FieldCopyWithData({
        if (colorScheme != $none) #colorScheme: colorScheme,
        if (isRemoteEvent != null) #isRemoteEvent: isRemoteEvent
      }));
  @override
  ColorSchemeChanged $make(CopyWithData data) =>
      ColorSchemeChanged(data.get(#colorScheme, or: $value.colorScheme),
          isRemoteEvent: data.get(#isRemoteEvent, or: $value.isRemoteEvent));

  @override
  ColorSchemeChangedCopyWith<$R2, ColorSchemeChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ColorSchemeChangedCopyWithImpl($value, $cast, t);
}

class HandChangedMapper extends SubClassMapperBase<HandChanged> {
  HandChangedMapper._();

  static HandChangedMapper? _instance;
  static HandChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HandChangedMapper._());
      BoardEventMapper.ensureInitialized().addSubMapper(_instance!);
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
  static bool _$isRemoteEvent(HandChanged v) => v.isRemoteEvent;
  static const Field<HandChanged, bool> _f$isRemoteEvent =
      Field('isRemoteEvent', _$isRemoteEvent, opt: true, def: false);

  @override
  final MappableFields<HandChanged> fields = const {
    #deck: _f$deck,
    #show: _f$show,
    #isRemoteEvent: _f$isRemoteEvent,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'HandChanged';
  @override
  late final ClassMapperBase superMapper = BoardEventMapper.ensureInitialized();

  @override
  final MappingHook superHook = const IgnoreKeysHook({'isRemoteEvent'});

  static HandChanged _instantiate(DecodingData data) {
    return HandChanged(
        deck: data.dec(_f$deck),
        show: data.dec(_f$show),
        isRemoteEvent: data.dec(_f$isRemoteEvent));
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
  $R call({ItemLocation? deck, bool? show, bool? isRemoteEvent});
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
  $R call({Object? deck = $none, bool? show, bool? isRemoteEvent}) =>
      $apply(FieldCopyWithData({
        if (deck != $none) #deck: deck,
        if (show != null) #show: show,
        if (isRemoteEvent != null) #isRemoteEvent: isRemoteEvent
      }));
  @override
  HandChanged $make(CopyWithData data) => HandChanged(
      deck: data.get(#deck, or: $value.deck),
      show: data.get(#show, or: $value.show),
      isRemoteEvent: data.get(#isRemoteEvent, or: $value.isRemoteEvent));

  @override
  HandChangedCopyWith<$R2, HandChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HandChangedCopyWithImpl($value, $cast, t);
}

class ObjectsSpawnedMapper extends SubClassMapperBase<ObjectsSpawned> {
  ObjectsSpawnedMapper._();

  static ObjectsSpawnedMapper? _instance;
  static ObjectsSpawnedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsSpawnedMapper._());
      BoardEventMapper.ensureInitialized().addSubMapper(_instance!);
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
  static bool _$isRemoteEvent(ObjectsSpawned v) => v.isRemoteEvent;
  static const Field<ObjectsSpawned, bool> _f$isRemoteEvent =
      Field('isRemoteEvent', _$isRemoteEvent, opt: true, def: false);

  @override
  final MappableFields<ObjectsSpawned> fields = const {
    #cell: _f$cell,
    #objects: _f$objects,
    #isRemoteEvent: _f$isRemoteEvent,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectsSpawned';
  @override
  late final ClassMapperBase superMapper = BoardEventMapper.ensureInitialized();

  @override
  final MappingHook superHook = const IgnoreKeysHook({'isRemoteEvent'});

  static ObjectsSpawned _instantiate(DecodingData data) {
    return ObjectsSpawned(data.dec(_f$cell), data.dec(_f$objects),
        isRemoteEvent: data.dec(_f$isRemoteEvent));
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
  $R call(
      {VectorDefinition? cell, List<GameObject>? objects, bool? isRemoteEvent});
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
  $R call(
          {VectorDefinition? cell,
          List<GameObject>? objects,
          bool? isRemoteEvent}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (objects != null) #objects: objects,
        if (isRemoteEvent != null) #isRemoteEvent: isRemoteEvent
      }));
  @override
  ObjectsSpawned $make(CopyWithData data) => ObjectsSpawned(
      data.get(#cell, or: $value.cell), data.get(#objects, or: $value.objects),
      isRemoteEvent: data.get(#isRemoteEvent, or: $value.isRemoteEvent));

  @override
  ObjectsSpawnedCopyWith<$R2, ObjectsSpawned, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectsSpawnedCopyWithImpl($value, $cast, t);
}

class ObjectsMovedMapper extends SubClassMapperBase<ObjectsMoved> {
  ObjectsMovedMapper._();

  static ObjectsMovedMapper? _instance;
  static ObjectsMovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsMovedMapper._());
      BoardEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectsMoved';

  static List<int> _$objects(ObjectsMoved v) => v.objects;
  static const Field<ObjectsMoved, List<int>> _f$objects =
      Field('objects', _$objects);
  static VectorDefinition _$from(ObjectsMoved v) => v.from;
  static const Field<ObjectsMoved, VectorDefinition> _f$from =
      Field('from', _$from);
  static VectorDefinition _$to(ObjectsMoved v) => v.to;
  static const Field<ObjectsMoved, VectorDefinition> _f$to = Field('to', _$to);
  static bool _$isRemoteEvent(ObjectsMoved v) => v.isRemoteEvent;
  static const Field<ObjectsMoved, bool> _f$isRemoteEvent =
      Field('isRemoteEvent', _$isRemoteEvent, opt: true, def: false);

  @override
  final MappableFields<ObjectsMoved> fields = const {
    #objects: _f$objects,
    #from: _f$from,
    #to: _f$to,
    #isRemoteEvent: _f$isRemoteEvent,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectsMoved';
  @override
  late final ClassMapperBase superMapper = BoardEventMapper.ensureInitialized();

  @override
  final MappingHook superHook = const IgnoreKeysHook({'isRemoteEvent'});

  static ObjectsMoved _instantiate(DecodingData data) {
    return ObjectsMoved(
        data.dec(_f$objects), data.dec(_f$from), data.dec(_f$to),
        isRemoteEvent: data.dec(_f$isRemoteEvent));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectsMoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectsMoved>(map);
  }

  static ObjectsMoved fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectsMoved>(json);
  }
}

mixin ObjectsMovedMappable {
  String toJson() {
    return ObjectsMovedMapper.ensureInitialized()
        .encodeJson<ObjectsMoved>(this as ObjectsMoved);
  }

  Map<String, dynamic> toMap() {
    return ObjectsMovedMapper.ensureInitialized()
        .encodeMap<ObjectsMoved>(this as ObjectsMoved);
  }

  ObjectsMovedCopyWith<ObjectsMoved, ObjectsMoved, ObjectsMoved> get copyWith =>
      _ObjectsMovedCopyWithImpl(this as ObjectsMoved, $identity, $identity);
  @override
  String toString() {
    return ObjectsMovedMapper.ensureInitialized()
        .stringifyValue(this as ObjectsMoved);
  }

  @override
  bool operator ==(Object other) {
    return ObjectsMovedMapper.ensureInitialized()
        .equalsValue(this as ObjectsMoved, other);
  }

  @override
  int get hashCode {
    return ObjectsMovedMapper.ensureInitialized()
        .hashValue(this as ObjectsMoved);
  }
}

extension ObjectsMovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectsMoved, $Out> {
  ObjectsMovedCopyWith<$R, ObjectsMoved, $Out> get $asObjectsMoved =>
      $base.as((v, t, t2) => _ObjectsMovedCopyWithImpl(v, t, t2));
}

abstract class ObjectsMovedCopyWith<$R, $In extends ObjectsMoved, $Out>
    implements BoardEventCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get objects;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get from;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get to;
  @override
  $R call(
      {List<int>? objects,
      VectorDefinition? from,
      VectorDefinition? to,
      bool? isRemoteEvent});
  ObjectsMovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectsMovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectsMoved, $Out>
    implements ObjectsMovedCopyWith<$R, ObjectsMoved, $Out> {
  _ObjectsMovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectsMoved> $mapper =
      ObjectsMovedMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get objects =>
      ListCopyWith($value.objects, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(objects: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get from =>
      $value.from.copyWith.$chain((v) => call(from: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get to =>
      $value.to.copyWith.$chain((v) => call(to: v));
  @override
  $R call(
          {List<int>? objects,
          VectorDefinition? from,
          VectorDefinition? to,
          bool? isRemoteEvent}) =>
      $apply(FieldCopyWithData({
        if (objects != null) #objects: objects,
        if (from != null) #from: from,
        if (to != null) #to: to,
        if (isRemoteEvent != null) #isRemoteEvent: isRemoteEvent
      }));
  @override
  ObjectsMoved $make(CopyWithData data) => ObjectsMoved(
      data.get(#objects, or: $value.objects),
      data.get(#from, or: $value.from),
      data.get(#to, or: $value.to),
      isRemoteEvent: data.get(#isRemoteEvent, or: $value.isRemoteEvent));

  @override
  ObjectsMovedCopyWith<$R2, ObjectsMoved, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectsMovedCopyWithImpl($value, $cast, t);
}

class CellHideChangedMapper extends SubClassMapperBase<CellHideChanged> {
  CellHideChangedMapper._();

  static CellHideChangedMapper? _instance;
  static CellHideChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellHideChangedMapper._());
      BoardEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellHideChanged';

  static VectorDefinition _$cell(CellHideChanged v) => v.cell;
  static const Field<CellHideChanged, VectorDefinition> _f$cell =
      Field('cell', _$cell);
  static int? _$object(CellHideChanged v) => v.object;
  static const Field<CellHideChanged, int> _f$object =
      Field('object', _$object, opt: true);
  static bool? _$hide(CellHideChanged v) => v.hide;
  static const Field<CellHideChanged, bool> _f$hide =
      Field('hide', _$hide, opt: true);
  static bool _$isRemoteEvent(CellHideChanged v) => v.isRemoteEvent;
  static const Field<CellHideChanged, bool> _f$isRemoteEvent =
      Field('isRemoteEvent', _$isRemoteEvent, opt: true, def: false);

  @override
  final MappableFields<CellHideChanged> fields = const {
    #cell: _f$cell,
    #object: _f$object,
    #hide: _f$hide,
    #isRemoteEvent: _f$isRemoteEvent,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellHideChanged';
  @override
  late final ClassMapperBase superMapper = BoardEventMapper.ensureInitialized();

  @override
  final MappingHook superHook = const IgnoreKeysHook({'isRemoteEvent'});

  static CellHideChanged _instantiate(DecodingData data) {
    return CellHideChanged(data.dec(_f$cell),
        object: data.dec(_f$object),
        hide: data.dec(_f$hide),
        isRemoteEvent: data.dec(_f$isRemoteEvent));
  }

  @override
  final Function instantiate = _instantiate;

  static CellHideChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellHideChanged>(map);
  }

  static CellHideChanged fromJson(String json) {
    return ensureInitialized().decodeJson<CellHideChanged>(json);
  }
}

mixin CellHideChangedMappable {
  String toJson() {
    return CellHideChangedMapper.ensureInitialized()
        .encodeJson<CellHideChanged>(this as CellHideChanged);
  }

  Map<String, dynamic> toMap() {
    return CellHideChangedMapper.ensureInitialized()
        .encodeMap<CellHideChanged>(this as CellHideChanged);
  }

  CellHideChangedCopyWith<CellHideChanged, CellHideChanged, CellHideChanged>
      get copyWith => _CellHideChangedCopyWithImpl(
          this as CellHideChanged, $identity, $identity);
  @override
  String toString() {
    return CellHideChangedMapper.ensureInitialized()
        .stringifyValue(this as CellHideChanged);
  }

  @override
  bool operator ==(Object other) {
    return CellHideChangedMapper.ensureInitialized()
        .equalsValue(this as CellHideChanged, other);
  }

  @override
  int get hashCode {
    return CellHideChangedMapper.ensureInitialized()
        .hashValue(this as CellHideChanged);
  }
}

extension CellHideChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellHideChanged, $Out> {
  CellHideChangedCopyWith<$R, CellHideChanged, $Out> get $asCellHideChanged =>
      $base.as((v, t, t2) => _CellHideChangedCopyWithImpl(v, t, t2));
}

abstract class CellHideChangedCopyWith<$R, $In extends CellHideChanged, $Out>
    implements BoardEventCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get cell;
  @override
  $R call(
      {VectorDefinition? cell, int? object, bool? hide, bool? isRemoteEvent});
  CellHideChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CellHideChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellHideChanged, $Out>
    implements CellHideChangedCopyWith<$R, CellHideChanged, $Out> {
  _CellHideChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellHideChanged> $mapper =
      CellHideChangedMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get cell =>
      $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call(
          {VectorDefinition? cell,
          Object? object = $none,
          Object? hide = $none,
          bool? isRemoteEvent}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (object != $none) #object: object,
        if (hide != $none) #hide: hide,
        if (isRemoteEvent != null) #isRemoteEvent: isRemoteEvent
      }));
  @override
  CellHideChanged $make(CopyWithData data) =>
      CellHideChanged(data.get(#cell, or: $value.cell),
          object: data.get(#object, or: $value.object),
          hide: data.get(#hide, or: $value.hide),
          isRemoteEvent: data.get(#isRemoteEvent, or: $value.isRemoteEvent));

  @override
  CellHideChangedCopyWith<$R2, CellHideChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CellHideChangedCopyWithImpl($value, $cast, t);
}

class CellShuffledMapper extends SubClassMapperBase<CellShuffled> {
  CellShuffledMapper._();

  static CellShuffledMapper? _instance;
  static CellShuffledMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellShuffledMapper._());
      BoardEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellShuffled';

  static VectorDefinition _$cell(CellShuffled v) => v.cell;
  static const Field<CellShuffled, VectorDefinition> _f$cell =
      Field('cell', _$cell);
  static int _$seed(CellShuffled v) => v.seed;
  static const Field<CellShuffled, int> _f$seed = Field('seed', _$seed);
  static bool _$isRemoteEvent(CellShuffled v) => v.isRemoteEvent;
  static const Field<CellShuffled, bool> _f$isRemoteEvent =
      Field('isRemoteEvent', _$isRemoteEvent, opt: true, def: false);

  @override
  final MappableFields<CellShuffled> fields = const {
    #cell: _f$cell,
    #seed: _f$seed,
    #isRemoteEvent: _f$isRemoteEvent,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellShuffled';
  @override
  late final ClassMapperBase superMapper = BoardEventMapper.ensureInitialized();

  @override
  final MappingHook superHook = const IgnoreKeysHook({'isRemoteEvent'});

  static CellShuffled _instantiate(DecodingData data) {
    return CellShuffled(data.dec(_f$cell), data.dec(_f$seed),
        isRemoteEvent: data.dec(_f$isRemoteEvent));
  }

  @override
  final Function instantiate = _instantiate;

  static CellShuffled fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellShuffled>(map);
  }

  static CellShuffled fromJson(String json) {
    return ensureInitialized().decodeJson<CellShuffled>(json);
  }
}

mixin CellShuffledMappable {
  String toJson() {
    return CellShuffledMapper.ensureInitialized()
        .encodeJson<CellShuffled>(this as CellShuffled);
  }

  Map<String, dynamic> toMap() {
    return CellShuffledMapper.ensureInitialized()
        .encodeMap<CellShuffled>(this as CellShuffled);
  }

  CellShuffledCopyWith<CellShuffled, CellShuffled, CellShuffled> get copyWith =>
      _CellShuffledCopyWithImpl(this as CellShuffled, $identity, $identity);
  @override
  String toString() {
    return CellShuffledMapper.ensureInitialized()
        .stringifyValue(this as CellShuffled);
  }

  @override
  bool operator ==(Object other) {
    return CellShuffledMapper.ensureInitialized()
        .equalsValue(this as CellShuffled, other);
  }

  @override
  int get hashCode {
    return CellShuffledMapper.ensureInitialized()
        .hashValue(this as CellShuffled);
  }
}

extension CellShuffledValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellShuffled, $Out> {
  CellShuffledCopyWith<$R, CellShuffled, $Out> get $asCellShuffled =>
      $base.as((v, t, t2) => _CellShuffledCopyWithImpl(v, t, t2));
}

abstract class CellShuffledCopyWith<$R, $In extends CellShuffled, $Out>
    implements BoardEventCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get cell;
  @override
  $R call({VectorDefinition? cell, int? seed, bool? isRemoteEvent});
  CellShuffledCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CellShuffledCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellShuffled, $Out>
    implements CellShuffledCopyWith<$R, CellShuffled, $Out> {
  _CellShuffledCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellShuffled> $mapper =
      CellShuffledMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get cell =>
      $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({VectorDefinition? cell, int? seed, bool? isRemoteEvent}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (seed != null) #seed: seed,
        if (isRemoteEvent != null) #isRemoteEvent: isRemoteEvent
      }));
  @override
  CellShuffled $make(CopyWithData data) => CellShuffled(
      data.get(#cell, or: $value.cell), data.get(#seed, or: $value.seed),
      isRemoteEvent: data.get(#isRemoteEvent, or: $value.isRemoteEvent));

  @override
  CellShuffledCopyWith<$R2, CellShuffled, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CellShuffledCopyWithImpl($value, $cast, t);
}

class ObjectIndexChangedMapper extends SubClassMapperBase<ObjectIndexChanged> {
  ObjectIndexChangedMapper._();

  static ObjectIndexChangedMapper? _instance;
  static ObjectIndexChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIndexChangedMapper._());
      BoardEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIndexChanged';

  static VectorDefinition _$cell(ObjectIndexChanged v) => v.cell;
  static const Field<ObjectIndexChanged, VectorDefinition> _f$cell =
      Field('cell', _$cell);
  static int _$object(ObjectIndexChanged v) => v.object;
  static const Field<ObjectIndexChanged, int> _f$object =
      Field('object', _$object);
  static int _$index(ObjectIndexChanged v) => v.index;
  static const Field<ObjectIndexChanged, int> _f$index =
      Field('index', _$index);
  static bool _$isRemoteEvent(ObjectIndexChanged v) => v.isRemoteEvent;
  static const Field<ObjectIndexChanged, bool> _f$isRemoteEvent =
      Field('isRemoteEvent', _$isRemoteEvent, opt: true, def: false);

  @override
  final MappableFields<ObjectIndexChanged> fields = const {
    #cell: _f$cell,
    #object: _f$object,
    #index: _f$index,
    #isRemoteEvent: _f$isRemoteEvent,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectIndexChanged';
  @override
  late final ClassMapperBase superMapper = BoardEventMapper.ensureInitialized();

  @override
  final MappingHook superHook = const IgnoreKeysHook({'isRemoteEvent'});

  static ObjectIndexChanged _instantiate(DecodingData data) {
    return ObjectIndexChanged(
        data.dec(_f$cell), data.dec(_f$object), data.dec(_f$index),
        isRemoteEvent: data.dec(_f$isRemoteEvent));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIndexChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIndexChanged>(map);
  }

  static ObjectIndexChanged fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIndexChanged>(json);
  }
}

mixin ObjectIndexChangedMappable {
  String toJson() {
    return ObjectIndexChangedMapper.ensureInitialized()
        .encodeJson<ObjectIndexChanged>(this as ObjectIndexChanged);
  }

  Map<String, dynamic> toMap() {
    return ObjectIndexChangedMapper.ensureInitialized()
        .encodeMap<ObjectIndexChanged>(this as ObjectIndexChanged);
  }

  ObjectIndexChangedCopyWith<ObjectIndexChanged, ObjectIndexChanged,
          ObjectIndexChanged>
      get copyWith => _ObjectIndexChangedCopyWithImpl(
          this as ObjectIndexChanged, $identity, $identity);
  @override
  String toString() {
    return ObjectIndexChangedMapper.ensureInitialized()
        .stringifyValue(this as ObjectIndexChanged);
  }

  @override
  bool operator ==(Object other) {
    return ObjectIndexChangedMapper.ensureInitialized()
        .equalsValue(this as ObjectIndexChanged, other);
  }

  @override
  int get hashCode {
    return ObjectIndexChangedMapper.ensureInitialized()
        .hashValue(this as ObjectIndexChanged);
  }
}

extension ObjectIndexChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIndexChanged, $Out> {
  ObjectIndexChangedCopyWith<$R, ObjectIndexChanged, $Out>
      get $asObjectIndexChanged =>
          $base.as((v, t, t2) => _ObjectIndexChangedCopyWithImpl(v, t, t2));
}

abstract class ObjectIndexChangedCopyWith<$R, $In extends ObjectIndexChanged,
    $Out> implements BoardEventCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get cell;
  @override
  $R call(
      {VectorDefinition? cell, int? object, int? index, bool? isRemoteEvent});
  ObjectIndexChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ObjectIndexChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIndexChanged, $Out>
    implements ObjectIndexChangedCopyWith<$R, ObjectIndexChanged, $Out> {
  _ObjectIndexChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIndexChanged> $mapper =
      ObjectIndexChangedMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get cell =>
      $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call(
          {VectorDefinition? cell,
          int? object,
          int? index,
          bool? isRemoteEvent}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (object != null) #object: object,
        if (index != null) #index: index,
        if (isRemoteEvent != null) #isRemoteEvent: isRemoteEvent
      }));
  @override
  ObjectIndexChanged $make(CopyWithData data) => ObjectIndexChanged(
      data.get(#cell, or: $value.cell),
      data.get(#object, or: $value.object),
      data.get(#index, or: $value.index),
      isRemoteEvent: data.get(#isRemoteEvent, or: $value.isRemoteEvent));

  @override
  ObjectIndexChangedCopyWith<$R2, ObjectIndexChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIndexChangedCopyWithImpl($value, $cast, t);
}
