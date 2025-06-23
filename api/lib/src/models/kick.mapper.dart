// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'kick.dart';

class KickMessageMapper extends ClassMapperBase<KickMessage> {
  KickMessageMapper._();

  static KickMessageMapper? _instance;
  static KickMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = KickMessageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'KickMessage';

  static String? _$message(KickMessage v) => v.message;
  static const Field<KickMessage, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static String? _$link(KickMessage v) => v.link;
  static const Field<KickMessage, String> _f$link = Field(
    'link',
    _$link,
    opt: true,
  );
  static KickReason? _$reason(KickMessage v) => v.reason;
  static const Field<KickMessage, KickReason> _f$reason = Field(
    'reason',
    _$reason,
    opt: true,
  );

  @override
  final MappableFields<KickMessage> fields = const {
    #message: _f$message,
    #link: _f$link,
    #reason: _f$reason,
  };

  @override
  final MappingHook hook = const KickMessageHook();
  static KickMessage _instantiate(DecodingData data) {
    return KickMessage(
      message: data.dec(_f$message),
      link: data.dec(_f$link),
      reason: data.dec(_f$reason),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static KickMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<KickMessage>(map);
  }

  static KickMessage fromJson(String json) {
    return ensureInitialized().decodeJson<KickMessage>(json);
  }
}

mixin KickMessageMappable {
  String toJson() {
    return KickMessageMapper.ensureInitialized().encodeJson<KickMessage>(
      this as KickMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return KickMessageMapper.ensureInitialized().encodeMap<KickMessage>(
      this as KickMessage,
    );
  }

  KickMessageCopyWith<KickMessage, KickMessage, KickMessage> get copyWith =>
      _KickMessageCopyWithImpl<KickMessage, KickMessage>(
        this as KickMessage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return KickMessageMapper.ensureInitialized().stringifyValue(
      this as KickMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    return KickMessageMapper.ensureInitialized().equalsValue(
      this as KickMessage,
      other,
    );
  }

  @override
  int get hashCode {
    return KickMessageMapper.ensureInitialized().hashValue(this as KickMessage);
  }
}

extension KickMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, KickMessage, $Out> {
  KickMessageCopyWith<$R, KickMessage, $Out> get $asKickMessage =>
      $base.as((v, t, t2) => _KickMessageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class KickMessageCopyWith<$R, $In extends KickMessage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? message, String? link, KickReason? reason});
  KickMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _KickMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, KickMessage, $Out>
    implements KickMessageCopyWith<$R, KickMessage, $Out> {
  _KickMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<KickMessage> $mapper =
      KickMessageMapper.ensureInitialized();
  @override
  $R call({
    Object? message = $none,
    Object? link = $none,
    Object? reason = $none,
  }) => $apply(
    FieldCopyWithData({
      if (message != $none) #message: message,
      if (link != $none) #link: link,
      if (reason != $none) #reason: reason,
    }),
  );
  @override
  KickMessage $make(CopyWithData data) => KickMessage(
    message: data.get(#message, or: $value.message),
    link: data.get(#link, or: $value.link),
    reason: data.get(#reason, or: $value.reason),
  );

  @override
  KickMessageCopyWith<$R2, KickMessage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _KickMessageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
