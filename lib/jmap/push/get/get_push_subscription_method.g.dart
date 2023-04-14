// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_push_subscription_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPushSubscriptionMethod _$GetPushSubscriptionMethodFromJson(
        Map<String, dynamic> json) =>
    GetPushSubscriptionMethod()
      ..blobIds =
          (json['blobIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..ids = (json['ids'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toSet()
      ..referenceIds = json['#ids'] == null
          ? null
          : ResultReference.fromJson(json['#ids'] as Map<String, dynamic>)
      ..properties = const PropertiesConverter()
          .fromJson(json['properties'] as List<String>?)
      ..referenceProperties = json['#properties'] == null
          ? null
          : ResultReference.fromJson(
              json['#properties'] as Map<String, dynamic>);

Map<String, dynamic> _$GetPushSubscriptionMethodToJson(
    GetPushSubscriptionMethod instance) {
  final val = <String, dynamic>{
    'blobIds': instance.blobIds,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ids', instance.ids?.map(const IdConverter().toJson).toList());
  writeNotNull('#ids', instance.referenceIds);
  writeNotNull(
      'properties', const PropertiesConverter().toJson(instance.properties));
  writeNotNull('#properties', instance.referenceProperties);
  return val;
}
