// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_contact_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetContactResponse _$GetContactResponseFromJson(Map<String, dynamic> json) =>
    GetContactResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['state'] as String),
      (json['list'] as List<dynamic>)
          .map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
      apiVersion:
          $enumDecodeNullable(_$ContactApiVersionEnumMap, json['apiVersion']) ??
              ContactApiVersion.jscontact,
    );

Map<String, dynamic> _$GetContactResponseToJson(GetContactResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'state': const StateConverter().toJson(instance.state),
      'list': instance.list,
      'notFound': instance.notFound?.map(const IdConverter().toJson).toList(),
      'apiVersion': _$ContactApiVersionEnumMap[instance.apiVersion]!,
    };

const _$ContactApiVersionEnumMap = {
  ContactApiVersion.jscontact: 'jscontact',
  ContactApiVersion.cyrus: 'cyrus',
  ContactApiVersion.ietf: 'ietf',
};
