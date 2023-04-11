// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryEmailResponse _$QueryEmailResponseFromJson(Map<String, dynamic> json) =>
    QueryEmailResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['queryState'] as String),
      json['canCalculateChanges'] as bool,
      const UnsignedIntConverter().fromJson(json['position'] as int),
      (json['ids'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      const UnsignedIntConverter().fromJson(json['total'] as int),
      const UnsignedIntConverter().fromJson(json['limit'] as int),
    );

Map<String, dynamic> _$QueryEmailResponseToJson(QueryEmailResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'queryState': const StateConverter().toJson(instance.queryState),
      'canCalculateChanges': instance.canCalculateChanges,
      'position': const UnsignedIntConverter().toJson(instance.position),
      'ids': instance.ids.map(const IdConverter().toJson).toList(),
      'total': const UnsignedIntConverter().toJson(instance.total),
      'limit': const UnsignedIntConverter().toJson(instance.limit),
    };
