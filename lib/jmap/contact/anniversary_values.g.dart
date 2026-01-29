// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniversary_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnniversaryValue _$AnniversaryValueFromJson(Map<String, dynamic> json) =>
    AnniversaryValue(
      anniversaryType: json['anniversaryType'] as String?,
      type: json['type'] as String?,
      kind: json['kind'] as String?,
      place: json['place'] == null
          ? null
          : AnniversaryPlace.fromJson(json['place'] as Map<String, dynamic>),
      date: json['date'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$AnniversaryValueToJson(AnniversaryValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('anniversaryType', instance.anniversaryType);
  writeNotNull('kind', instance.kind);
  writeNotNull('type', instance.type);
  writeNotNull('date', instance.date);
  val['place'] = instance.place;
  writeNotNull('label', instance.label);
  return val;
}
