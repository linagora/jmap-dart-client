// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketCapability _$WebSocketCapabilityFromJson(Map<String, dynamic> json) =>
    WebSocketCapability(
      supportsPush: json['supportsPush'] as bool?,
      url: json['url'] == null ? null : Uri.parse(json['url'] as String),
    );

Map<String, dynamic> _$WebSocketCapabilityToJson(WebSocketCapability instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('supportsPush', instance.supportsPush);
  writeNotNull('url', instance.url?.toString());
  return val;
}
