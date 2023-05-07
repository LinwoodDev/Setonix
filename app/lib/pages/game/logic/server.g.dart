// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FetchPlayersServerConnectionMessage
    _$$FetchPlayersServerConnectionMessageFromJson(Map<String, dynamic> json) =>
        _$FetchPlayersServerConnectionMessage(
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$FetchPlayersServerConnectionMessageToJson(
        _$FetchPlayersServerConnectionMessage instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ChatMessageServerConnectionMessage
    _$$ChatMessageServerConnectionMessageFromJson(Map<String, dynamic> json) =>
        _$ChatMessageServerConnectionMessage(
          json['message'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$ChatMessageServerConnectionMessageToJson(
        _$ChatMessageServerConnectionMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };
