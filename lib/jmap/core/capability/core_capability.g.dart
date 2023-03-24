// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoreCapability _$CoreCapabilityFromJson(Map<String, dynamic> json) =>
    CoreCapability(
      maxSizeUpload: const UnsignedIntNullableConverter()
          .fromJson(json['maxSizeUpload'] as int?),
      maxConcurrentUpload: const UnsignedIntNullableConverter()
          .fromJson(json['maxConcurrentUpload'] as int?),
      maxSizeRequest: const UnsignedIntNullableConverter()
          .fromJson(json['maxSizeRequest'] as int?),
      maxConcurrentRequests: const UnsignedIntNullableConverter()
          .fromJson(json['maxConcurrentRequests'] as int?),
      maxCallsInRequest: const UnsignedIntNullableConverter()
          .fromJson(json['maxCallsInRequest'] as int?),
      maxObjectsInGet: const UnsignedIntNullableConverter()
          .fromJson(json['maxObjectsInGet'] as int?),
      maxObjectsInSet: const UnsignedIntNullableConverter()
          .fromJson(json['maxObjectsInSet'] as int?),
      collationAlgorithms: (json['collationAlgorithms'] as List<dynamic>?)
          ?.map(
              (e) => const CollationIdentifierConverter().fromJson(e as String))
          .toSet(),
    );

Map<String, dynamic> _$CoreCapabilityToJson(CoreCapability instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maxSizeUpload',
      const UnsignedIntNullableConverter().toJson(instance.maxSizeUpload));
  writeNotNull(
      'maxConcurrentUpload',
      const UnsignedIntNullableConverter()
          .toJson(instance.maxConcurrentUpload));
  writeNotNull('maxSizeRequest',
      const UnsignedIntNullableConverter().toJson(instance.maxSizeRequest));
  writeNotNull(
      'maxConcurrentRequests',
      const UnsignedIntNullableConverter()
          .toJson(instance.maxConcurrentRequests));
  writeNotNull('maxCallsInRequest',
      const UnsignedIntNullableConverter().toJson(instance.maxCallsInRequest));
  writeNotNull('maxObjectsInGet',
      const UnsignedIntNullableConverter().toJson(instance.maxObjectsInGet));
  writeNotNull('maxObjectsInSet',
      const UnsignedIntNullableConverter().toJson(instance.maxObjectsInSet));
  writeNotNull(
      'collationAlgorithms',
      instance.collationAlgorithms
          ?.map(const CollationIdentifierConverter().toJson)
          .toList());
  return val;
}
