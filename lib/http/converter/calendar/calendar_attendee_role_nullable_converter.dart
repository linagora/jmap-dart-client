import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_role.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarAttendeeRoleNullableConverter implements JsonConverter<CalendarAttendeeRole?, String?> {
  const CalendarAttendeeRoleNullableConverter();

  @override
  CalendarAttendeeRole? fromJson(String? json) => json != null ? CalendarAttendeeRole(json) : null;

  @override
  String? toJson(CalendarAttendeeRole? object) => object?.value;
}