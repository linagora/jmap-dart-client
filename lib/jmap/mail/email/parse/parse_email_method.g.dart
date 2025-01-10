// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parse_email_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParseEmailMethod _$ParseEmailMethodFromJson(Map<String, dynamic> json) =>
    ParseEmailMethod(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      (json['blobIds'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
    )
      ..properties = const PropertiesConverter()
          .fromJson(json['properties'] as List<String>?)
      ..bodyProperties = json['bodyProperties'] == null
          ? null
          : EmailBodyProperties.fromJson(
              json['bodyProperties'] as Map<String, dynamic>)
      ..fetchTextBodyValues = json['fetchTextBodyValues'] as bool?
      ..fetchHTMLBodyValues = json['fetchHTMLBodyValues'] as bool?
      ..fetchAllBodyValues = json['fetchAllBodyValues'] as bool?
      ..maxBodyValueBytes = const UnsignedIntNullableConverter()
          .fromJson(json['maxBodyValueBytes'] as int?);

Map<String, dynamic> _$ParseEmailMethodToJson(ParseEmailMethod instance) {
  final val = <String, dynamic>{
    'accountId': const AccountIdConverter().toJson(instance.accountId),
    'blobIds': instance.blobIds.map(const IdConverter().toJson).toList()
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'properties', const PropertiesConverter().toJson(instance.properties));
  writeNotNull('bodyProperties', instance.bodyProperties?.toJson());
  writeNotNull('fetchTextBodyValues', instance.fetchTextBodyValues);
  writeNotNull('fetchHTMLBodyValues', instance.fetchHTMLBodyValues);
  writeNotNull('fetchAllBodyValues', instance.fetchAllBodyValues);
  writeNotNull('maxBodyValueBytes',
      const UnsignedIntNullableConverter().toJson(instance.maxBodyValueBytes));
  return val;
}
