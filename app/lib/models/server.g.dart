// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameServer _$$_GameServerFromJson(Map<String, dynamic> json) =>
    _$_GameServer(
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      port: json['port'] as int? ?? 0,
    );

Map<String, dynamic> _$$_GameServerToJson(_$_GameServer instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'port': instance.port,
    };
