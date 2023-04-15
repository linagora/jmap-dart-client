// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_body_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailBodyProperties _$EmailBodyPropertiesFromJson(Map<String, dynamic> json) =>
    EmailBodyProperties(
      (json['value'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$EmailBodyPropertiesToJson(
        EmailBodyProperties instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
    };
