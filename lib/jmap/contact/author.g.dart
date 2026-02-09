// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      type: json['type'] as String?,
      name: json['name'] as String?,
      uri: json['uri'] as String?,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'uri': instance.uri,
    };
