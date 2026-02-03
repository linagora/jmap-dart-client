// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialDate _$PartialDateFromJson(Map<String, dynamic> json) => PartialDate(
      type: json['type'] as String? ?? 'PartialDate',
      year: json['year'] as int?,
      month: json['month'] as int?,
      day: json['day'] as int?,
    );

Map<String, dynamic> _$PartialDateToJson(PartialDate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('year', instance.year);
  writeNotNull('month', instance.month);
  writeNotNull('day', instance.day);
  return val;
}
