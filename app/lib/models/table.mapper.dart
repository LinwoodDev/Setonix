// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'table.dart';

class GridLocationMapper extends ClassMapperBase<GridLocation> {
  GridLocationMapper._();

  static GridLocationMapper? _instance;
  static GridLocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GridLocationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GridLocation';

  static int _$x(GridLocation v) => v.x;
  static const Field<GridLocation, int> _f$x = Field('x', _$x);
  static int _$y(GridLocation v) => v.y;
  static const Field<GridLocation, int> _f$y = Field('y', _$y);

  @override
  final MappableFields<GridLocation> fields = const {
    #x: _f$x,
    #y: _f$y,
  };

  static GridLocation _instantiate(DecodingData data) {
    return GridLocation(data.dec(_f$x), data.dec(_f$y));
  }

  @override
  final Function instantiate = _instantiate;

  static GridLocation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GridLocation>(map);
  }

  static GridLocation fromJson(String json) {
    return ensureInitialized().decodeJson<GridLocation>(json);
  }
}

mixin GridLocationMappable {
  String toJson() {
    return GridLocationMapper.ensureInitialized()
        .encodeJson<GridLocation>(this as GridLocation);
  }

  Map<String, dynamic> toMap() {
    return GridLocationMapper.ensureInitialized()
        .encodeMap<GridLocation>(this as GridLocation);
  }

  GridLocationCopyWith<GridLocation, GridLocation, GridLocation> get copyWith =>
      _GridLocationCopyWithImpl(this as GridLocation, $identity, $identity);
  @override
  String toString() {
    return GridLocationMapper.ensureInitialized()
        .stringifyValue(this as GridLocation);
  }

  @override
  bool operator ==(Object other) {
    return GridLocationMapper.ensureInitialized()
        .equalsValue(this as GridLocation, other);
  }

  @override
  int get hashCode {
    return GridLocationMapper.ensureInitialized()
        .hashValue(this as GridLocation);
  }
}

extension GridLocationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GridLocation, $Out> {
  GridLocationCopyWith<$R, GridLocation, $Out> get $asGridLocation =>
      $base.as((v, t, t2) => _GridLocationCopyWithImpl(v, t, t2));
}

abstract class GridLocationCopyWith<$R, $In extends GridLocation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? x, int? y});
  GridLocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GridLocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GridLocation, $Out>
    implements GridLocationCopyWith<$R, GridLocation, $Out> {
  _GridLocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GridLocation> $mapper =
      GridLocationMapper.ensureInitialized();
  @override
  $R call({int? x, int? y}) =>
      $apply(FieldCopyWithData({if (x != null) #x: x, if (y != null) #y: y}));
  @override
  GridLocation $make(CopyWithData data) =>
      GridLocation(data.get(#x, or: $value.x), data.get(#y, or: $value.y));

  @override
  GridLocationCopyWith<$R2, GridLocation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GridLocationCopyWithImpl($value, $cast, t);
}

class GameTableMapper extends ClassMapperBase<GameTable> {
  GameTableMapper._();

  static GameTableMapper? _instance;
  static GameTableMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameTableMapper._());
      GridLocationMapper.ensureInitialized();
      TableCellMapper.ensureInitialized();
      GameBoardMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameTable';

  static Map<GridLocation, TableCell> _$cells(GameTable v) => v.cells;
  static const Field<GameTable, Map<GridLocation, TableCell>> _f$cells =
      Field('cells', _$cells, opt: true, def: const {});
  static Map<GridLocation, GameBoard> _$boards(GameTable v) => v.boards;
  static const Field<GameTable, Map<GridLocation, GameBoard>> _f$boards =
      Field('boards', _$boards, opt: true, def: const {});

  @override
  final MappableFields<GameTable> fields = const {
    #cells: _f$cells,
    #boards: _f$boards,
  };

  static GameTable _instantiate(DecodingData data) {
    return GameTable(cells: data.dec(_f$cells), boards: data.dec(_f$boards));
  }

  @override
  final Function instantiate = _instantiate;

  static GameTable fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameTable>(map);
  }

  static GameTable fromJson(String json) {
    return ensureInitialized().decodeJson<GameTable>(json);
  }
}

mixin GameTableMappable {
  String toJson() {
    return GameTableMapper.ensureInitialized()
        .encodeJson<GameTable>(this as GameTable);
  }

  Map<String, dynamic> toMap() {
    return GameTableMapper.ensureInitialized()
        .encodeMap<GameTable>(this as GameTable);
  }

  GameTableCopyWith<GameTable, GameTable, GameTable> get copyWith =>
      _GameTableCopyWithImpl(this as GameTable, $identity, $identity);
  @override
  String toString() {
    return GameTableMapper.ensureInitialized()
        .stringifyValue(this as GameTable);
  }

  @override
  bool operator ==(Object other) {
    return GameTableMapper.ensureInitialized()
        .equalsValue(this as GameTable, other);
  }

  @override
  int get hashCode {
    return GameTableMapper.ensureInitialized().hashValue(this as GameTable);
  }
}

extension GameTableValueCopy<$R, $Out> on ObjectCopyWith<$R, GameTable, $Out> {
  GameTableCopyWith<$R, GameTable, $Out> get $asGameTable =>
      $base.as((v, t, t2) => _GameTableCopyWithImpl(v, t, t2));
}

abstract class GameTableCopyWith<$R, $In extends GameTable, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, GridLocation, TableCell,
      TableCellCopyWith<$R, TableCell, TableCell>> get cells;
  MapCopyWith<$R, GridLocation, GameBoard,
      GameBoardCopyWith<$R, GameBoard, GameBoard>> get boards;
  $R call(
      {Map<GridLocation, TableCell>? cells,
      Map<GridLocation, GameBoard>? boards});
  GameTableCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameTableCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameTable, $Out>
    implements GameTableCopyWith<$R, GameTable, $Out> {
  _GameTableCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameTable> $mapper =
      GameTableMapper.ensureInitialized();
  @override
  MapCopyWith<$R, GridLocation, TableCell,
          TableCellCopyWith<$R, TableCell, TableCell>>
      get cells => MapCopyWith(
          $value.cells, (v, t) => v.copyWith.$chain(t), (v) => call(cells: v));
  @override
  MapCopyWith<$R, GridLocation, GameBoard,
          GameBoardCopyWith<$R, GameBoard, GameBoard>>
      get boards => MapCopyWith($value.boards, (v, t) => v.copyWith.$chain(t),
          (v) => call(boards: v));
  @override
  $R call(
          {Map<GridLocation, TableCell>? cells,
          Map<GridLocation, GameBoard>? boards}) =>
      $apply(FieldCopyWithData({
        if (cells != null) #cells: cells,
        if (boards != null) #boards: boards
      }));
  @override
  GameTable $make(CopyWithData data) => GameTable(
      cells: data.get(#cells, or: $value.cells),
      boards: data.get(#boards, or: $value.boards));

  @override
  GameTableCopyWith<$R2, GameTable, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameTableCopyWithImpl($value, $cast, t);
}

class TableCellMapper extends ClassMapperBase<TableCell> {
  TableCellMapper._();

  static TableCellMapper? _instance;
  static TableCellMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableCellMapper._());
      GameObjectMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TableCell';

  static List<GameObject> _$objects(TableCell v) => v.objects;
  static const Field<TableCell, List<GameObject>> _f$objects =
      Field('objects', _$objects);

  @override
  final MappableFields<TableCell> fields = const {
    #objects: _f$objects,
  };

  static TableCell _instantiate(DecodingData data) {
    return TableCell(data.dec(_f$objects));
  }

  @override
  final Function instantiate = _instantiate;

  static TableCell fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableCell>(map);
  }

  static TableCell fromJson(String json) {
    return ensureInitialized().decodeJson<TableCell>(json);
  }
}

mixin TableCellMappable {
  String toJson() {
    return TableCellMapper.ensureInitialized()
        .encodeJson<TableCell>(this as TableCell);
  }

  Map<String, dynamic> toMap() {
    return TableCellMapper.ensureInitialized()
        .encodeMap<TableCell>(this as TableCell);
  }

  TableCellCopyWith<TableCell, TableCell, TableCell> get copyWith =>
      _TableCellCopyWithImpl(this as TableCell, $identity, $identity);
  @override
  String toString() {
    return TableCellMapper.ensureInitialized()
        .stringifyValue(this as TableCell);
  }

  @override
  bool operator ==(Object other) {
    return TableCellMapper.ensureInitialized()
        .equalsValue(this as TableCell, other);
  }

  @override
  int get hashCode {
    return TableCellMapper.ensureInitialized().hashValue(this as TableCell);
  }
}

extension TableCellValueCopy<$R, $Out> on ObjectCopyWith<$R, TableCell, $Out> {
  TableCellCopyWith<$R, TableCell, $Out> get $asTableCell =>
      $base.as((v, t, t2) => _TableCellCopyWithImpl(v, t, t2));
}

abstract class TableCellCopyWith<$R, $In extends TableCell, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
      get objects;
  $R call({List<GameObject>? objects});
  TableCellCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TableCellCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableCell, $Out>
    implements TableCellCopyWith<$R, TableCell, $Out> {
  _TableCellCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableCell> $mapper =
      TableCellMapper.ensureInitialized();
  @override
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
      get objects => ListCopyWith($value.objects,
          (v, t) => v.copyWith.$chain(t), (v) => call(objects: v));
  @override
  $R call({List<GameObject>? objects}) =>
      $apply(FieldCopyWithData({if (objects != null) #objects: objects}));
  @override
  TableCell $make(CopyWithData data) =>
      TableCell(data.get(#objects, or: $value.objects));

  @override
  TableCellCopyWith<$R2, TableCell, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableCellCopyWithImpl($value, $cast, t);
}

class GameObjectMapper extends ClassMapperBase<GameObject> {
  GameObjectMapper._();

  static GameObjectMapper? _instance;
  static GameObjectMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameObjectMapper._());
      AssetLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameObject';

  static AssetLocation _$asset(GameObject v) => v.asset;
  static const Field<GameObject, AssetLocation> _f$asset =
      Field('asset', _$asset);
  static String? _$variation(GameObject v) => v.variation;
  static const Field<GameObject, String> _f$variation =
      Field('variation', _$variation, opt: true);

  @override
  final MappableFields<GameObject> fields = const {
    #asset: _f$asset,
    #variation: _f$variation,
  };

  static GameObject _instantiate(DecodingData data) {
    return GameObject(
        asset: data.dec(_f$asset), variation: data.dec(_f$variation));
  }

  @override
  final Function instantiate = _instantiate;

  static GameObject fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameObject>(map);
  }

  static GameObject fromJson(String json) {
    return ensureInitialized().decodeJson<GameObject>(json);
  }
}

mixin GameObjectMappable {
  String toJson() {
    return GameObjectMapper.ensureInitialized()
        .encodeJson<GameObject>(this as GameObject);
  }

  Map<String, dynamic> toMap() {
    return GameObjectMapper.ensureInitialized()
        .encodeMap<GameObject>(this as GameObject);
  }

  GameObjectCopyWith<GameObject, GameObject, GameObject> get copyWith =>
      _GameObjectCopyWithImpl(this as GameObject, $identity, $identity);
  @override
  String toString() {
    return GameObjectMapper.ensureInitialized()
        .stringifyValue(this as GameObject);
  }

  @override
  bool operator ==(Object other) {
    return GameObjectMapper.ensureInitialized()
        .equalsValue(this as GameObject, other);
  }

  @override
  int get hashCode {
    return GameObjectMapper.ensureInitialized().hashValue(this as GameObject);
  }
}

extension GameObjectValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameObject, $Out> {
  GameObjectCopyWith<$R, GameObject, $Out> get $asGameObject =>
      $base.as((v, t, t2) => _GameObjectCopyWithImpl(v, t, t2));
}

abstract class GameObjectCopyWith<$R, $In extends GameObject, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  AssetLocationCopyWith<$R, AssetLocation, AssetLocation> get asset;
  $R call({AssetLocation? asset, String? variation});
  GameObjectCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameObjectCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameObject, $Out>
    implements GameObjectCopyWith<$R, GameObject, $Out> {
  _GameObjectCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameObject> $mapper =
      GameObjectMapper.ensureInitialized();
  @override
  AssetLocationCopyWith<$R, AssetLocation, AssetLocation> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  $R call({AssetLocation? asset, Object? variation = $none}) =>
      $apply(FieldCopyWithData({
        if (asset != null) #asset: asset,
        if (variation != $none) #variation: variation
      }));
  @override
  GameObject $make(CopyWithData data) => GameObject(
      asset: data.get(#asset, or: $value.asset),
      variation: data.get(#variation, or: $value.variation));

  @override
  GameObjectCopyWith<$R2, GameObject, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameObjectCopyWithImpl($value, $cast, t);
}

class AssetLocationMapper extends ClassMapperBase<AssetLocation> {
  AssetLocationMapper._();

  static AssetLocationMapper? _instance;
  static AssetLocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetLocationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AssetLocation';

  static String _$namespace(AssetLocation v) => v.namespace;
  static const Field<AssetLocation, String> _f$namespace =
      Field('namespace', _$namespace);
  static String _$id(AssetLocation v) => v.id;
  static const Field<AssetLocation, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<AssetLocation> fields = const {
    #namespace: _f$namespace,
    #id: _f$id,
  };

  static AssetLocation _instantiate(DecodingData data) {
    return AssetLocation(data.dec(_f$namespace), data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static AssetLocation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssetLocation>(map);
  }

  static AssetLocation fromJson(String json) {
    return ensureInitialized().decodeJson<AssetLocation>(json);
  }
}

mixin AssetLocationMappable {
  String toJson() {
    return AssetLocationMapper.ensureInitialized()
        .encodeJson<AssetLocation>(this as AssetLocation);
  }

  Map<String, dynamic> toMap() {
    return AssetLocationMapper.ensureInitialized()
        .encodeMap<AssetLocation>(this as AssetLocation);
  }

  AssetLocationCopyWith<AssetLocation, AssetLocation, AssetLocation>
      get copyWith => _AssetLocationCopyWithImpl(
          this as AssetLocation, $identity, $identity);
  @override
  String toString() {
    return AssetLocationMapper.ensureInitialized()
        .stringifyValue(this as AssetLocation);
  }

  @override
  bool operator ==(Object other) {
    return AssetLocationMapper.ensureInitialized()
        .equalsValue(this as AssetLocation, other);
  }

  @override
  int get hashCode {
    return AssetLocationMapper.ensureInitialized()
        .hashValue(this as AssetLocation);
  }
}

extension AssetLocationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssetLocation, $Out> {
  AssetLocationCopyWith<$R, AssetLocation, $Out> get $asAssetLocation =>
      $base.as((v, t, t2) => _AssetLocationCopyWithImpl(v, t, t2));
}

abstract class AssetLocationCopyWith<$R, $In extends AssetLocation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? namespace, String? id});
  AssetLocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AssetLocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssetLocation, $Out>
    implements AssetLocationCopyWith<$R, AssetLocation, $Out> {
  _AssetLocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssetLocation> $mapper =
      AssetLocationMapper.ensureInitialized();
  @override
  $R call({String? namespace, String? id}) => $apply(FieldCopyWithData(
      {if (namespace != null) #namespace: namespace, if (id != null) #id: id}));
  @override
  AssetLocation $make(CopyWithData data) => AssetLocation(
      data.get(#namespace, or: $value.namespace), data.get(#id, or: $value.id));

  @override
  AssetLocationCopyWith<$R2, AssetLocation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AssetLocationCopyWithImpl($value, $cast, t);
}

class GameBoardMapper extends ClassMapperBase<GameBoard> {
  GameBoardMapper._();

  static GameBoardMapper? _instance;
  static GameBoardMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameBoardMapper._());
      AssetLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameBoard';

  static AssetLocation _$asset(GameBoard v) => v.asset;
  static const Field<GameBoard, AssetLocation> _f$asset =
      Field('asset', _$asset);

  @override
  final MappableFields<GameBoard> fields = const {
    #asset: _f$asset,
  };

  static GameBoard _instantiate(DecodingData data) {
    return GameBoard(data.dec(_f$asset));
  }

  @override
  final Function instantiate = _instantiate;

  static GameBoard fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameBoard>(map);
  }

  static GameBoard fromJson(String json) {
    return ensureInitialized().decodeJson<GameBoard>(json);
  }
}

mixin GameBoardMappable {
  String toJson() {
    return GameBoardMapper.ensureInitialized()
        .encodeJson<GameBoard>(this as GameBoard);
  }

  Map<String, dynamic> toMap() {
    return GameBoardMapper.ensureInitialized()
        .encodeMap<GameBoard>(this as GameBoard);
  }

  GameBoardCopyWith<GameBoard, GameBoard, GameBoard> get copyWith =>
      _GameBoardCopyWithImpl(this as GameBoard, $identity, $identity);
  @override
  String toString() {
    return GameBoardMapper.ensureInitialized()
        .stringifyValue(this as GameBoard);
  }

  @override
  bool operator ==(Object other) {
    return GameBoardMapper.ensureInitialized()
        .equalsValue(this as GameBoard, other);
  }

  @override
  int get hashCode {
    return GameBoardMapper.ensureInitialized().hashValue(this as GameBoard);
  }
}

extension GameBoardValueCopy<$R, $Out> on ObjectCopyWith<$R, GameBoard, $Out> {
  GameBoardCopyWith<$R, GameBoard, $Out> get $asGameBoard =>
      $base.as((v, t, t2) => _GameBoardCopyWithImpl(v, t, t2));
}

abstract class GameBoardCopyWith<$R, $In extends GameBoard, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  AssetLocationCopyWith<$R, AssetLocation, AssetLocation> get asset;
  $R call({AssetLocation? asset});
  GameBoardCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameBoardCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameBoard, $Out>
    implements GameBoardCopyWith<$R, GameBoard, $Out> {
  _GameBoardCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameBoard> $mapper =
      GameBoardMapper.ensureInitialized();
  @override
  AssetLocationCopyWith<$R, AssetLocation, AssetLocation> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  $R call({AssetLocation? asset}) =>
      $apply(FieldCopyWithData({if (asset != null) #asset: asset}));
  @override
  GameBoard $make(CopyWithData data) =>
      GameBoard(data.get(#asset, or: $value.asset));

  @override
  GameBoardCopyWith<$R2, GameBoard, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameBoardCopyWithImpl($value, $cast, t);
}
