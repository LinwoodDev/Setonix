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
        );

Map<String, dynamic> _$$FetchedPlayersClientConnectionMessageToJson(
        _$FetchedPlayersClientConnectionMessage instance) =>
    <String, dynamic>{
      'players': instance.players,
    };
