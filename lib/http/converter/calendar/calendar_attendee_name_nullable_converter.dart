import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_name.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarAttendeeNameNullableConverter implements JsonConverter<CalendarAttendeeName?, String?> {
  const CalendarAttendeeNameNullableConverter();

  @override
  CalendarAttendeeName? fromJson(String? json) => json != null ? CalendarAttendeeName(json) : null;

  @override
  String? toJson(CalendarAttendeeName? object) => object?.name;
}