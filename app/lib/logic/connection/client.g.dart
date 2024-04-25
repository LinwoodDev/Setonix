// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FetchedPlayersClientConnectionMessageImpl
    _$$FetchedPlayersClientConnectionMessageImplFromJson(Map json) =>
        _$FetchedPlayersClientConnectionMessageImpl(
          (json['players'] as List<dynamic>)
              .map((e) =>
                  GamePlayer.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList(),
          (json['playerId'] as num).toInt(),
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$FetchedPlayersClientConnectionMessageImplToJson(
        _$FetchedPlayersClientConnectionMessageImpl instance) =>
    <String, dynamic>{
      'players': instance.players.map((e) => e.toJson()).toList(),
      'playerId': instance.playerId,
      'type': instance.$type,
    };

_$ChatMessageClientConnectionMessageImpl
    _$$ChatMessageClientConnectionMessageImplFromJson(Map json) =>
        _$ChatMessageClientConnectionMessageImpl(
          json['message'] as String,
          json['from'] as String,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$ChatMessageClientConnectionMessageImplToJson(
        _$ChatMessageClientConnectionMessageImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'from': instance.from,
      'type': instance.$type,
    };

_$GameStateChangedClientConnectionMessageImpl
    _$$GameStateChangedClientConnectionMessageImplFromJson(Map json) =>
        _$GameStateChangedClientConnectionMessageImpl(
          GameState.fromJson(Map<String, dynamic>.from(json['state'] as Map)),
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$GameStateChangedClientConnectionMessageImplToJson(
        _$GameStateChangedClientConnectionMessageImpl instance) =>
    <String, dynamic>{
      'state': instance.state.toJson(),
      'type': instance.$type,
    };
