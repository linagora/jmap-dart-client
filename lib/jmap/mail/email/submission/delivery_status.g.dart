// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryStatus _$DeliveryStatusFromJson(Map<String, dynamic> json) {
  return DeliveryStatus(
    json['smtpReply'] as String,
    const DeliveredConverter().fromJson(json['delivered'] as String),
    const DisplayedConverter().fromJson(json['displayed'] as String),
  );
}

Map<String, dynamic> _$DeliveryStatusToJson(DeliveryStatus instance) =>
    <String, dynamic>{
      'smtpReply': instance.smtpReply,
      'delivered': const DeliveredConverter().toJson(instance.delivered),
      'displayed': const DisplayedConverter().toJson(instance.displayed),
    };
