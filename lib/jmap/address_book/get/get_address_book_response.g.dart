// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_address_book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAddressBookResponse _$GetAddressBookResponseFromJson(
        Map<String, dynamic> json) =>
    GetAddressBookResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      _$JsonConverterFromJson<String, State>(
          json['state'], const StateConverter().fromJson),
      (json['list'] as List<dynamic>?)
          ?.map((e) => AddressBook.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$GetAddressBookResponseToJson(
        GetAddressBookResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'state': const StateConverter().toJson(instance.state),
      'list': instance.list,
      'notFound': instance.notFound?.map(const IdConverter().toJson).toList(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
