// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_overrides.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceOverrides _$RecurrenceOverridesFromJson(Map<String, dynamic> json) =>
    RecurrenceOverrides(
      (json['overrides'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, PatchObject.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$RecurrenceOverridesToJson(
        RecurrenceOverrides instance) =>
    <String, dynamic>{
      'overrides': instance.overrides,
    };
