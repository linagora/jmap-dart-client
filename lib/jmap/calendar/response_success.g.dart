// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_success.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSuccess _$ResponseSuccessFromJson(Map<String, dynamic> json) =>
    ResponseSuccess(
      accountId: json['accountId'] == null
          ? null
          : AccountId.fromJson(json['accountId'] as Map<String, dynamic>),
      parsed: json['parsed'] == null
          ? null
          : Parsed.fromJson(json['parsed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseSuccessToJson(ResponseSuccess instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'parsed': instance.parsed,
    };
