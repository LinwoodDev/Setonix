// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'kick.dart';

/// @nodoc

class KickReasonMapper extends EnumMapper<KickReason> {
  KickReasonMapper._();

  static KickReasonMapper? _instance;
  static KickReasonMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = KickReasonMapper._());
    }
    return _instance!;
  }

  static KickReason fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  KickReason decode(dynamic value) {
    switch (value) {
      case r'kick':
        return KickReason.kick;
      case r'ban':
        return KickReason.ban;
      case r'notWhitelisted':
        return KickReason.notWhitelisted;
      case r'notRegistered':
        return KickReason.notRegistered;
      case r'challengeFailed':
        return KickReason.challengeFailed;
      case r'pleaseLink':
        return KickReason.pleaseLink;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(KickReason self) {
    switch (self) {
      case KickReason.kick:
        return r'kick';
      case KickReason.ban:
        return r'ban';
      case KickReason.notWhitelisted:
        return r'notWhitelisted';
      case KickReason.notRegistered:
        return r'notRegistered';
      case KickReason.challengeFailed:
        return r'challengeFailed';
      case KickReason.pleaseLink:
        return r'pleaseLink';
    }
  }
}

/// @nodoc

extension KickReasonMapperExtension on KickReason {
  String toValue() {
    KickReasonMapper.ensureInitialized();
    return MapperContainer.globals.toValue<KickReason>(this) as String;
  }
}

/// @nodoc
class KickMessageMapper extends ClassMapperBase<KickMessage> {
  KickMessageMapper._();

  static KickMessageMapper? _instance;
  static KickMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = KickMessageMapper._());
      KickReasonMapper.ensureInitialized();
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

/// @nodoc
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

/// @nodoc
extension KickMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, KickMessage, $Out> {
  KickMessageCopyWith<$R, KickMessage, $Out> get $asKickMessage =>
      $base.as((v, t, t2) => _KickMessageCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class KickMessageCopyWith<$R, $In extends KickMessage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? message, String? link, KickReason? reason});
  KickMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
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

