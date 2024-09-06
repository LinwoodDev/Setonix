import 'package:dart_mappable/dart_mappable.dart';
import 'package:networker/networker.dart';

part 'chat.mapper.dart';

@MappableClass()
final class ChatMessage with ChatMessageMappable {
  final Channel author;
  final String content;
  final DateTime timestamp;

  const ChatMessage({
    required this.author,
    required this.content,
    required this.timestamp,
  });
}
