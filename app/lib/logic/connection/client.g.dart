// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FetchedPlayersClientConnectionMessage
    _$$FetchedPlayersClientConnectionMessageFromJson(Map json) =>
        _$FetchedPlayersClientConnectionMessage(
          (json['players'] as List<dynamic>)
              .map((e) =>
                  GamePlayer.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList(),
          json['playerId'] as int,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$FetchedPlayersClientConnectionMessageToJson(
        _$FetchedPlayersClientConnectionMessage instance) =>
    <String, dynamic>{
      'players': instance.players.map((e) => e.toJson()).toList(),
      'playerId': instance.playerId,
      'type': instance.$type,
    };

_$ChatMessageClientConnectionMessage
    _$$ChatMessageClientConnectionMessageFromJson(Map json) =>
        _$ChatMessageClientConnectionMessage(
          json['message'] as String,
          json['from'] as String,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$ChatMessageClientConnectionMessageToJson(
        _$ChatMessageClientConnectionMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'from': instance.from,
      'type': instance.$type,
    };

_$GameStateChangedClientConnectionMessage
    _$$GameStateChangedClientConnectionMessageFromJson(Map json) =>
        _$GameStateChangedClientConnectionMessage(
          GameState.fromJson(Map<String, dynamic>.from(json['state'] as Map)),
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$GameStateChangedClientConnectionMessageToJson(
        _$GameStateChangedClientConnectionMessage instance) =>
    <String, dynamic>{
      'state': instance.state.toJson(),
      'type': instance.$type,
    };
