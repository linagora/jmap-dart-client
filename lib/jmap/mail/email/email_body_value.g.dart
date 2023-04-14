// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_body_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailBodyValue _$EmailBodyValueFromJson(Map<String, dynamic> json) =>
    EmailBodyValue(
      json['value'] as String,
      json['isEncodingProblem'] as bool,
      json['isTruncated'] as bool,
    );

Map<String, dynamic> _$EmailBodyValueToJson(EmailBodyValue instance) =>
    <String, dynamic>{
      'value': instance.value,
      'isEncodingProblem': instance.isEncodingProblem,
      'isTruncated': instance.isTruncated,
    };
