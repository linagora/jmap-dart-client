// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestObject _$RequestObjectFromJson(Map<String, dynamic> json) =>
    RequestObject(
      (json['using'] as List<dynamic>)
          .map((e) =>
              const CapabilityIdentifierConverter().fromJson(e as String))
          .toSet(),
      (json['methodCalls'] as List<dynamic>)
          .map((e) => const RequestInvocationConverter().fromJson(e as List))
          .toList(),
    );

Map<String, dynamic> _$RequestObjectToJson(RequestObject instance) =>
    <String, dynamic>{
      'using': instance.using
          .map(const CapabilityIdentifierConverter().toJson)
          .toList(),
      'methodCalls': instance.methodCalls
          .map(const RequestInvocationConverter().toJson)
          .toList(),
    };
