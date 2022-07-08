// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketCapability _$WebSocketCapabilityFromJson(Map<String, dynamic> json) =>
    WebSocketCapability(
      json['supportsPush'] as bool,
      Uri.parse(json['url'] as String),
    );

Map<String, dynamic> _$WebSocketCapabilityToJson(
        WebSocketCapability instance) =>
    <String, dynamic>{
      'supportsPush': instance.supportsPush,
      'url': instance.url.toString(),
    };
