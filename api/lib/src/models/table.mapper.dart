// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'table.dart';

/// @nodoc
class GameTableMapper extends ClassMapperBase<GameTable> {
  GameTableMapper._();

  static GameTableMapper? _instance;
  static GameTableMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameTableMapper._());
      IgnoreEqualityBoxMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
      TableCellMapper.ensureInitialized();
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameTable';

  static IgnoreEqualityBox<Map<VectorDefinition, TableCell>> _$cellsBox(
    GameTable v,
  ) => v.cellsBox;
  static const Field<
    GameTable,
    IgnoreEqualityBox<Map<VectorDefinition, TableCell>>
  >
  _f$cellsBox = Field(
    'cellsBox',
    _$cellsBox,
    key: r'cells',
    opt: true,
    def: const IgnoreEqualityBox({}),
  );
  static ItemLocation? _$background(GameTable v) => v.background;
  static const Field<GameTable, ItemLocation> _f$background = Field(
    'background',
    _$background,
    opt: true,
  );
  static VectorDefinition? _$minCell(GameTable v) => v.minCell;
  static const Field<GameTable, VectorDefinition> _f$minCell = Field(
    'minCell',
    _$minCell,
    opt: true,
  );
  static VectorDefinition? _$maxCell(GameTable v) => v.maxCell;
  static const Field<GameTable, VectorDefinition> _f$maxCell = Field(
    'maxCell',
    _$maxCell,
    opt: true,
  );

  @override
  final MappableFields<GameTable> fields = const {
    #cellsBox: _f$cellsBox,
    #background: _f$background,
    #minCell: _f$minCell,
    #maxCell: _f$maxCell,
  };

  static GameTable _instantiate(DecodingData data) {
    return GameTable(
      cellsBox: data.dec(_f$cellsBox),
      background: data.dec(_f$background),
      minCell: data.dec(_f$minCell),
      maxCell: data.dec(_f$maxCell),
    );
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

/// @nodoc
mixin GameTableMappable {
  String toJson() {
    return GameTableMapper.ensureInitialized().encodeJson<GameTable>(
      this as GameTable,
    );
  }

  Map<String, dynamic> toMap() {
    return GameTableMapper.ensureInitialized().encodeMap<GameTable>(
      this as GameTable,
    );
  }

  GameTableCopyWith<GameTable, GameTable, GameTable> get copyWith =>
      _GameTableCopyWithImpl<GameTable, GameTable>(
        this as GameTable,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GameTableMapper.ensureInitialized().stringifyValue(
      this as GameTable,
    );
  }

  @override
  bool operator ==(Object other) {
    return GameTableMapper.ensureInitialized().equalsValue(
      this as GameTable,
      other,
    );
  }

  @override
  int get hashCode {
    return GameTableMapper.ensureInitialized().hashValue(this as GameTable);
  }
}

/// @nodoc
extension GameTableValueCopy<$R, $Out> on ObjectCopyWith<$R, GameTable, $Out> {
  GameTableCopyWith<$R, GameTable, $Out> get $asGameTable =>
      $base.as((v, t, t2) => _GameTableCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class GameTableCopyWith<$R, $In extends GameTable, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  IgnoreEqualityBoxCopyWith<
    $R,
    IgnoreEqualityBox<Map<VectorDefinition, TableCell>>,
    IgnoreEqualityBox<Map<VectorDefinition, TableCell>>,
    Map<VectorDefinition, TableCell>
  >
  get cellsBox;
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get background;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get minCell;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get maxCell;
  $R call({
    IgnoreEqualityBox<Map<VectorDefinition, TableCell>>? cellsBox,
    ItemLocation? background,
    VectorDefinition? minCell,
    VectorDefinition? maxCell,
  });
  GameTableCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _GameTableCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameTable, $Out>
    implements GameTableCopyWith<$R, GameTable, $Out> {
  _GameTableCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameTable> $mapper =
      GameTableMapper.ensureInitialized();
  @override
  IgnoreEqualityBoxCopyWith<
    $R,
    IgnoreEqualityBox<Map<VectorDefinition, TableCell>>,
    IgnoreEqualityBox<Map<VectorDefinition, TableCell>>,
    Map<VectorDefinition, TableCell>
  >
  get cellsBox => $value.cellsBox.copyWith.$chain((v) => call(cellsBox: v));
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get background =>
      $value.background?.copyWith.$chain((v) => call(background: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>?
  get minCell => $value.minCell?.copyWith.$chain((v) => call(minCell: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>?
  get maxCell => $value.maxCell?.copyWith.$chain((v) => call(maxCell: v));
  @override
  $R call({
    IgnoreEqualityBox<Map<VectorDefinition, TableCell>>? cellsBox,
    Object? background = $none,
    Object? minCell = $none,
    Object? maxCell = $none,
  }) => $apply(
    FieldCopyWithData({
      if (cellsBox != null) #cellsBox: cellsBox,
      if (background != $none) #background: background,
      if (minCell != $none) #minCell: minCell,
      if (maxCell != $none) #maxCell: maxCell,
    }),
  );
  @override
  GameTable $make(CopyWithData data) => GameTable(
    cellsBox: data.get(#cellsBox, or: $value.cellsBox),
    background: data.get(#background, or: $value.background),
    minCell: data.get(#minCell, or: $value.minCell),
    maxCell: data.get(#maxCell, or: $value.maxCell),
  );

  @override
  GameTableCopyWith<$R2, GameTable, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GameTableCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

