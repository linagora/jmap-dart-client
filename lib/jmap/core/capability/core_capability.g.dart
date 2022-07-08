// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoreCapability _$CoreCapabilityFromJson(Map<String, dynamic> json) =>
    CoreCapability(
      const UnsignedIntConverter().fromJson(json['maxSizeUpload'] as int),
      const UnsignedIntConverter().fromJson(json['maxConcurrentUpload'] as int),
      const UnsignedIntConverter().fromJson(json['maxSizeRequest'] as int),
      const UnsignedIntConverter()
          .fromJson(json['maxConcurrentRequests'] as int),
      const UnsignedIntConverter().fromJson(json['maxCallsInRequest'] as int),
      const UnsignedIntConverter().fromJson(json['maxObjectsInGet'] as int),
      const UnsignedIntConverter().fromJson(json['maxObjectsInSet'] as int),
      (json['collationAlgorithms'] as List<dynamic>)
          .map(
              (e) => const CollationIdentifierConverter().fromJson(e as String))
          .toSet(),
    );

Map<String, dynamic> _$CoreCapabilityToJson(CoreCapability instance) =>
    <String, dynamic>{
      'maxSizeUpload':
          const UnsignedIntConverter().toJson(instance.maxSizeUpload),
      'maxConcurrentUpload':
          const UnsignedIntConverter().toJson(instance.maxConcurrentUpload),
      'maxSizeRequest':
          const UnsignedIntConverter().toJson(instance.maxSizeRequest),
      'maxConcurrentRequests':
          const UnsignedIntConverter().toJson(instance.maxConcurrentRequests),
      'maxCallsInRequest':
          const UnsignedIntConverter().toJson(instance.maxCallsInRequest),
      'maxObjectsInGet':
          const UnsignedIntConverter().toJson(instance.maxObjectsInGet),
      'maxObjectsInSet':
          const UnsignedIntConverter().toJson(instance.maxObjectsInSet),
      'collationAlgorithms': instance.collationAlgorithms
          .map(const CollationIdentifierConverter().toJson)
          .toList(),
    };
