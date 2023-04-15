// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceRules _$RecurrenceRulesFromJson(Map<String, dynamic> json) =>
    RecurrenceRules(
      frequency: json['frequency'] as String?,
      byDay:
          (json['byDay'] as List<dynamic>?)?.map((e) => e as String).toList(),
      byMonth:
          (json['byMonth'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bySetPosition: (json['bySetPosition'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      until: json['until'] as String?,
    );

Map<String, dynamic> _$RecurrenceRulesToJson(RecurrenceRules instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'byDay': instance.byDay,
      'byMonth': instance.byMonth,
      'bySetPosition': instance.bySetPosition,
      'until': instance.until,
    };
