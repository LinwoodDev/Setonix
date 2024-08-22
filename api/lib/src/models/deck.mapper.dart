// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'deck.dart';

class DeckDefinitionMapper extends ClassMapperBase<DeckDefinition> {
  DeckDefinitionMapper._();

  static DeckDefinitionMapper? _instance;
  static DeckDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckDefinitionMapper._());
      FigureDeckDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeckDefinition';

  static String? _$name(DeckDefinition v) => v.name;
  static const Field<DeckDefinition, String> _f$name =
      Field('name', _$name, opt: true);
  static String? _$description(DeckDefinition v) => v.description;
  static const Field<DeckDefinition, String> _f$description =
      Field('description', _$description, opt: true);
  static List<FigureDeckDefinition> _$figures(DeckDefinition v) => v.figures;
  static const Field<DeckDefinition, List<FigureDeckDefinition>> _f$figures =
      Field('figures', _$figures, opt: true, def: const []);

  @override
  final MappableFields<DeckDefinition> fields = const {
    #name: _f$name,
    #description: _f$description,
    #figures: _f$figures,
  };

  static DeckDefinition _instantiate(DecodingData data) {
    return DeckDefinition(
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        figures: data.dec(_f$figures));
  }

  @override
  final Function instantiate = _instantiate;

  static DeckDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeckDefinition>(map);
  }

  static DeckDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<DeckDefinition>(json);
  }
}

mixin DeckDefinitionMappable {
  String toJson() {
    return DeckDefinitionMapper.ensureInitialized()
        .encodeJson<DeckDefinition>(this as DeckDefinition);
  }

  Map<String, dynamic> toMap() {
    return DeckDefinitionMapper.ensureInitialized()
        .encodeMap<DeckDefinition>(this as DeckDefinition);
  }

  DeckDefinitionCopyWith<DeckDefinition, DeckDefinition, DeckDefinition>
      get copyWith => _DeckDefinitionCopyWithImpl(
          this as DeckDefinition, $identity, $identity);
  @override
  String toString() {
    return DeckDefinitionMapper.ensureInitialized()
        .stringifyValue(this as DeckDefinition);
  }

  @override
  bool operator ==(Object other) {
    return DeckDefinitionMapper.ensureInitialized()
        .equalsValue(this as DeckDefinition, other);
  }

  @override
  int get hashCode {
    return DeckDefinitionMapper.ensureInitialized()
        .hashValue(this as DeckDefinition);
  }
}

extension DeckDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeckDefinition, $Out> {
  DeckDefinitionCopyWith<$R, DeckDefinition, $Out> get $asDeckDefinition =>
      $base.as((v, t, t2) => _DeckDefinitionCopyWithImpl(v, t, t2));
}

abstract class DeckDefinitionCopyWith<$R, $In extends DeckDefinition, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      FigureDeckDefinition,
      FigureDeckDefinitionCopyWith<$R, FigureDeckDefinition,
          FigureDeckDefinition>> get figures;
  $R call(
      {String? name, String? description, List<FigureDeckDefinition>? figures});
  DeckDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DeckDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeckDefinition, $Out>
    implements DeckDefinitionCopyWith<$R, DeckDefinition, $Out> {
  _DeckDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeckDefinition> $mapper =
      DeckDefinitionMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      FigureDeckDefinition,
      FigureDeckDefinitionCopyWith<$R, FigureDeckDefinition,
          FigureDeckDefinition>> get figures => ListCopyWith(
      $value.figures, (v, t) => v.copyWith.$chain(t), (v) => call(figures: v));
  @override
  $R call(
          {Object? name = $none,
          Object? description = $none,
          List<FigureDeckDefinition>? figures}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (description != $none) #description: description,
        if (figures != null) #figures: figures
      }));
  @override
  DeckDefinition $make(CopyWithData data) => DeckDefinition(
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      figures: data.get(#figures, or: $value.figures));

  @override
  DeckDefinitionCopyWith<$R2, DeckDefinition, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckDefinitionCopyWithImpl($value, $cast, t);
}

class FigureDeckDefinitionMapper extends ClassMapperBase<FigureDeckDefinition> {
  FigureDeckDefinitionMapper._();

  static FigureDeckDefinitionMapper? _instance;
  static FigureDeckDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FigureDeckDefinitionMapper._());
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FigureDeckDefinition';

  static String _$name(FigureDeckDefinition v) => v.name;
  static const Field<FigureDeckDefinition, String> _f$name =
      Field('name', _$name);
  static String? _$variation(FigureDeckDefinition v) => v.variation;
  static const Field<FigureDeckDefinition, String> _f$variation =
      Field('variation', _$variation, opt: true);
  static VectorDefinition _$location(FigureDeckDefinition v) => v.location;
  static const Field<FigureDeckDefinition, VectorDefinition> _f$location =
      Field('location', _$location, opt: true, def: VectorDefinition.zero);

  @override
  final MappableFields<FigureDeckDefinition> fields = const {
    #name: _f$name,
    #variation: _f$variation,
    #location: _f$location,
  };

  static FigureDeckDefinition _instantiate(DecodingData data) {
    return FigureDeckDefinition(
        name: data.dec(_f$name),
        variation: data.dec(_f$variation),
        location: data.dec(_f$location));
  }

  @override
  final Function instantiate = _instantiate;

  static FigureDeckDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FigureDeckDefinition>(map);
  }

  static FigureDeckDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<FigureDeckDefinition>(json);
  }
}

mixin FigureDeckDefinitionMappable {
  String toJson() {
    return FigureDeckDefinitionMapper.ensureInitialized()
        .encodeJson<FigureDeckDefinition>(this as FigureDeckDefinition);
  }

  Map<String, dynamic> toMap() {
    return FigureDeckDefinitionMapper.ensureInitialized()
        .encodeMap<FigureDeckDefinition>(this as FigureDeckDefinition);
  }

  FigureDeckDefinitionCopyWith<FigureDeckDefinition, FigureDeckDefinition,
          FigureDeckDefinition>
      get copyWith => _FigureDeckDefinitionCopyWithImpl(
          this as FigureDeckDefinition, $identity, $identity);
  @override
  String toString() {
    return FigureDeckDefinitionMapper.ensureInitialized()
        .stringifyValue(this as FigureDeckDefinition);
  }

  @override
  bool operator ==(Object other) {
    return FigureDeckDefinitionMapper.ensureInitialized()
        .equalsValue(this as FigureDeckDefinition, other);
  }

  @override
  int get hashCode {
    return FigureDeckDefinitionMapper.ensureInitialized()
        .hashValue(this as FigureDeckDefinition);
  }
}

extension FigureDeckDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FigureDeckDefinition, $Out> {
  FigureDeckDefinitionCopyWith<$R, FigureDeckDefinition, $Out>
      get $asFigureDeckDefinition =>
          $base.as((v, t, t2) => _FigureDeckDefinitionCopyWithImpl(v, t, t2));
}

abstract class FigureDeckDefinitionCopyWith<
    $R,
    $In extends FigureDeckDefinition,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get location;
  $R call({String? name, String? variation, VectorDefinition? location});
  FigureDeckDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FigureDeckDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FigureDeckDefinition, $Out>
    implements FigureDeckDefinitionCopyWith<$R, FigureDeckDefinition, $Out> {
  _FigureDeckDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FigureDeckDefinition> $mapper =
      FigureDeckDefinitionMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>
      get location => $value.location.copyWith.$chain((v) => call(location: v));
  @override
  $R call(
          {String? name,
          Object? variation = $none,
          VectorDefinition? location}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (variation != $none) #variation: variation,
        if (location != null) #location: location
      }));
  @override
  FigureDeckDefinition $make(CopyWithData data) => FigureDeckDefinition(
      name: data.get(#name, or: $value.name),
      variation: data.get(#variation, or: $value.variation),
      location: data.get(#location, or: $value.location));

  @override
  FigureDeckDefinitionCopyWith<$R2, FigureDeckDefinition, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _FigureDeckDefinitionCopyWithImpl($value, $cast, t);
}
