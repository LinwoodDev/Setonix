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
      SwitchCellEventMapper.ensureInitialized();
      ChangeHandEventMapper.ensureInitialized();
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

class SwitchCellEventMapper extends ClassMapperBase<SwitchCellEvent> {
  SwitchCellEventMapper._();

  static SwitchCellEventMapper? _instance;
  static SwitchCellEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SwitchCellEventMapper._());
      BoardEventMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SwitchCellEvent';

  static VectorDefinition? _$cell(SwitchCellEvent v) => v.cell;
  static const Field<SwitchCellEvent, VectorDefinition> _f$cell =
      Field('cell', _$cell);

  @override
  final MappableFields<SwitchCellEvent> fields = const {
    #cell: _f$cell,
  };

  static SwitchCellEvent _instantiate(DecodingData data) {
    return SwitchCellEvent(data.dec(_f$cell));
  }

  @override
  final Function instantiate = _instantiate;

  static SwitchCellEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SwitchCellEvent>(map);
  }

  static SwitchCellEvent fromJson(String json) {
    return ensureInitialized().decodeJson<SwitchCellEvent>(json);
  }
}

mixin SwitchCellEventMappable {
  String toJson() {
    return SwitchCellEventMapper.ensureInitialized()
        .encodeJson<SwitchCellEvent>(this as SwitchCellEvent);
  }

  Map<String, dynamic> toMap() {
    return SwitchCellEventMapper.ensureInitialized()
        .encodeMap<SwitchCellEvent>(this as SwitchCellEvent);
  }

  SwitchCellEventCopyWith<SwitchCellEvent, SwitchCellEvent, SwitchCellEvent>
      get copyWith => _SwitchCellEventCopyWithImpl(
          this as SwitchCellEvent, $identity, $identity);
  @override
  String toString() {
    return SwitchCellEventMapper.ensureInitialized()
        .stringifyValue(this as SwitchCellEvent);
  }

  @override
  bool operator ==(Object other) {
    return SwitchCellEventMapper.ensureInitialized()
        .equalsValue(this as SwitchCellEvent, other);
  }

  @override
  int get hashCode {
    return SwitchCellEventMapper.ensureInitialized()
        .hashValue(this as SwitchCellEvent);
  }
}

extension SwitchCellEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SwitchCellEvent, $Out> {
  SwitchCellEventCopyWith<$R, SwitchCellEvent, $Out> get $asSwitchCellEvent =>
      $base.as((v, t, t2) => _SwitchCellEventCopyWithImpl(v, t, t2));
}

abstract class SwitchCellEventCopyWith<$R, $In extends SwitchCellEvent, $Out>
    implements BoardEventCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get cell;
  @override
  $R call({VectorDefinition? cell});
  SwitchCellEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SwitchCellEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SwitchCellEvent, $Out>
    implements SwitchCellEventCopyWith<$R, SwitchCellEvent, $Out> {
  _SwitchCellEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SwitchCellEvent> $mapper =
      SwitchCellEventMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get cell =>
      $value.cell?.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({Object? cell = $none}) =>
      $apply(FieldCopyWithData({if (cell != $none) #cell: cell}));
  @override
  SwitchCellEvent $make(CopyWithData data) =>
      SwitchCellEvent(data.get(#cell, or: $value.cell));

  @override
  SwitchCellEventCopyWith<$R2, SwitchCellEvent, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SwitchCellEventCopyWithImpl($value, $cast, t);
}

class ChangeHandEventMapper extends ClassMapperBase<ChangeHandEvent> {
  ChangeHandEventMapper._();

  static ChangeHandEventMapper? _instance;
  static ChangeHandEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChangeHandEventMapper._());
      BoardEventMapper.ensureInitialized();
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChangeHandEvent';

  static ItemLocation? _$deck(ChangeHandEvent v) => v.deck;
  static const Field<ChangeHandEvent, ItemLocation> _f$deck =
      Field('deck', _$deck, opt: true);
  static bool? _$show(ChangeHandEvent v) => v.show;
  static const Field<ChangeHandEvent, bool> _f$show =
      Field('show', _$show, opt: true, def: true);

  @override
  final MappableFields<ChangeHandEvent> fields = const {
    #deck: _f$deck,
    #show: _f$show,
  };

  static ChangeHandEvent _instantiate(DecodingData data) {
    return ChangeHandEvent(deck: data.dec(_f$deck), show: data.dec(_f$show));
  }

  @override
  final Function instantiate = _instantiate;

  static ChangeHandEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChangeHandEvent>(map);
  }

  static ChangeHandEvent fromJson(String json) {
    return ensureInitialized().decodeJson<ChangeHandEvent>(json);
  }
}

mixin ChangeHandEventMappable {
  String toJson() {
    return ChangeHandEventMapper.ensureInitialized()
        .encodeJson<ChangeHandEvent>(this as ChangeHandEvent);
  }

  Map<String, dynamic> toMap() {
    return ChangeHandEventMapper.ensureInitialized()
        .encodeMap<ChangeHandEvent>(this as ChangeHandEvent);
  }

  ChangeHandEventCopyWith<ChangeHandEvent, ChangeHandEvent, ChangeHandEvent>
      get copyWith => _ChangeHandEventCopyWithImpl(
          this as ChangeHandEvent, $identity, $identity);
  @override
  String toString() {
    return ChangeHandEventMapper.ensureInitialized()
        .stringifyValue(this as ChangeHandEvent);
  }

  @override
  bool operator ==(Object other) {
    return ChangeHandEventMapper.ensureInitialized()
        .equalsValue(this as ChangeHandEvent, other);
  }

  @override
  int get hashCode {
    return ChangeHandEventMapper.ensureInitialized()
        .hashValue(this as ChangeHandEvent);
  }
}

extension ChangeHandEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChangeHandEvent, $Out> {
  ChangeHandEventCopyWith<$R, ChangeHandEvent, $Out> get $asChangeHandEvent =>
      $base.as((v, t, t2) => _ChangeHandEventCopyWithImpl(v, t, t2));
}

abstract class ChangeHandEventCopyWith<$R, $In extends ChangeHandEvent, $Out>
    implements BoardEventCopyWith<$R, $In, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get deck;
  @override
  $R call({ItemLocation? deck, bool? show});
  ChangeHandEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ChangeHandEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChangeHandEvent, $Out>
    implements ChangeHandEventCopyWith<$R, ChangeHandEvent, $Out> {
  _ChangeHandEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChangeHandEvent> $mapper =
      ChangeHandEventMapper.ensureInitialized();
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get deck =>
      $value.deck?.copyWith.$chain((v) => call(deck: v));
  @override
  $R call({Object? deck = $none, bool? show}) => $apply(FieldCopyWithData(
      {if (deck != $none) #deck: deck, if (show != null) #show: show}));
  @override
  ChangeHandEvent $make(CopyWithData data) => ChangeHandEvent(
      deck: data.get(#deck, or: $value.deck),
      show: data.get(#show, or: $value.show));

  @override
  ChangeHandEventCopyWith<$R2, ChangeHandEvent, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ChangeHandEventCopyWithImpl($value, $cast, t);
}
