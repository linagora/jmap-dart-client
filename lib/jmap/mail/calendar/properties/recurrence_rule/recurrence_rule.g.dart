// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceRule _$RecurrenceRuleFromJson(Map<String, dynamic> json) =>
    RecurrenceRule(
      frequency: $enumDecodeNullable(
          _$RecurrenceRuleFrequencyEnumMap, json['frequency']),
      interval: const RecurrenceRuleIntervalNullableConverter()
          .fromJson(json['interval'] as int?),
      rscale: const RecurrenceRuleRScaleNullableConverter()
          .fromJson(json['rscale'] as String?),
      skip: $enumDecodeNullable(_$RecurrenceRuleSkipEnumMap, json['skip']),
      firstDayOfWeek:
          $enumDecodeNullable(_$DayOfWeekEnumMap, json['firstDayOfWeek']),
      byDay: (json['byDay'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DayOfWeekEnumMap, e))
          .toList(),
      byMonthDay:
          (json['byMonthDay'] as List<dynamic>?)?.map((e) => e as int).toList(),
      byMonth:
          (json['byMonth'] as List<dynamic>?)?.map((e) => e as String).toList(),
      byYearDay:
          (json['byYearDay'] as List<dynamic>?)?.map((e) => e as int).toList(),
      byWeekNo:
          (json['byWeekNo'] as List<dynamic>?)?.map((e) => e as int).toList(),
      byHour: (json['byHour'] as List<dynamic>?)
          ?.map((e) => const UnsignedIntConverter().fromJson(e as int))
          .toList(),
      byMinute: (json['byMinute'] as List<dynamic>?)
          ?.map((e) => const UnsignedIntConverter().fromJson(e as int))
          .toList(),
      bySecond: (json['bySecond'] as List<dynamic>?)
          ?.map((e) => const UnsignedIntConverter().fromJson(e as int))
          .toList(),
      bySetPosition: (json['bySetPosition'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      count: const RecurrenceRuleCountNullableConverter()
          .fromJson(json['count'] as int?),
      until:
          const UTCDateNullableConverter().fromJson(json['until'] as String?),
    );

Map<String, dynamic> _$RecurrenceRuleToJson(RecurrenceRule instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'frequency', _$RecurrenceRuleFrequencyEnumMap[instance.frequency]);
  writeNotNull(
      'interval',
      const RecurrenceRuleIntervalNullableConverter()
          .toJson(instance.interval));
  writeNotNull('rscale',
      const RecurrenceRuleRScaleNullableConverter().toJson(instance.rscale));
  writeNotNull('skip', _$RecurrenceRuleSkipEnumMap[instance.skip]);
  writeNotNull('firstDayOfWeek', _$DayOfWeekEnumMap[instance.firstDayOfWeek]);
  writeNotNull(
      'byDay', instance.byDay?.map((e) => _$DayOfWeekEnumMap[e]!).toList());
  writeNotNull('byMonthDay', instance.byMonthDay);
  writeNotNull('byMonth', instance.byMonth);
  writeNotNull('byYearDay', instance.byYearDay);
  writeNotNull('byWeekNo', instance.byWeekNo);
  writeNotNull('byHour',
      instance.byHour?.map(const UnsignedIntConverter().toJson).toList());
  writeNotNull('byMinute',
      instance.byMinute?.map(const UnsignedIntConverter().toJson).toList());
  writeNotNull('bySecond',
      instance.bySecond?.map(const UnsignedIntConverter().toJson).toList());
  writeNotNull('bySetPosition', instance.bySetPosition);
  writeNotNull('count',
      const RecurrenceRuleCountNullableConverter().toJson(instance.count));
  writeNotNull(
      'until', const UTCDateNullableConverter().toJson(instance.until));
  return val;
}

const _$RecurrenceRuleFrequencyEnumMap = {
  RecurrenceRuleFrequency.yearly: 'yearly',
  RecurrenceRuleFrequency.monthly: 'monthly',
  RecurrenceRuleFrequency.weekly: 'weekly',
  RecurrenceRuleFrequency.daily: 'daily',
  RecurrenceRuleFrequency.hourly: 'hourly',
  RecurrenceRuleFrequency.minutely: 'minutely',
  RecurrenceRuleFrequency.secondly: 'secondly',
};

const _$RecurrenceRuleSkipEnumMap = {
  RecurrenceRuleSkip.omit: 'omit',
  RecurrenceRuleSkip.backward: 'backward',
  RecurrenceRuleSkip.forward: 'forward',
};

const _$DayOfWeekEnumMap = {
  DayOfWeek.monday: 'mo',
  DayOfWeek.tuesday: 'tu',
  DayOfWeek.wednesday: 'we',
  DayOfWeek.thursday: 'th',
  DayOfWeek.friday: 'fr',
  DayOfWeek.saturday: 'sa',
  DayOfWeek.sunday: 'su',
};
