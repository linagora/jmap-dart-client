// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_stamp_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimestampDate _$TimestampDateFromJson(Map<String, dynamic> json) =>
    TimestampDate(
      type: json['type'] as String? ?? 'Timestamp',
      utc: json['utc'] as String,
    );

Map<String, dynamic> _$TimestampDateToJson(TimestampDate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  val['utc'] = instance.utc;
  return val;
}
