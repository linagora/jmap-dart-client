// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_mailbox_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryMailboxResponse _$QueryMailboxResponseFromJson(
        Map<String, dynamic> json) =>
    QueryMailboxResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['queryState'] as String),
      json['canCalculateChanges'] as bool,
      const UnsignedIntConverter().fromJson(json['position'] as int),
      (json['ids'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      const UnsignedIntNullableConverter().fromJson(json['total'] as int?),
      const UnsignedIntNullableConverter().fromJson(json['limit'] as int?),
    );

Map<String, dynamic> _$QueryMailboxResponseToJson(
        QueryMailboxResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'queryState': const StateConverter().toJson(instance.queryState),
      'canCalculateChanges': instance.canCalculateChanges,
      'position': const UnsignedIntConverter().toJson(instance.position),
      'ids': instance.ids.map(const IdConverter().toJson).toList(),
      'total': const UnsignedIntNullableConverter().toJson(instance.total),
      'limit': const UnsignedIntNullableConverter().toJson(instance.limit),
    };
