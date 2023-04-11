// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseObject _$ResponseObjectFromJson(Map<String, dynamic> json) =>
    ResponseObject(
      (json['methodResponses'] as List<dynamic>)
          .map((e) => const ResponseInvocationConverter().fromJson(e as List))
          .toList(),
      const StateConverter().fromJson(json['sessionState'] as String),
    );

Map<String, dynamic> _$ResponseObjectToJson(ResponseObject instance) =>
    <String, dynamic>{
      'methodResponses': instance.methodResponses
          .map(const ResponseInvocationConverter().toJson)
          .toList(),
      'sessionState': const StateConverter().toJson(instance.sessionState),
    };
