// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changes_contact_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangesContactResponse _$ChangesContactResponseFromJson(
        Map<String, dynamic> json) =>
    ChangesContactResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['oldState'] as String),
      const StateConverter().fromJson(json['newState'] as String),
      json['hasMoreChanges'] as bool,
      (json['created'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      (json['updated'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      (json['destroyed'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      apiVersion:
          $enumDecodeNullable(_$ContactApiVersionEnumMap, json['apiVersion']) ??
              ContactApiVersion.ietf,
      updatedProperties: const PropertiesConverter()
          .fromJson(json['updatedProperties'] as List<String>?),
    );

Map<String, dynamic> _$ChangesContactResponseToJson(
        ChangesContactResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'oldState': const StateConverter().toJson(instance.oldState),
      'newState': const StateConverter().toJson(instance.newState),
      'hasMoreChanges': instance.hasMoreChanges,
      'created': instance.created.map(const IdConverter().toJson).toList(),
      'updated': instance.updated.map(const IdConverter().toJson).toList(),
      'destroyed': instance.destroyed.map(const IdConverter().toJson).toList(),
      'updatedProperties':
          const PropertiesConverter().toJson(instance.updatedProperties),
      'apiVersion': _$ContactApiVersionEnumMap[instance.apiVersion]!,
    };

const _$ContactApiVersionEnumMap = {
  ContactApiVersion.jscontact: 'jscontact',
  ContactApiVersion.cyrus: 'cyrus',
  ContactApiVersion.ietf: 'ietf',
};
