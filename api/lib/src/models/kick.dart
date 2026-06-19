import 'package:dart_mappable/dart_mappable.dart';

part 'kick.mapper.dart';

@MappableEnum()
enum KickReason {
  kick,
  ban,
  notWhitelisted,
  notRegistered,
  challengeFailed,
  pleaseLink,
}

@MappableClass(hook: KickMessageHook())
final class KickMessage with KickMessageMappable {
  final String? message;
  final String? link;
  final KickReason? reason;

  const KickMessage({this.message, this.link, this.reason});

  factory KickMessage.fromString(String message) {
    try {
      return KickMessageMapper.fromJson(message);
    } catch (_) {
      return KickMessage(message: message);
    }
  }
}

class KickMessageHook extends MappingHook {
  const KickMessageHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      return {'message': value};
    }
    return super.beforeDecode(value);
  }
}
