// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushSubscription _$PushSubscriptionFromJson(Map<String, dynamic> json) =>
    PushSubscription(
      id: const PushSubscriptionIdNullableConverter()
          .fromJson(json['id'] as String?),
      deviceClientId: json['deviceClientId'] as String?,
      url: json['url'] as String?,
      keys: json['keys'] == null
          ? null
          : EncryptionKey.fromJson(json['keys'] as Map<String, dynamic>),
      verificationCode: json['verificationCode'] as String?,
      expires:
          const UTCDateNullableConverter().fromJson(json['expires'] as String?),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PushSubscriptionToJson(PushSubscription instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'id', const PushSubscriptionIdNullableConverter().toJson(instance.id));
  writeNotNull('deviceClientId', instance.deviceClientId);
  writeNotNull('url', instance.url);
  writeNotNull('keys', instance.keys);
  writeNotNull('verificationCode', instance.verificationCode);
  writeNotNull(
      'expires', const UTCDateNullableConverter().toJson(instance.expires));
  writeNotNull('types', instance.types);
  return val;
}
