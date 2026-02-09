// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniversary_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnniversaryValue _$AnniversaryValueFromJson(Map<String, dynamic> json) =>
    AnniversaryValue(
      type: json['type'] as String? ?? 'Anniversary',
      kind: json['kind'] as String?,
      date: json['date'],
      anniversaryType: json['anniversaryType'] as String?,
      place: json['place'] == null
          ? null
          : AnniversaryPlace.fromJson(json['place'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnniversaryValueToJson(AnniversaryValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('kind', instance.kind);
  writeNotNull('date', instance.date);
  writeNotNull('anniversaryType', instance.anniversaryType);
  writeNotNull('place', instance.place);
  return val;
}
