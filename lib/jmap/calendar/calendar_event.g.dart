// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) =>
    CalendarEvent(
      accountId: json['accountId'] as String?,
      parsed: json['parsed'] == null
          ? null
          : Parsed.fromJson(json['parsed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'parsed': instance.parsed,
    };
