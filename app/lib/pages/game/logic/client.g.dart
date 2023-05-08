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
          json['playerId'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$FetchedPlayersClientConnectionMessageToJson(
        _$FetchedPlayersClientConnectionMessage instance) =>
    <String, dynamic>{
      'players': instance.players,
      'playerId': instance.playerId,
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

_$GameStateChangedClientConnectionMessage
    _$$GameStateChangedClientConnectionMessageFromJson(
            Map<String, dynamic> json) =>
        _$GameStateChangedClientConnectionMessage(
          GameState.fromJson(json['state'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$GameStateChangedClientConnectionMessageToJson(
        _$GameStateChangedClientConnectionMessage instance) =>
    <String, dynamic>{
      'state': instance.state,
      'runtimeType': instance.$type,
    };
