// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_respond.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedRespond _$ParsedRespondFromJson(Map<String, dynamic> json) =>
    ParsedRespond(
      accountId: json['accountId'] == null
          ? null
          : AccountId.fromJson(json['accountId'] as Map<String, dynamic>),
      parsed: json['parsed'] == null
          ? null
          : Parsed.fromJson(json['parsed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParsedRespondToJson(ParsedRespond instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'parsed': instance.parsed,
    };
