// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_calendar_event_attendance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCalendarEventAttendanceResponse _$GetCalendarEventAttendanceResponseFromJson(
        Map<String, dynamic> json) =>
    GetCalendarEventAttendanceResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      (json['list'] as List<dynamic>)
          .map((e) =>
              CalendarEventAttendance.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
      _$JsonConverterFromJson<Map<String, dynamic>, Map<Id, SetError>>(
          json['notDone'], const SetErrorConverter().fromJson),
    );

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
