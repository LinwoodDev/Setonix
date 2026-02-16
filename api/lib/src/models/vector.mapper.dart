// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vector.dart';

class VectorDefinitionMapper extends ClassMapperBase<VectorDefinition> {
  VectorDefinitionMapper._();

  static VectorDefinitionMapper? _instance;
  static VectorDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VectorDefinitionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VectorDefinition';

  static int _$x(VectorDefinition v) => v.x;
  static const Field<VectorDefinition, int> _f$x = Field('x', _$x);
  static int _$y(VectorDefinition v) => v.y;
  static const Field<VectorDefinition, int> _f$y = Field('y', _$y);

  @override
  final MappableFields<VectorDefinition> fields = const {#x: _f$x, #y: _f$y};

  @override
  final MappingHook hook = const VectorDefinitionHook();
  static VectorDefinition _instantiate(DecodingData data) {
    return VectorDefinition(data.dec(_f$x), data.dec(_f$y));
  }

  @override
  final Function instantiate = _instantiate;

  static VectorDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VectorDefinition>(map);
  }

  static VectorDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<VectorDefinition>(json);
  }
}

mixin VectorDefinitionMappable {
  String toJson() {
    return VectorDefinitionMapper.ensureInitialized()
        .encodeJson<VectorDefinition>(this as VectorDefinition);
  }

  Map<String, dynamic> toMap() {
    return VectorDefinitionMapper.ensureInitialized()
        .encodeMap<VectorDefinition>(this as VectorDefinition);
  }

  VectorDefinitionCopyWith<VectorDefinition, VectorDefinition, VectorDefinition>
  get copyWith =>
      _VectorDefinitionCopyWithImpl<VectorDefinition, VectorDefinition>(
        this as VectorDefinition,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return VectorDefinitionMapper.ensureInitialized().stringifyValue(
      this as VectorDefinition,
    );
  }

  @override
  bool operator ==(Object other) {
    return VectorDefinitionMapper.ensureInitialized().equalsValue(
      this as VectorDefinition,
      other,
    );
  }

  @override
  int get hashCode {
    return VectorDefinitionMapper.ensureInitialized().hashValue(
      this as VectorDefinition,
    );
  }
}

extension VectorDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VectorDefinition, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, $Out>
  get $asVectorDefinition =>
      $base.as((v, t, t2) => _VectorDefinitionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VectorDefinitionCopyWith<$R, $In extends VectorDefinition, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? x, int? y});
  VectorDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _VectorDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VectorDefinition, $Out>
    implements VectorDefinitionCopyWith<$R, VectorDefinition, $Out> {
  _VectorDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VectorDefinition> $mapper =
      VectorDefinitionMapper.ensureInitialized();
  @override
  $R call({int? x, int? y}) =>
      $apply(FieldCopyWithData({if (x != null) #x: x, if (y != null) #y: y}));
  @override
  VectorDefinition $make(CopyWithData data) =>
      VectorDefinition(data.get(#x, or: $value.x), data.get(#y, or: $value.y));

  @override
  VectorDefinitionCopyWith<$R2, VectorDefinition, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VectorDefinitionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class GlobalVectorDefinitionMapper
    extends ClassMapperBase<GlobalVectorDefinition> {
  GlobalVectorDefinitionMapper._();

  static GlobalVectorDefinitionMapper? _instance;
  static GlobalVectorDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GlobalVectorDefinitionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GlobalVectorDefinition';

  static String _$table(GlobalVectorDefinition v) => v.table;
  static const Field<GlobalVectorDefinition, String> _f$table = Field(
    'table',
    _$table,
  );
  static int _$x(GlobalVectorDefinition v) => v.x;
  static const Field<GlobalVectorDefinition, int> _f$x = Field('x', _$x);
  static int _$y(GlobalVectorDefinition v) => v.y;
  static const Field<GlobalVectorDefinition, int> _f$y = Field('y', _$y);
  static VectorDefinition _$position(GlobalVectorDefinition v) => v.position;
  static const Field<GlobalVectorDefinition, VectorDefinition> _f$position =
      Field('position', _$position, mode: FieldMode.member);

  @override
  final MappableFields<GlobalVectorDefinition> fields = const {
    #table: _f$table,
    #x: _f$x,
    #y: _f$y,
    #position: _f$position,
  };

  static GlobalVectorDefinition _instantiate(DecodingData data) {
    return GlobalVectorDefinition(
      data.dec(_f$table),
      data.dec(_f$x),
      data.dec(_f$y),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GlobalVectorDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GlobalVectorDefinition>(map);
  }

  static GlobalVectorDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<GlobalVectorDefinition>(json);
  }
}

mixin GlobalVectorDefinitionMappable {
  String toJson() {
    return GlobalVectorDefinitionMapper.ensureInitialized()
        .encodeJson<GlobalVectorDefinition>(this as GlobalVectorDefinition);
  }

  Map<String, dynamic> toMap() {
    return GlobalVectorDefinitionMapper.ensureInitialized()
        .encodeMap<GlobalVectorDefinition>(this as GlobalVectorDefinition);
  }

  GlobalVectorDefinitionCopyWith<
    GlobalVectorDefinition,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get copyWith =>
      _GlobalVectorDefinitionCopyWithImpl<
        GlobalVectorDefinition,
        GlobalVectorDefinition
      >(this as GlobalVectorDefinition, $identity, $identity);
  @override
  String toString() {
    return GlobalVectorDefinitionMapper.ensureInitialized().stringifyValue(
      this as GlobalVectorDefinition,
    );
  }

  @override
  bool operator ==(Object other) {
    return GlobalVectorDefinitionMapper.ensureInitialized().equalsValue(
      this as GlobalVectorDefinition,
      other,
    );
  }

  @override
  int get hashCode {
    return GlobalVectorDefinitionMapper.ensureInitialized().hashValue(
      this as GlobalVectorDefinition,
    );
  }
}

extension GlobalVectorDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GlobalVectorDefinition, $Out> {
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition, $Out>
  get $asGlobalVectorDefinition => $base.as(
    (v, t, t2) => _GlobalVectorDefinitionCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GlobalVectorDefinitionCopyWith<
  $R,
  $In extends GlobalVectorDefinition,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? table, int? x, int? y});
  GlobalVectorDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GlobalVectorDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GlobalVectorDefinition, $Out>
    implements
        GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition, $Out> {
  _GlobalVectorDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GlobalVectorDefinition> $mapper =
      GlobalVectorDefinitionMapper.ensureInitialized();
  @override
  $R call({String? table, int? x, int? y}) => $apply(
    FieldCopyWithData({
      if (table != null) #table: table,
      if (x != null) #x: x,
      if (y != null) #y: y,
    }),
  );
  @override
  GlobalVectorDefinition $make(CopyWithData data) => GlobalVectorDefinition(
    data.get(#table, or: $value.table),
    data.get(#x, or: $value.x),
    data.get(#y, or: $value.y),
  );

  @override
  GlobalVectorDefinitionCopyWith<$R2, GlobalVectorDefinition, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GlobalVectorDefinitionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ItemLocationMapper extends ClassMapperBase<ItemLocation> {
  ItemLocationMapper._();

  static ItemLocationMapper? _instance;
  static ItemLocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ItemLocationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ItemLocation';

  static String _$namespace(ItemLocation v) => v.namespace;
  static const Field<ItemLocation, String> _f$namespace = Field(
    'namespace',
    _$namespace,
  );
  static String _$id(ItemLocation v) => v.id;
  static const Field<ItemLocation, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<ItemLocation> fields = const {
    #namespace: _f$namespace,
    #id: _f$id,
  };

  @override
  final MappingHook hook = const ItemLocationHook();
  static ItemLocation _instantiate(DecodingData data) {
    return ItemLocation(data.dec(_f$namespace), data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static ItemLocation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ItemLocation>(map);
  }

  static ItemLocation fromJson(String json) {
    return ensureInitialized().decodeJson<ItemLocation>(json);
  }
}

mixin ItemLocationMappable {
  String toJson() {
    return ItemLocationMapper.ensureInitialized().encodeJson<ItemLocation>(
      this as ItemLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return ItemLocationMapper.ensureInitialized().encodeMap<ItemLocation>(
      this as ItemLocation,
    );
  }

  ItemLocationCopyWith<ItemLocation, ItemLocation, ItemLocation> get copyWith =>
      _ItemLocationCopyWithImpl<ItemLocation, ItemLocation>(
        this as ItemLocation,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ItemLocationMapper.ensureInitialized().stringifyValue(
      this as ItemLocation,
    );
  }

  @override
  bool operator ==(Object other) {
    return ItemLocationMapper.ensureInitialized().equalsValue(
      this as ItemLocation,
      other,
    );
  }

  @override
  int get hashCode {
    return ItemLocationMapper.ensureInitialized().hashValue(
      this as ItemLocation,
    );
  }
}

extension ItemLocationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ItemLocation, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, $Out> get $asItemLocation =>
      $base.as((v, t, t2) => _ItemLocationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ItemLocationCopyWith<$R, $In extends ItemLocation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? namespace, String? id});
  ItemLocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ItemLocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ItemLocation, $Out>
    implements ItemLocationCopyWith<$R, ItemLocation, $Out> {
  _ItemLocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ItemLocation> $mapper =
      ItemLocationMapper.ensureInitialized();
  @override
  $R call({String? namespace, String? id}) => $apply(
    FieldCopyWithData({
      if (namespace != null) #namespace: namespace,
      if (id != null) #id: id,
    }),
  );
  @override
  ItemLocation $make(CopyWithData data) => ItemLocation(
    data.get(#namespace, or: $value.namespace),
    data.get(#id, or: $value.id),
  );

  @override
  ItemLocationCopyWith<$R2, ItemLocation, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ItemLocationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

