// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'translation.dart';

class PackTranslationMapper extends ClassMapperBase<PackTranslation> {
  PackTranslationMapper._();

  static PackTranslationMapper? _instance;
  static PackTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PackTranslationMapper._());
      DeckTranslationMapper.ensureInitialized();
      FigureTranslationMapper.ensureInitialized();
      BackgroundTranslationMapper.ensureInitialized();
      BoardTranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PackTranslation';

  static Map<String, DeckTranslation> _$decks(PackTranslation v) => v.decks;
  static const Field<PackTranslation, Map<String, DeckTranslation>> _f$decks =
      Field('decks', _$decks, opt: true, def: const {});
  static Map<String, FigureTranslation> _$figures(PackTranslation v) =>
      v.figures;
  static const Field<PackTranslation, Map<String, FigureTranslation>>
      _f$figures = Field('figures', _$figures, opt: true, def: const {});
  static Map<String, BackgroundTranslation> _$backgrounds(PackTranslation v) =>
      v.backgrounds;
  static const Field<PackTranslation, Map<String, BackgroundTranslation>>
      _f$backgrounds =
      Field('backgrounds', _$backgrounds, opt: true, def: const {});
  static Map<String, BoardTranslation> _$boards(PackTranslation v) => v.boards;
  static const Field<PackTranslation, Map<String, BoardTranslation>> _f$boards =
      Field('boards', _$boards, opt: true, def: const {});

  @override
  final MappableFields<PackTranslation> fields = const {
    #decks: _f$decks,
    #figures: _f$figures,
    #backgrounds: _f$backgrounds,
    #boards: _f$boards,
  };

  static PackTranslation _instantiate(DecodingData data) {
    return PackTranslation(
        decks: data.dec(_f$decks),
        figures: data.dec(_f$figures),
        backgrounds: data.dec(_f$backgrounds),
        boards: data.dec(_f$boards));
  }

  @override
  final Function instantiate = _instantiate;

  static PackTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PackTranslation>(map);
  }

  static PackTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<PackTranslation>(json);
  }
}

mixin PackTranslationMappable {
  String toJson() {
    return PackTranslationMapper.ensureInitialized()
        .encodeJson<PackTranslation>(this as PackTranslation);
  }

  Map<String, dynamic> toMap() {
    return PackTranslationMapper.ensureInitialized()
        .encodeMap<PackTranslation>(this as PackTranslation);
  }

  PackTranslationCopyWith<PackTranslation, PackTranslation, PackTranslation>
      get copyWith => _PackTranslationCopyWithImpl(
          this as PackTranslation, $identity, $identity);
  @override
  String toString() {
    return PackTranslationMapper.ensureInitialized()
        .stringifyValue(this as PackTranslation);
  }

  @override
  bool operator ==(Object other) {
    return PackTranslationMapper.ensureInitialized()
        .equalsValue(this as PackTranslation, other);
  }

  @override
  int get hashCode {
    return PackTranslationMapper.ensureInitialized()
        .hashValue(this as PackTranslation);
  }
}

extension PackTranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PackTranslation, $Out> {
  PackTranslationCopyWith<$R, PackTranslation, $Out> get $asPackTranslation =>
      $base.as((v, t, t2) => _PackTranslationCopyWithImpl(v, t, t2));
}

abstract class PackTranslationCopyWith<$R, $In extends PackTranslation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, DeckTranslation,
      DeckTranslationCopyWith<$R, DeckTranslation, DeckTranslation>> get decks;
  MapCopyWith<$R, String, FigureTranslation,
          FigureTranslationCopyWith<$R, FigureTranslation, FigureTranslation>>
      get figures;
  MapCopyWith<
      $R,
      String,
      BackgroundTranslation,
      BackgroundTranslationCopyWith<$R, BackgroundTranslation,
          BackgroundTranslation>> get backgrounds;
  MapCopyWith<$R, String, BoardTranslation,
          BoardTranslationCopyWith<$R, BoardTranslation, BoardTranslation>>
      get boards;
  $R call(
      {Map<String, DeckTranslation>? decks,
      Map<String, FigureTranslation>? figures,
      Map<String, BackgroundTranslation>? backgrounds,
      Map<String, BoardTranslation>? boards});
  PackTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PackTranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PackTranslation, $Out>
    implements PackTranslationCopyWith<$R, PackTranslation, $Out> {
  _PackTranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PackTranslation> $mapper =
      PackTranslationMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, DeckTranslation,
          DeckTranslationCopyWith<$R, DeckTranslation, DeckTranslation>>
      get decks => MapCopyWith(
          $value.decks, (v, t) => v.copyWith.$chain(t), (v) => call(decks: v));
  @override
  MapCopyWith<$R, String, FigureTranslation,
          FigureTranslationCopyWith<$R, FigureTranslation, FigureTranslation>>
      get figures => MapCopyWith($value.figures, (v, t) => v.copyWith.$chain(t),
          (v) => call(figures: v));
  @override
  MapCopyWith<
      $R,
      String,
      BackgroundTranslation,
      BackgroundTranslationCopyWith<$R, BackgroundTranslation,
          BackgroundTranslation>> get backgrounds => MapCopyWith(
      $value.backgrounds,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(backgrounds: v));
  @override
  MapCopyWith<$R, String, BoardTranslation,
          BoardTranslationCopyWith<$R, BoardTranslation, BoardTranslation>>
      get boards => MapCopyWith($value.boards, (v, t) => v.copyWith.$chain(t),
          (v) => call(boards: v));
  @override
  $R call(
          {Map<String, DeckTranslation>? decks,
          Map<String, FigureTranslation>? figures,
          Map<String, BackgroundTranslation>? backgrounds,
          Map<String, BoardTranslation>? boards}) =>
      $apply(FieldCopyWithData({
        if (decks != null) #decks: decks,
        if (figures != null) #figures: figures,
        if (backgrounds != null) #backgrounds: backgrounds,
        if (boards != null) #boards: boards
      }));
  @override
  PackTranslation $make(CopyWithData data) => PackTranslation(
      decks: data.get(#decks, or: $value.decks),
      figures: data.get(#figures, or: $value.figures),
      backgrounds: data.get(#backgrounds, or: $value.backgrounds),
      boards: data.get(#boards, or: $value.boards));

  @override
  PackTranslationCopyWith<$R2, PackTranslation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PackTranslationCopyWithImpl($value, $cast, t);
}

class DeckTranslationMapper extends ClassMapperBase<DeckTranslation> {
  DeckTranslationMapper._();

  static DeckTranslationMapper? _instance;
  static DeckTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckTranslationMapper._());
      DescriptiveTranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeckTranslation';

  static String _$name(DeckTranslation v) => v.name;
  static const Field<DeckTranslation, String> _f$name = Field('name', _$name);
  static String? _$description(DeckTranslation v) => v.description;
  static const Field<DeckTranslation, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<DeckTranslation> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static DeckTranslation _instantiate(DecodingData data) {
    return DeckTranslation(
        name: data.dec(_f$name), description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static DeckTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeckTranslation>(map);
  }

  static DeckTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<DeckTranslation>(json);
  }
}

mixin DeckTranslationMappable {
  String toJson() {
    return DeckTranslationMapper.ensureInitialized()
        .encodeJson<DeckTranslation>(this as DeckTranslation);
  }

  Map<String, dynamic> toMap() {
    return DeckTranslationMapper.ensureInitialized()
        .encodeMap<DeckTranslation>(this as DeckTranslation);
  }

  DeckTranslationCopyWith<DeckTranslation, DeckTranslation, DeckTranslation>
      get copyWith => _DeckTranslationCopyWithImpl(
          this as DeckTranslation, $identity, $identity);
  @override
  String toString() {
    return DeckTranslationMapper.ensureInitialized()
        .stringifyValue(this as DeckTranslation);
  }

  @override
  bool operator ==(Object other) {
    return DeckTranslationMapper.ensureInitialized()
        .equalsValue(this as DeckTranslation, other);
  }

  @override
  int get hashCode {
    return DeckTranslationMapper.ensureInitialized()
        .hashValue(this as DeckTranslation);
  }
}

extension DeckTranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeckTranslation, $Out> {
  DeckTranslationCopyWith<$R, DeckTranslation, $Out> get $asDeckTranslation =>
      $base.as((v, t, t2) => _DeckTranslationCopyWithImpl(v, t, t2));
}

abstract class DeckTranslationCopyWith<$R, $In extends DeckTranslation, $Out>
    implements DescriptiveTranslationCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? description});
  DeckTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DeckTranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeckTranslation, $Out>
    implements DeckTranslationCopyWith<$R, DeckTranslation, $Out> {
  _DeckTranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeckTranslation> $mapper =
      DeckTranslationMapper.ensureInitialized();
  @override
  $R call({String? name, Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (description != $none) #description: description
      }));
  @override
  DeckTranslation $make(CopyWithData data) => DeckTranslation(
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description));

  @override
  DeckTranslationCopyWith<$R2, DeckTranslation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckTranslationCopyWithImpl($value, $cast, t);
}

class DescriptiveTranslationMapper
    extends ClassMapperBase<DescriptiveTranslation> {
  DescriptiveTranslationMapper._();

  static DescriptiveTranslationMapper? _instance;
  static DescriptiveTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DescriptiveTranslationMapper._());
      DeckTranslationMapper.ensureInitialized();
      FigureTranslationMapper.ensureInitialized();
      FigureVariationTranslationMapper.ensureInitialized();
      BackgroundTranslationMapper.ensureInitialized();
      BoardTranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DescriptiveTranslation';

  static String _$name(DescriptiveTranslation v) => v.name;
  static const Field<DescriptiveTranslation, String> _f$name =
      Field('name', _$name);
  static String? _$description(DescriptiveTranslation v) => v.description;
  static const Field<DescriptiveTranslation, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<DescriptiveTranslation> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static DescriptiveTranslation _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('DescriptiveTranslation');
  }

  @override
  final Function instantiate = _instantiate;

  static DescriptiveTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DescriptiveTranslation>(map);
  }

  static DescriptiveTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<DescriptiveTranslation>(json);
  }
}

mixin DescriptiveTranslationMappable {
  String toJson();
  Map<String, dynamic> toMap();
  DescriptiveTranslationCopyWith<DescriptiveTranslation, DescriptiveTranslation,
      DescriptiveTranslation> get copyWith;
}

abstract class DescriptiveTranslationCopyWith<
    $R,
    $In extends DescriptiveTranslation,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? description});
  DescriptiveTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class FigureTranslationMapper extends ClassMapperBase<FigureTranslation> {
  FigureTranslationMapper._();

  static FigureTranslationMapper? _instance;
  static FigureTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FigureTranslationMapper._());
      DescriptiveTranslationMapper.ensureInitialized();
      FigureVariationTranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FigureTranslation';

  static String _$name(FigureTranslation v) => v.name;
  static const Field<FigureTranslation, String> _f$name = Field('name', _$name);
  static String? _$description(FigureTranslation v) => v.description;
  static const Field<FigureTranslation, String> _f$description =
      Field('description', _$description, opt: true);
  static Map<String, FigureVariationTranslation> _$variations(
          FigureTranslation v) =>
      v.variations;
  static const Field<FigureTranslation, Map<String, FigureVariationTranslation>>
      _f$variations =
      Field('variations', _$variations, opt: true, def: const {});

  @override
  final MappableFields<FigureTranslation> fields = const {
    #name: _f$name,
    #description: _f$description,
    #variations: _f$variations,
  };

  static FigureTranslation _instantiate(DecodingData data) {
    return FigureTranslation(
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        variations: data.dec(_f$variations));
  }

  @override
  final Function instantiate = _instantiate;

  static FigureTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FigureTranslation>(map);
  }

  static FigureTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<FigureTranslation>(json);
  }
}

mixin FigureTranslationMappable {
  String toJson() {
    return FigureTranslationMapper.ensureInitialized()
        .encodeJson<FigureTranslation>(this as FigureTranslation);
  }

  Map<String, dynamic> toMap() {
    return FigureTranslationMapper.ensureInitialized()
        .encodeMap<FigureTranslation>(this as FigureTranslation);
  }

  FigureTranslationCopyWith<FigureTranslation, FigureTranslation,
          FigureTranslation>
      get copyWith => _FigureTranslationCopyWithImpl(
          this as FigureTranslation, $identity, $identity);
  @override
  String toString() {
    return FigureTranslationMapper.ensureInitialized()
        .stringifyValue(this as FigureTranslation);
  }

  @override
  bool operator ==(Object other) {
    return FigureTranslationMapper.ensureInitialized()
        .equalsValue(this as FigureTranslation, other);
  }

  @override
  int get hashCode {
    return FigureTranslationMapper.ensureInitialized()
        .hashValue(this as FigureTranslation);
  }
}

extension FigureTranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FigureTranslation, $Out> {
  FigureTranslationCopyWith<$R, FigureTranslation, $Out>
      get $asFigureTranslation =>
          $base.as((v, t, t2) => _FigureTranslationCopyWithImpl(v, t, t2));
}

abstract class FigureTranslationCopyWith<$R, $In extends FigureTranslation,
    $Out> implements DescriptiveTranslationCopyWith<$R, $In, $Out> {
  MapCopyWith<
      $R,
      String,
      FigureVariationTranslation,
      FigureVariationTranslationCopyWith<$R, FigureVariationTranslation,
          FigureVariationTranslation>> get variations;
  @override
  $R call(
      {String? name,
      String? description,
      Map<String, FigureVariationTranslation>? variations});
  FigureTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FigureTranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FigureTranslation, $Out>
    implements FigureTranslationCopyWith<$R, FigureTranslation, $Out> {
  _FigureTranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FigureTranslation> $mapper =
      FigureTranslationMapper.ensureInitialized();
  @override
  MapCopyWith<
      $R,
      String,
      FigureVariationTranslation,
      FigureVariationTranslationCopyWith<$R, FigureVariationTranslation,
          FigureVariationTranslation>> get variations => MapCopyWith(
      $value.variations,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(variations: v));
  @override
  $R call(
          {String? name,
          Object? description = $none,
          Map<String, FigureVariationTranslation>? variations}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (description != $none) #description: description,
        if (variations != null) #variations: variations
      }));
  @override
  FigureTranslation $make(CopyWithData data) => FigureTranslation(
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      variations: data.get(#variations, or: $value.variations));

  @override
  FigureTranslationCopyWith<$R2, FigureTranslation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FigureTranslationCopyWithImpl($value, $cast, t);
}

class FigureVariationTranslationMapper
    extends ClassMapperBase<FigureVariationTranslation> {
  FigureVariationTranslationMapper._();

  static FigureVariationTranslationMapper? _instance;
  static FigureVariationTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = FigureVariationTranslationMapper._());
      DescriptiveTranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FigureVariationTranslation';

  static String _$name(FigureVariationTranslation v) => v.name;
  static const Field<FigureVariationTranslation, String> _f$name =
      Field('name', _$name);
  static String? _$description(FigureVariationTranslation v) => v.description;
  static const Field<FigureVariationTranslation, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<FigureVariationTranslation> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static FigureVariationTranslation _instantiate(DecodingData data) {
    return FigureVariationTranslation(
        name: data.dec(_f$name), description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static FigureVariationTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FigureVariationTranslation>(map);
  }

  static FigureVariationTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<FigureVariationTranslation>(json);
  }
}

mixin FigureVariationTranslationMappable {
  String toJson() {
    return FigureVariationTranslationMapper.ensureInitialized()
        .encodeJson<FigureVariationTranslation>(
            this as FigureVariationTranslation);
  }

  Map<String, dynamic> toMap() {
    return FigureVariationTranslationMapper.ensureInitialized()
        .encodeMap<FigureVariationTranslation>(
            this as FigureVariationTranslation);
  }

  FigureVariationTranslationCopyWith<FigureVariationTranslation,
          FigureVariationTranslation, FigureVariationTranslation>
      get copyWith => _FigureVariationTranslationCopyWithImpl(
          this as FigureVariationTranslation, $identity, $identity);
  @override
  String toString() {
    return FigureVariationTranslationMapper.ensureInitialized()
        .stringifyValue(this as FigureVariationTranslation);
  }

  @override
  bool operator ==(Object other) {
    return FigureVariationTranslationMapper.ensureInitialized()
        .equalsValue(this as FigureVariationTranslation, other);
  }

  @override
  int get hashCode {
    return FigureVariationTranslationMapper.ensureInitialized()
        .hashValue(this as FigureVariationTranslation);
  }
}

extension FigureVariationTranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FigureVariationTranslation, $Out> {
  FigureVariationTranslationCopyWith<$R, FigureVariationTranslation, $Out>
      get $asFigureVariationTranslation => $base
          .as((v, t, t2) => _FigureVariationTranslationCopyWithImpl(v, t, t2));
}

abstract class FigureVariationTranslationCopyWith<
    $R,
    $In extends FigureVariationTranslation,
    $Out> implements DescriptiveTranslationCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? description});
  FigureVariationTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FigureVariationTranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FigureVariationTranslation, $Out>
    implements
        FigureVariationTranslationCopyWith<$R, FigureVariationTranslation,
            $Out> {
  _FigureVariationTranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FigureVariationTranslation> $mapper =
      FigureVariationTranslationMapper.ensureInitialized();
  @override
  $R call({String? name, Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (description != $none) #description: description
      }));
  @override
  FigureVariationTranslation $make(CopyWithData data) =>
      FigureVariationTranslation(
          name: data.get(#name, or: $value.name),
          description: data.get(#description, or: $value.description));

  @override
  FigureVariationTranslationCopyWith<$R2, FigureVariationTranslation, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _FigureVariationTranslationCopyWithImpl($value, $cast, t);
}

class BackgroundTranslationMapper
    extends ClassMapperBase<BackgroundTranslation> {
  BackgroundTranslationMapper._();

  static BackgroundTranslationMapper? _instance;
  static BackgroundTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BackgroundTranslationMapper._());
      DescriptiveTranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BackgroundTranslation';

  static String _$name(BackgroundTranslation v) => v.name;
  static const Field<BackgroundTranslation, String> _f$name =
      Field('name', _$name);
  static String? _$description(BackgroundTranslation v) => v.description;
  static const Field<BackgroundTranslation, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<BackgroundTranslation> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static BackgroundTranslation _instantiate(DecodingData data) {
    return BackgroundTranslation(
        name: data.dec(_f$name), description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static BackgroundTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BackgroundTranslation>(map);
  }

  static BackgroundTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<BackgroundTranslation>(json);
  }
}

mixin BackgroundTranslationMappable {
  String toJson() {
    return BackgroundTranslationMapper.ensureInitialized()
        .encodeJson<BackgroundTranslation>(this as BackgroundTranslation);
  }

  Map<String, dynamic> toMap() {
    return BackgroundTranslationMapper.ensureInitialized()
        .encodeMap<BackgroundTranslation>(this as BackgroundTranslation);
  }

  BackgroundTranslationCopyWith<BackgroundTranslation, BackgroundTranslation,
          BackgroundTranslation>
      get copyWith => _BackgroundTranslationCopyWithImpl(
          this as BackgroundTranslation, $identity, $identity);
  @override
  String toString() {
    return BackgroundTranslationMapper.ensureInitialized()
        .stringifyValue(this as BackgroundTranslation);
  }

  @override
  bool operator ==(Object other) {
    return BackgroundTranslationMapper.ensureInitialized()
        .equalsValue(this as BackgroundTranslation, other);
  }

  @override
  int get hashCode {
    return BackgroundTranslationMapper.ensureInitialized()
        .hashValue(this as BackgroundTranslation);
  }
}

extension BackgroundTranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BackgroundTranslation, $Out> {
  BackgroundTranslationCopyWith<$R, BackgroundTranslation, $Out>
      get $asBackgroundTranslation =>
          $base.as((v, t, t2) => _BackgroundTranslationCopyWithImpl(v, t, t2));
}

abstract class BackgroundTranslationCopyWith<
    $R,
    $In extends BackgroundTranslation,
    $Out> implements DescriptiveTranslationCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? description});
  BackgroundTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BackgroundTranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BackgroundTranslation, $Out>
    implements BackgroundTranslationCopyWith<$R, BackgroundTranslation, $Out> {
  _BackgroundTranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BackgroundTranslation> $mapper =
      BackgroundTranslationMapper.ensureInitialized();
  @override
  $R call({String? name, Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (description != $none) #description: description
      }));
  @override
  BackgroundTranslation $make(CopyWithData data) => BackgroundTranslation(
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description));

  @override
  BackgroundTranslationCopyWith<$R2, BackgroundTranslation, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _BackgroundTranslationCopyWithImpl($value, $cast, t);
}

class BoardTranslationMapper extends ClassMapperBase<BoardTranslation> {
  BoardTranslationMapper._();

  static BoardTranslationMapper? _instance;
  static BoardTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardTranslationMapper._());
      DescriptiveTranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardTranslation';

  static String _$name(BoardTranslation v) => v.name;
  static const Field<BoardTranslation, String> _f$name = Field('name', _$name);
  static String? _$description(BoardTranslation v) => v.description;
  static const Field<BoardTranslation, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<BoardTranslation> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static BoardTranslation _instantiate(DecodingData data) {
    return BoardTranslation(
        name: data.dec(_f$name), description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardTranslation>(map);
  }

  static BoardTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<BoardTranslation>(json);
  }
}

mixin BoardTranslationMappable {
  String toJson() {
    return BoardTranslationMapper.ensureInitialized()
        .encodeJson<BoardTranslation>(this as BoardTranslation);
  }

  Map<String, dynamic> toMap() {
    return BoardTranslationMapper.ensureInitialized()
        .encodeMap<BoardTranslation>(this as BoardTranslation);
  }

  BoardTranslationCopyWith<BoardTranslation, BoardTranslation, BoardTranslation>
      get copyWith => _BoardTranslationCopyWithImpl(
          this as BoardTranslation, $identity, $identity);
  @override
  String toString() {
    return BoardTranslationMapper.ensureInitialized()
        .stringifyValue(this as BoardTranslation);
  }

  @override
  bool operator ==(Object other) {
    return BoardTranslationMapper.ensureInitialized()
        .equalsValue(this as BoardTranslation, other);
  }

  @override
  int get hashCode {
    return BoardTranslationMapper.ensureInitialized()
        .hashValue(this as BoardTranslation);
  }
}

extension BoardTranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardTranslation, $Out> {
  BoardTranslationCopyWith<$R, BoardTranslation, $Out>
      get $asBoardTranslation =>
          $base.as((v, t, t2) => _BoardTranslationCopyWithImpl(v, t, t2));
}

abstract class BoardTranslationCopyWith<$R, $In extends BoardTranslation, $Out>
    implements DescriptiveTranslationCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? description});
  BoardTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BoardTranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardTranslation, $Out>
    implements BoardTranslationCopyWith<$R, BoardTranslation, $Out> {
  _BoardTranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardTranslation> $mapper =
      BoardTranslationMapper.ensureInitialized();
  @override
  $R call({String? name, Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (description != $none) #description: description
      }));
  @override
  BoardTranslation $make(CopyWithData data) => BoardTranslation(
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description));

  @override
  BoardTranslationCopyWith<$R2, BoardTranslation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoardTranslationCopyWithImpl($value, $cast, t);
}
