// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationValue _$LocationValueFromJson(Map<String, dynamic> json) =>
    LocationValue(
      type: json['@type'] as String? ?? 'Location',
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LocationValueToJson(LocationValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('name', instance.name);
  return val;
}
