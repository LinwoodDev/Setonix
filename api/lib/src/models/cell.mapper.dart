// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cell.dart';

/// @nodoc

class CellMergeDirectionMapper extends EnumMapper<CellMergeDirection> {
  CellMergeDirectionMapper._();

  static CellMergeDirectionMapper? _instance;
  static CellMergeDirectionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellMergeDirectionMapper._());
    }
    return _instance!;
  }

  static CellMergeDirection fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CellMergeDirection decode(dynamic value) {
    switch (value) {
      case r'horizontal':
        return CellMergeDirection.horizontal;
      case r'vertical':
        return CellMergeDirection.vertical;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CellMergeDirection self) {
    switch (self) {
      case CellMergeDirection.horizontal:
        return r'horizontal';
      case CellMergeDirection.vertical:
        return r'vertical';
    }
  }
}

/// @nodoc

extension CellMergeDirectionMapperExtension on CellMergeDirection {
  String toValue() {
    CellMergeDirectionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CellMergeDirection>(this) as String;
  }
}

/// @nodoc
class TableCellMapper extends ClassMapperBase<TableCell> {
  TableCellMapper._();

  static TableCellMapper? _instance;
  static TableCellMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableCellMapper._());
      GameObjectMapper.ensureInitialized();
      BoardTileMapper.ensureInitialized();
      CellMergeStrategyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TableCell';

  static List<GameObject> _$objects(TableCell v) => v.objects;
  static const Field<TableCell, List<GameObject>> _f$objects = Field(
    'objects',
    _$objects,
    opt: true,
    def: const [],
  );
  static List<BoardTile> _$tiles(TableCell v) => v.tiles;
  static const Field<TableCell, List<BoardTile>> _f$tiles = Field(
    'tiles',
    _$tiles,
    opt: true,
    def: const [],
  );
  static CellMergeStrategy? _$merge(TableCell v) => v.merge;
  static const Field<TableCell, CellMergeStrategy> _f$merge = Field(
    'merge',
    _$merge,
    opt: true,
  );

  @override
  final MappableFields<TableCell> fields = const {
    #objects: _f$objects,
    #tiles: _f$tiles,
    #merge: _f$merge,
  };

  static TableCell _instantiate(DecodingData data) {
    return TableCell(
      objects: data.dec(_f$objects),
      tiles: data.dec(_f$tiles),
      merge: data.dec(_f$merge),
    );
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

/// @nodoc
mixin TableCellMappable {
  String toJson() {
    return TableCellMapper.ensureInitialized().encodeJson<TableCell>(
      this as TableCell,
    );
  }

  Map<String, dynamic> toMap() {
    return TableCellMapper.ensureInitialized().encodeMap<TableCell>(
      this as TableCell,
    );
  }

  TableCellCopyWith<TableCell, TableCell, TableCell> get copyWith =>
      _TableCellCopyWithImpl<TableCell, TableCell>(
        this as TableCell,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TableCellMapper.ensureInitialized().stringifyValue(
      this as TableCell,
    );
  }

  @override
  bool operator ==(Object other) {
    return TableCellMapper.ensureInitialized().equalsValue(
      this as TableCell,
      other,
    );
  }

  @override
  int get hashCode {
    return TableCellMapper.ensureInitialized().hashValue(this as TableCell);
  }
}

/// @nodoc
extension TableCellValueCopy<$R, $Out> on ObjectCopyWith<$R, TableCell, $Out> {
  TableCellCopyWith<$R, TableCell, $Out> get $asTableCell =>
      $base.as((v, t, t2) => _TableCellCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class TableCellCopyWith<$R, $In extends TableCell, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
  get objects;
  ListCopyWith<$R, BoardTile, BoardTileCopyWith<$R, BoardTile, BoardTile>>
  get tiles;
  CellMergeStrategyCopyWith<$R, CellMergeStrategy, CellMergeStrategy>?
  get merge;
  $R call({
    List<GameObject>? objects,
    List<BoardTile>? tiles,
    CellMergeStrategy? merge,
  });
  TableCellCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _TableCellCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableCell, $Out>
    implements TableCellCopyWith<$R, TableCell, $Out> {
  _TableCellCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableCell> $mapper =
      TableCellMapper.ensureInitialized();
  @override
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
  get objects => ListCopyWith(
    $value.objects,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(objects: v),
  );
  @override
  ListCopyWith<$R, BoardTile, BoardTileCopyWith<$R, BoardTile, BoardTile>>
  get tiles => ListCopyWith(
    $value.tiles,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(tiles: v),
  );
  @override
  CellMergeStrategyCopyWith<$R, CellMergeStrategy, CellMergeStrategy>?
  get merge => $value.merge?.copyWith.$chain((v) => call(merge: v));
  @override
  $R call({
    List<GameObject>? objects,
    List<BoardTile>? tiles,
    Object? merge = $none,
  }) => $apply(
    FieldCopyWithData({
      if (objects != null) #objects: objects,
      if (tiles != null) #tiles: tiles,
      if (merge != $none) #merge: merge,
    }),
  );
  @override
  TableCell $make(CopyWithData data) => TableCell(
    objects: data.get(#objects, or: $value.objects),
    tiles: data.get(#tiles, or: $value.tiles),
    merge: data.get(#merge, or: $value.merge),
  );

  @override
  TableCellCopyWith<$R2, TableCell, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TableCellCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class GameObjectMapper extends ClassMapperBase<GameObject> {
  GameObjectMapper._();

  static GameObjectMapper? _instance;
  static GameObjectMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameObjectMapper._());
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameObject';

  static ItemLocation _$asset(GameObject v) => v.asset;
  static const Field<GameObject, ItemLocation> _f$asset = Field(
    'asset',
    _$asset,
  );
  static String? _$variation(GameObject v) => v.variation;
  static const Field<GameObject, String> _f$variation = Field(
    'variation',
    _$variation,
    opt: true,
  );
  static bool _$hidden(GameObject v) => v.hidden;
  static const Field<GameObject, bool> _f$hidden = Field(
    'hidden',
    _$hidden,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<GameObject> fields = const {
    #asset: _f$asset,
    #variation: _f$variation,
    #hidden: _f$hidden,
  };

  static GameObject _instantiate(DecodingData data) {
    return GameObject(
      data.dec(_f$asset),
      variation: data.dec(_f$variation),
      hidden: data.dec(_f$hidden),
    );
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

/// @nodoc
mixin GameObjectMappable {
  String toJson() {
    return GameObjectMapper.ensureInitialized().encodeJson<GameObject>(
      this as GameObject,
    );
  }

  Map<String, dynamic> toMap() {
    return GameObjectMapper.ensureInitialized().encodeMap<GameObject>(
      this as GameObject,
    );
  }

  GameObjectCopyWith<GameObject, GameObject, GameObject> get copyWith =>
      _GameObjectCopyWithImpl<GameObject, GameObject>(
        this as GameObject,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GameObjectMapper.ensureInitialized().stringifyValue(
      this as GameObject,
    );
  }

  @override
  bool operator ==(Object other) {
    return GameObjectMapper.ensureInitialized().equalsValue(
      this as GameObject,
      other,
    );
  }

  @override
  int get hashCode {
    return GameObjectMapper.ensureInitialized().hashValue(this as GameObject);
  }
}

/// @nodoc
extension GameObjectValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameObject, $Out> {
  GameObjectCopyWith<$R, GameObject, $Out> get $asGameObject =>
      $base.as((v, t, t2) => _GameObjectCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class GameObjectCopyWith<$R, $In extends GameObject, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get asset;
  $R call({ItemLocation? asset, String? variation, bool? hidden});
  GameObjectCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _GameObjectCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameObject, $Out>
    implements GameObjectCopyWith<$R, GameObject, $Out> {
  _GameObjectCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameObject> $mapper =
      GameObjectMapper.ensureInitialized();
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  $R call({ItemLocation? asset, Object? variation = $none, bool? hidden}) =>
      $apply(
        FieldCopyWithData({
          if (asset != null) #asset: asset,
          if (variation != $none) #variation: variation,
          if (hidden != null) #hidden: hidden,
        }),
      );
  @override
  GameObject $make(CopyWithData data) => GameObject(
    data.get(#asset, or: $value.asset),
    variation: data.get(#variation, or: $value.variation),
    hidden: data.get(#hidden, or: $value.hidden),
  );

  @override
  GameObjectCopyWith<$R2, GameObject, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GameObjectCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class BoardTileMapper extends ClassMapperBase<BoardTile> {
  BoardTileMapper._();

  static BoardTileMapper? _instance;
  static BoardTileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardTileMapper._());
      ItemLocationMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardTile';

  static ItemLocation _$asset(BoardTile v) => v.asset;
  static const Field<BoardTile, ItemLocation> _f$asset = Field(
    'asset',
    _$asset,
  );
  static VectorDefinition _$tile(BoardTile v) => v.tile;
  static const Field<BoardTile, VectorDefinition> _f$tile = Field(
    'tile',
    _$tile,
  );

  @override
  final MappableFields<BoardTile> fields = const {
    #asset: _f$asset,
    #tile: _f$tile,
  };

  static BoardTile _instantiate(DecodingData data) {
    return BoardTile(data.dec(_f$asset), data.dec(_f$tile));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardTile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardTile>(map);
  }

  static BoardTile fromJson(String json) {
    return ensureInitialized().decodeJson<BoardTile>(json);
  }
}

/// @nodoc
mixin BoardTileMappable {
  String toJson() {
    return BoardTileMapper.ensureInitialized().encodeJson<BoardTile>(
      this as BoardTile,
    );
  }

  Map<String, dynamic> toMap() {
    return BoardTileMapper.ensureInitialized().encodeMap<BoardTile>(
      this as BoardTile,
    );
  }

  BoardTileCopyWith<BoardTile, BoardTile, BoardTile> get copyWith =>
      _BoardTileCopyWithImpl<BoardTile, BoardTile>(
        this as BoardTile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BoardTileMapper.ensureInitialized().stringifyValue(
      this as BoardTile,
    );
  }

  @override
  bool operator ==(Object other) {
    return BoardTileMapper.ensureInitialized().equalsValue(
      this as BoardTile,
      other,
    );
  }

  @override
  int get hashCode {
    return BoardTileMapper.ensureInitialized().hashValue(this as BoardTile);
  }
}

/// @nodoc
extension BoardTileValueCopy<$R, $Out> on ObjectCopyWith<$R, BoardTile, $Out> {
  BoardTileCopyWith<$R, BoardTile, $Out> get $asBoardTile =>
      $base.as((v, t, t2) => _BoardTileCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class BoardTileCopyWith<$R, $In extends BoardTile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get asset;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get tile;
  $R call({ItemLocation? asset, VectorDefinition? tile});
  BoardTileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _BoardTileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardTile, $Out>
    implements BoardTileCopyWith<$R, BoardTile, $Out> {
  _BoardTileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardTile> $mapper =
      BoardTileMapper.ensureInitialized();
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get tile =>
      $value.tile.copyWith.$chain((v) => call(tile: v));
  @override
  $R call({ItemLocation? asset, VectorDefinition? tile}) => $apply(
    FieldCopyWithData({
      if (asset != null) #asset: asset,
      if (tile != null) #tile: tile,
    }),
  );
  @override
  BoardTile $make(CopyWithData data) => BoardTile(
    data.get(#asset, or: $value.asset),
    data.get(#tile, or: $value.tile),
  );

  @override
  BoardTileCopyWith<$R2, BoardTile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BoardTileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class CellMergeStrategyMapper extends ClassMapperBase<CellMergeStrategy> {
  CellMergeStrategyMapper._();

  static CellMergeStrategyMapper? _instance;
  static CellMergeStrategyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellMergeStrategyMapper._());
      MergedCellStrategyMapper.ensureInitialized();
      LayoutCellMergeStrategyMapper.ensureInitialized();
      CellMergeDirectionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellMergeStrategy';

  static CellMergeDirection _$direction(CellMergeStrategy v) => v.direction;
  static const Field<CellMergeStrategy, CellMergeDirection> _f$direction =
      Field(
        'direction',
        _$direction,
        opt: true,
        def: CellMergeDirection.vertical,
      );

  @override
  final MappableFields<CellMergeStrategy> fields = const {
    #direction: _f$direction,
  };

  static CellMergeStrategy _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('CellMergeStrategy');
  }

  @override
  final Function instantiate = _instantiate;

  static CellMergeStrategy fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellMergeStrategy>(map);
  }

  static CellMergeStrategy fromJson(String json) {
    return ensureInitialized().decodeJson<CellMergeStrategy>(json);
  }
}

/// @nodoc
mixin CellMergeStrategyMappable {
  String toJson();
  Map<String, dynamic> toMap();
  CellMergeStrategyCopyWith<
    CellMergeStrategy,
    CellMergeStrategy,
    CellMergeStrategy
  >
  get copyWith;
}

/// @nodoc
abstract class CellMergeStrategyCopyWith<
  $R,
  $In extends CellMergeStrategy,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({CellMergeDirection? direction});
  CellMergeStrategyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class MergedCellStrategyMapper extends ClassMapperBase<MergedCellStrategy> {
  MergedCellStrategyMapper._();

  static MergedCellStrategyMapper? _instance;
  static MergedCellStrategyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MergedCellStrategyMapper._());
      CellMergeStrategyMapper.ensureInitialized();
      CellMergeDirectionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MergedCellStrategy';

  static CellMergeDirection _$direction(MergedCellStrategy v) => v.direction;
  static const Field<MergedCellStrategy, CellMergeDirection> _f$direction =
      Field('direction', _$direction);

  @override
  final MappableFields<MergedCellStrategy> fields = const {
    #direction: _f$direction,
  };

  static MergedCellStrategy _instantiate(DecodingData data) {
    return MergedCellStrategy(data.dec(_f$direction));
  }

  @override
  final Function instantiate = _instantiate;

  static MergedCellStrategy fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MergedCellStrategy>(map);
  }

  static MergedCellStrategy fromJson(String json) {
    return ensureInitialized().decodeJson<MergedCellStrategy>(json);
  }
}

/// @nodoc
mixin MergedCellStrategyMappable {
  String toJson() {
    return MergedCellStrategyMapper.ensureInitialized()
        .encodeJson<MergedCellStrategy>(this as MergedCellStrategy);
  }

  Map<String, dynamic> toMap() {
    return MergedCellStrategyMapper.ensureInitialized()
        .encodeMap<MergedCellStrategy>(this as MergedCellStrategy);
  }

  MergedCellStrategyCopyWith<
    MergedCellStrategy,
    MergedCellStrategy,
    MergedCellStrategy
  >
  get copyWith =>
      _MergedCellStrategyCopyWithImpl<MergedCellStrategy, MergedCellStrategy>(
        this as MergedCellStrategy,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MergedCellStrategyMapper.ensureInitialized().stringifyValue(
      this as MergedCellStrategy,
    );
  }

  @override
  bool operator ==(Object other) {
    return MergedCellStrategyMapper.ensureInitialized().equalsValue(
      this as MergedCellStrategy,
      other,
    );
  }

  @override
  int get hashCode {
    return MergedCellStrategyMapper.ensureInitialized().hashValue(
      this as MergedCellStrategy,
    );
  }
}

/// @nodoc
extension MergedCellStrategyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MergedCellStrategy, $Out> {
  MergedCellStrategyCopyWith<$R, MergedCellStrategy, $Out>
  get $asMergedCellStrategy => $base.as(
    (v, t, t2) => _MergedCellStrategyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class MergedCellStrategyCopyWith<
  $R,
  $In extends MergedCellStrategy,
  $Out
>
    implements CellMergeStrategyCopyWith<$R, $In, $Out> {
  @override
  $R call({CellMergeDirection? direction});
  MergedCellStrategyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _MergedCellStrategyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MergedCellStrategy, $Out>
    implements MergedCellStrategyCopyWith<$R, MergedCellStrategy, $Out> {
  _MergedCellStrategyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MergedCellStrategy> $mapper =
      MergedCellStrategyMapper.ensureInitialized();
  @override
  $R call({CellMergeDirection? direction}) =>
      $apply(FieldCopyWithData({if (direction != null) #direction: direction}));
  @override
  MergedCellStrategy $make(CopyWithData data) =>
      MergedCellStrategy(data.get(#direction, or: $value.direction));

  @override
  MergedCellStrategyCopyWith<$R2, MergedCellStrategy, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MergedCellStrategyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class LayoutCellMergeStrategyMapper
    extends ClassMapperBase<LayoutCellMergeStrategy> {
  LayoutCellMergeStrategyMapper._();

  static LayoutCellMergeStrategyMapper? _instance;
  static LayoutCellMergeStrategyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LayoutCellMergeStrategyMapper._(),
      );
      CellMergeStrategyMapper.ensureInitialized();
      StackedCellMergeStrategyMapper.ensureInitialized();
      DistributeCellMergeStrategyMapper.ensureInitialized();
      CellMergeDirectionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LayoutCellMergeStrategy';

  static CellMergeDirection _$direction(LayoutCellMergeStrategy v) =>
      v.direction;
  static const Field<LayoutCellMergeStrategy, CellMergeDirection> _f$direction =
      Field(
        'direction',
        _$direction,
        opt: true,
        def: CellMergeDirection.vertical,
      );
  static bool _$reverse(LayoutCellMergeStrategy v) => v.reverse;
  static const Field<LayoutCellMergeStrategy, bool> _f$reverse = Field(
    'reverse',
    _$reverse,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<LayoutCellMergeStrategy> fields = const {
    #direction: _f$direction,
    #reverse: _f$reverse,
  };

  static LayoutCellMergeStrategy _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('LayoutCellMergeStrategy');
  }

  @override
  final Function instantiate = _instantiate;

  static LayoutCellMergeStrategy fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LayoutCellMergeStrategy>(map);
  }

  static LayoutCellMergeStrategy fromJson(String json) {
    return ensureInitialized().decodeJson<LayoutCellMergeStrategy>(json);
  }
}

/// @nodoc
mixin LayoutCellMergeStrategyMappable {
  String toJson();
  Map<String, dynamic> toMap();
  LayoutCellMergeStrategyCopyWith<
    LayoutCellMergeStrategy,
    LayoutCellMergeStrategy,
    LayoutCellMergeStrategy
  >
  get copyWith;
}

/// @nodoc
abstract class LayoutCellMergeStrategyCopyWith<
  $R,
  $In extends LayoutCellMergeStrategy,
  $Out
>
    implements CellMergeStrategyCopyWith<$R, $In, $Out> {
  @override
  $R call({CellMergeDirection? direction, bool? reverse});
  LayoutCellMergeStrategyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class StackedCellMergeStrategyMapper
    extends ClassMapperBase<StackedCellMergeStrategy> {
  StackedCellMergeStrategyMapper._();

  static StackedCellMergeStrategyMapper? _instance;
  static StackedCellMergeStrategyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = StackedCellMergeStrategyMapper._(),
      );
      LayoutCellMergeStrategyMapper.ensureInitialized();
      CellMergeDirectionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StackedCellMergeStrategy';

  static int _$visiblePercentage(StackedCellMergeStrategy v) =>
      v.visiblePercentage;
  static const Field<StackedCellMergeStrategy, int> _f$visiblePercentage =
      Field('visiblePercentage', _$visiblePercentage, opt: true, def: 10);
  static bool _$reverse(StackedCellMergeStrategy v) => v.reverse;
  static const Field<StackedCellMergeStrategy, bool> _f$reverse = Field(
    'reverse',
    _$reverse,
    opt: true,
    def: false,
  );
  static CellMergeDirection _$direction(StackedCellMergeStrategy v) =>
      v.direction;
  static const Field<StackedCellMergeStrategy, CellMergeDirection>
  _f$direction = Field(
    'direction',
    _$direction,
    opt: true,
    def: CellMergeDirection.vertical,
  );

  @override
  final MappableFields<StackedCellMergeStrategy> fields = const {
    #visiblePercentage: _f$visiblePercentage,
    #reverse: _f$reverse,
    #direction: _f$direction,
  };

  static StackedCellMergeStrategy _instantiate(DecodingData data) {
    return StackedCellMergeStrategy(
      visiblePercentage: data.dec(_f$visiblePercentage),
      reverse: data.dec(_f$reverse),
      direction: data.dec(_f$direction),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StackedCellMergeStrategy fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StackedCellMergeStrategy>(map);
  }

  static StackedCellMergeStrategy fromJson(String json) {
    return ensureInitialized().decodeJson<StackedCellMergeStrategy>(json);
  }
}

/// @nodoc
mixin StackedCellMergeStrategyMappable {
  String toJson() {
    return StackedCellMergeStrategyMapper.ensureInitialized()
        .encodeJson<StackedCellMergeStrategy>(this as StackedCellMergeStrategy);
  }

  Map<String, dynamic> toMap() {
    return StackedCellMergeStrategyMapper.ensureInitialized()
        .encodeMap<StackedCellMergeStrategy>(this as StackedCellMergeStrategy);
  }

  StackedCellMergeStrategyCopyWith<
    StackedCellMergeStrategy,
    StackedCellMergeStrategy,
    StackedCellMergeStrategy
  >
  get copyWith =>
      _StackedCellMergeStrategyCopyWithImpl<
        StackedCellMergeStrategy,
        StackedCellMergeStrategy
      >(this as StackedCellMergeStrategy, $identity, $identity);
  @override
  String toString() {
    return StackedCellMergeStrategyMapper.ensureInitialized().stringifyValue(
      this as StackedCellMergeStrategy,
    );
  }

  @override
  bool operator ==(Object other) {
    return StackedCellMergeStrategyMapper.ensureInitialized().equalsValue(
      this as StackedCellMergeStrategy,
      other,
    );
  }

  @override
  int get hashCode {
    return StackedCellMergeStrategyMapper.ensureInitialized().hashValue(
      this as StackedCellMergeStrategy,
    );
  }
}

/// @nodoc
extension StackedCellMergeStrategyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StackedCellMergeStrategy, $Out> {
  StackedCellMergeStrategyCopyWith<$R, StackedCellMergeStrategy, $Out>
  get $asStackedCellMergeStrategy => $base.as(
    (v, t, t2) => _StackedCellMergeStrategyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class StackedCellMergeStrategyCopyWith<
  $R,
  $In extends StackedCellMergeStrategy,
  $Out
>
    implements LayoutCellMergeStrategyCopyWith<$R, $In, $Out> {
  @override
  $R call({
    int? visiblePercentage,
    bool? reverse,
    CellMergeDirection? direction,
  });
  StackedCellMergeStrategyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _StackedCellMergeStrategyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StackedCellMergeStrategy, $Out>
    implements
        StackedCellMergeStrategyCopyWith<$R, StackedCellMergeStrategy, $Out> {
  _StackedCellMergeStrategyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StackedCellMergeStrategy> $mapper =
      StackedCellMergeStrategyMapper.ensureInitialized();
  @override
  $R call({
    int? visiblePercentage,
    bool? reverse,
    CellMergeDirection? direction,
  }) => $apply(
    FieldCopyWithData({
      if (visiblePercentage != null) #visiblePercentage: visiblePercentage,
      if (reverse != null) #reverse: reverse,
      if (direction != null) #direction: direction,
    }),
  );
  @override
  StackedCellMergeStrategy $make(CopyWithData data) => StackedCellMergeStrategy(
    visiblePercentage: data.get(
      #visiblePercentage,
      or: $value.visiblePercentage,
    ),
    reverse: data.get(#reverse, or: $value.reverse),
    direction: data.get(#direction, or: $value.direction),
  );

  @override
  StackedCellMergeStrategyCopyWith<$R2, StackedCellMergeStrategy, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _StackedCellMergeStrategyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class DistributeCellMergeStrategyMapper
    extends ClassMapperBase<DistributeCellMergeStrategy> {
  DistributeCellMergeStrategyMapper._();

  static DistributeCellMergeStrategyMapper? _instance;
  static DistributeCellMergeStrategyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = DistributeCellMergeStrategyMapper._(),
      );
      LayoutCellMergeStrategyMapper.ensureInitialized();
      CellMergeDirectionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DistributeCellMergeStrategy';

  static int _$maxCards(DistributeCellMergeStrategy v) => v.maxCards;
  static const Field<DistributeCellMergeStrategy, int> _f$maxCards = Field(
    'maxCards',
    _$maxCards,
    opt: true,
    def: 5,
  );
  static bool _$fillVariableSpace(DistributeCellMergeStrategy v) =>
      v.fillVariableSpace;
  static const Field<DistributeCellMergeStrategy, bool> _f$fillVariableSpace =
      Field('fillVariableSpace', _$fillVariableSpace, opt: true, def: true);
  static bool _$reverse(DistributeCellMergeStrategy v) => v.reverse;
  static const Field<DistributeCellMergeStrategy, bool> _f$reverse = Field(
    'reverse',
    _$reverse,
    opt: true,
    def: false,
  );
  static CellMergeDirection _$direction(DistributeCellMergeStrategy v) =>
      v.direction;
  static const Field<DistributeCellMergeStrategy, CellMergeDirection>
  _f$direction = Field(
    'direction',
    _$direction,
    opt: true,
    def: CellMergeDirection.horizontal,
  );

  @override
  final MappableFields<DistributeCellMergeStrategy> fields = const {
    #maxCards: _f$maxCards,
    #fillVariableSpace: _f$fillVariableSpace,
    #reverse: _f$reverse,
    #direction: _f$direction,
  };

  static DistributeCellMergeStrategy _instantiate(DecodingData data) {
    return DistributeCellMergeStrategy(
      maxCards: data.dec(_f$maxCards),
      fillVariableSpace: data.dec(_f$fillVariableSpace),
      reverse: data.dec(_f$reverse),
      direction: data.dec(_f$direction),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DistributeCellMergeStrategy fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DistributeCellMergeStrategy>(map);
  }

  static DistributeCellMergeStrategy fromJson(String json) {
    return ensureInitialized().decodeJson<DistributeCellMergeStrategy>(json);
  }
}

/// @nodoc
mixin DistributeCellMergeStrategyMappable {
  String toJson() {
    return DistributeCellMergeStrategyMapper.ensureInitialized()
        .encodeJson<DistributeCellMergeStrategy>(
          this as DistributeCellMergeStrategy,
        );
  }

  Map<String, dynamic> toMap() {
    return DistributeCellMergeStrategyMapper.ensureInitialized()
        .encodeMap<DistributeCellMergeStrategy>(
          this as DistributeCellMergeStrategy,
        );
  }

  DistributeCellMergeStrategyCopyWith<
    DistributeCellMergeStrategy,
    DistributeCellMergeStrategy,
    DistributeCellMergeStrategy
  >
  get copyWith =>
      _DistributeCellMergeStrategyCopyWithImpl<
        DistributeCellMergeStrategy,
        DistributeCellMergeStrategy
      >(this as DistributeCellMergeStrategy, $identity, $identity);
  @override
  String toString() {
    return DistributeCellMergeStrategyMapper.ensureInitialized().stringifyValue(
      this as DistributeCellMergeStrategy,
    );
  }

  @override
  bool operator ==(Object other) {
    return DistributeCellMergeStrategyMapper.ensureInitialized().equalsValue(
      this as DistributeCellMergeStrategy,
      other,
    );
  }

  @override
  int get hashCode {
    return DistributeCellMergeStrategyMapper.ensureInitialized().hashValue(
      this as DistributeCellMergeStrategy,
    );
  }
}

/// @nodoc
extension DistributeCellMergeStrategyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DistributeCellMergeStrategy, $Out> {
  DistributeCellMergeStrategyCopyWith<$R, DistributeCellMergeStrategy, $Out>
  get $asDistributeCellMergeStrategy => $base.as(
    (v, t, t2) => _DistributeCellMergeStrategyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class DistributeCellMergeStrategyCopyWith<
  $R,
  $In extends DistributeCellMergeStrategy,
  $Out
>
    implements LayoutCellMergeStrategyCopyWith<$R, $In, $Out> {
  @override
  $R call({
    int? maxCards,
    bool? fillVariableSpace,
    bool? reverse,
    CellMergeDirection? direction,
  });
  DistributeCellMergeStrategyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _DistributeCellMergeStrategyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DistributeCellMergeStrategy, $Out>
    implements
        DistributeCellMergeStrategyCopyWith<
          $R,
          DistributeCellMergeStrategy,
          $Out
        > {
  _DistributeCellMergeStrategyCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<DistributeCellMergeStrategy> $mapper =
      DistributeCellMergeStrategyMapper.ensureInitialized();
  @override
  $R call({
    int? maxCards,
    bool? fillVariableSpace,
    bool? reverse,
    CellMergeDirection? direction,
  }) => $apply(
    FieldCopyWithData({
      if (maxCards != null) #maxCards: maxCards,
      if (fillVariableSpace != null) #fillVariableSpace: fillVariableSpace,
      if (reverse != null) #reverse: reverse,
      if (direction != null) #direction: direction,
    }),
  );
  @override
  DistributeCellMergeStrategy $make(CopyWithData data) =>
      DistributeCellMergeStrategy(
        maxCards: data.get(#maxCards, or: $value.maxCards),
        fillVariableSpace: data.get(
          #fillVariableSpace,
          or: $value.fillVariableSpace,
        ),
        reverse: data.get(#reverse, or: $value.reverse),
        direction: data.get(#direction, or: $value.direction),
      );

  @override
  DistributeCellMergeStrategyCopyWith<$R2, DistributeCellMergeStrategy, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DistributeCellMergeStrategyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

