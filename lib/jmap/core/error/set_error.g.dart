// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetError _$SetErrorFromJson(Map<String, dynamic> json) => SetError(
      ErrorType.fromJson(json['type'] as Map<String, dynamic>),
      description: json['description'] as String?,
      properties: (json['properties'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$SetErrorToJson(SetError instance) => <String, dynamic>{
      'type': instance.type.toJson(),
      'description': instance.description,
      'properties': instance.properties?.toList(),
    };
