// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_email_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEmailMethod _$GetEmailMethodFromJson(Map<String, dynamic> json) =>
    GetEmailMethod(
      const AccountIdConverter().fromJson(json['accountId'] as String),
    )
      ..blobIds =
          (json['blobIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..ids = (json['ids'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toSet()
      ..referenceIds = json['#ids'] == null
          ? null
          : ResultReference.fromJson(json['#ids'] as Map<String, dynamic>)
      ..properties = const PropertiesConverter()
          .fromJson(json['properties'] as List<String>?)
      ..referenceProperties = json['#properties'] == null
          ? null
          : ResultReference.fromJson(
              json['#properties'] as Map<String, dynamic>)
      ..bodyProperties = json['bodyProperties'] == null
          ? null
          : EmailBodyProperties.fromJson(
              json['bodyProperties'] as Map<String, dynamic>)
      ..fetchTextBodyValues = json['fetchTextBodyValues'] as bool?
      ..fetchHTMLBodyValues = json['fetchHTMLBodyValues'] as bool?
      ..fetchAllBodyValues = json['fetchAllBodyValues'] as bool?
      ..maxBodyValueBytes = const UnsignedIntNullableConverter()
          .fromJson(json['maxBodyValueBytes'] as int?);

Map<String, dynamic> _$GetEmailMethodToJson(GetEmailMethod instance) {
  final val = <String, dynamic>{
    'accountId': const AccountIdConverter().toJson(instance.accountId),
    'blobIds': instance.blobIds,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ids', instance.ids?.map(const IdConverter().toJson).toList());
  writeNotNull('#ids', instance.referenceIds?.toJson());
  writeNotNull(
      'properties', const PropertiesConverter().toJson(instance.properties));
  writeNotNull('#properties', instance.referenceProperties?.toJson());
  writeNotNull('bodyProperties', instance.bodyProperties?.toJson());
  writeNotNull('fetchTextBodyValues', instance.fetchTextBodyValues);
  writeNotNull('fetchHTMLBodyValues', instance.fetchHTMLBodyValues);
  writeNotNull('fetchAllBodyValues', instance.fetchAllBodyValues);
  writeNotNull('maxBodyValueBytes',
      const UnsignedIntNullableConverter().toJson(instance.maxBodyValueBytes));
  return val;
}
