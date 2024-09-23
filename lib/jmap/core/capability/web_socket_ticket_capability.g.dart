// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket_ticket_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketTicketCapability _$WebSocketTicketCapabilityFromJson(
        Map<String, dynamic> json) =>
    WebSocketTicketCapability(
      generationEndpoint: json['generationEndpoint'] == null
          ? null
          : Uri.parse(json['generationEndpoint'] as String),
      revocationEndpoint: json['revocationEndpoint'] == null
          ? null
          : Uri.parse(json['revocationEndpoint'] as String),
    );

Map<String, dynamic> _$WebSocketTicketCapabilityToJson(
    WebSocketTicketCapability instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('generationEndpoint', instance.generationEndpoint?.toString());
  writeNotNull('revocationEndpoint', instance.revocationEndpoint?.toString());
  return val;
}
