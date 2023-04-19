import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_kind.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarAttendeeKindNullableConverter implements JsonConverter<CalendarAttendeeKind?, String?> {
  const CalendarAttendeeKindNullableConverter();

  @override
  CalendarAttendeeKind? fromJson(String? json) => json != null ? CalendarAttendeeKind(json) : null;

  @override
  String? toJson(CalendarAttendeeKind? object) => object?.value;
}