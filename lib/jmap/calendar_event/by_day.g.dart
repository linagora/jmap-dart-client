// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'by_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ByDay _$ByDayFromJson(Map<String, dynamic> json) => ByDay(
      type: json['@type'] as String?,
      day: json['day'] as String?,
    );

Map<String, dynamic> _$ByDayToJson(ByDay instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('day', instance.day);
  return val;
}
