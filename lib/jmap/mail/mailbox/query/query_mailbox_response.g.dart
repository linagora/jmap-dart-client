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
      _$JsonConverterFromJson<int, UnsignedInt>(
          json['total'], const UnsignedIntConverter().fromJson),
      _$JsonConverterFromJson<int, UnsignedInt>(
          json['limit'], const UnsignedIntConverter().fromJson),
    );

Map<String, dynamic> _$QueryMailboxResponseToJson(
        QueryMailboxResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'queryState': const StateConverter().toJson(instance.queryState),
      'canCalculateChanges': instance.canCalculateChanges,
      'position': const UnsignedIntConverter().toJson(instance.position),
      'ids': instance.ids.map(const IdConverter().toJson).toList(),
      'total': _$JsonConverterToJson<int, UnsignedInt>(
          instance.total, const UnsignedIntConverter().toJson),
      'limit': _$JsonConverterToJson<int, UnsignedInt>(
          instance.limit, const UnsignedIntConverter().toJson),
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
