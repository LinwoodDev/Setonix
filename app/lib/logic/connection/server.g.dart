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

_$AddDeckServerConnectionMessage _$$AddDeckServerConnectionMessageFromJson(
        Map<String, dynamic> json) =>
    _$AddDeckServerConnectionMessage(
      GameDeck.fromJson(json['deck'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AddDeckServerConnectionMessageToJson(
        _$AddDeckServerConnectionMessage instance) =>
    <String, dynamic>{
      'deck': instance.deck,
      'runtimeType': instance.$type,
    };

_$RemoveDeckServerConnectionMessage
    _$$RemoveDeckServerConnectionMessageFromJson(Map<String, dynamic> json) =>
        _$RemoveDeckServerConnectionMessage(
          json['index'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$RemoveDeckServerConnectionMessageToJson(
        _$RemoveDeckServerConnectionMessage instance) =>
    <String, dynamic>{
      'index': instance.index,
      'runtimeType': instance.$type,
    };

_$AddSeatServerConnectionMessage _$$AddSeatServerConnectionMessageFromJson(
        Map<String, dynamic> json) =>
    _$AddSeatServerConnectionMessage(
      json['name'] as String,
      (json['decks'] as List<dynamic>?)
              ?.map((e) => GameDeck.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AddSeatServerConnectionMessageToJson(
        _$AddSeatServerConnectionMessage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'decks': instance.decks,
      'runtimeType': instance.$type,
    };

_$RemoveSeatServerConnectionMessage
    _$$RemoveSeatServerConnectionMessageFromJson(Map<String, dynamic> json) =>
        _$RemoveSeatServerConnectionMessage(
          json['index'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$RemoveSeatServerConnectionMessageToJson(
        _$RemoveSeatServerConnectionMessage instance) =>
    <String, dynamic>{
      'index': instance.index,
      'runtimeType': instance.$type,
    };

_$JoinSeatServerConnectionMessage _$$JoinSeatServerConnectionMessageFromJson(
        Map<String, dynamic> json) =>
    _$JoinSeatServerConnectionMessage(
      json['index'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$JoinSeatServerConnectionMessageToJson(
        _$JoinSeatServerConnectionMessage instance) =>
    <String, dynamic>{
      'index': instance.index,
      'runtimeType': instance.$type,
    };

_$LeaveSeatServerConnectionMessage _$$LeaveSeatServerConnectionMessageFromJson(
        Map<String, dynamic> json) =>
    _$LeaveSeatServerConnectionMessage(
      json['index'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LeaveSeatServerConnectionMessageToJson(
        _$LeaveSeatServerConnectionMessage instance) =>
    <String, dynamic>{
      'index': instance.index,
      'runtimeType': instance.$type,
    };
