// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parse_calender_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParseCalenderResponse _$ParseCalenderResponseFromJson(
        Map<String, dynamic> json) =>
    ParseCalenderResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const ParsedConverter().fromJson(json['parsed'] as Map<String, dynamic>),
      _$JsonConverterFromJson<Map<String, dynamic>, Parsed>(
          json['notFound'], const ParsedConverter().fromJson),
    );

Map<String, dynamic> _$ParseCalenderResponseToJson(
        ParseCalenderResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'parsed': const ParsedConverter().toJson(instance.parsed),
      'notFound': _$JsonConverterToJson<Map<String, dynamic>, Parsed>(
          instance.notFound, const ParsedConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
