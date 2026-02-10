// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceRules _$RecurrenceRulesFromJson(Map<String, dynamic> json) =>
    RecurrenceRules(
      frequency: json['frequency'] as String?,
      type: json['@type'] as String? ?? 'RecurrenceRule',
      interval: json['interval'] as int?,
      count: json['count'] as int?,
      byDay: (json['byDay'] as List<dynamic>?)
          ?.map((e) => ByDay.fromJson(e as Map<String, dynamic>))
          .toSet(),
      byMonth:
          (json['byMonth'] as List<dynamic>?)?.map((e) => e as int).toList(),
      bySetPosition: (json['bySetPosition'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      until: json['until'] as String?,
    );

Map<String, dynamic> _$RecurrenceRulesToJson(RecurrenceRules instance) {
  final val = <String, dynamic>{
    'frequency': instance.frequency,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('interval', instance.interval);
  writeNotNull('count', instance.count);
  writeNotNull('byDay', instance.byDay?.map((e) => e.toJson()).toList());
  writeNotNull('byMonth', instance.byMonth);
  writeNotNull('bySetPosition', instance.bySetPosition);
  writeNotNull('until', instance.until);
  return val;
}
