// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parse_calender_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParseCalenderMethod _$ParseCalenderMethodFromJson(Map<String, dynamic> json) =>
    ParseCalenderMethod(
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
      ..maxBodyValueBytes = const UnsignedIntNullableConverter()
          .fromJson(json['maxBodyValueBytes'] as int?)
      ..referenceProperties = json['#properties'] == null
          ? null
          : ResultReference.fromJson(
              json['#properties'] as Map<String, dynamic>);

Map<String, dynamic> _$ParseCalenderMethodToJson(ParseCalenderMethod instance) {
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
  writeNotNull('#ids', instance.referenceIds);
  writeNotNull(
      'properties', const PropertiesConverter().toJson(instance.properties));
  writeNotNull('maxBodyValueBytes',
      const UnsignedIntNullableConverter().toJson(instance.maxBodyValueBytes));
  writeNotNull('#properties', instance.referenceProperties);
  return val;
}
