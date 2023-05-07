// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FetchedPlayersClientConnectionMessage
    _$$FetchedPlayersClientConnectionMessageFromJson(
            Map<String, dynamic> json) =>
        _$FetchedPlayersClientConnectionMessage(
          (json['players'] as List<dynamic>)
              .map((e) => GamePlayer.fromJson(e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$FetchedPlayersClientConnectionMessageToJson(
        _$FetchedPlayersClientConnectionMessage instance) =>
    <String, dynamic>{
      'players': instance.players,
      'runtimeType': instance.$type,
    };

_$ChatMessageClientConnectionMessage
    _$$ChatMessageClientConnectionMessageFromJson(Map<String, dynamic> json) =>
        _$ChatMessageClientConnectionMessage(
          json['message'] as String,
          json['from'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$ChatMessageClientConnectionMessageToJson(
        _$ChatMessageClientConnectionMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'from': instance.from,
      'runtimeType': instance.$type,
    };
