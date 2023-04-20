import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_participation_status.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarAttendeeParticipationStatusNullableConverter implements JsonConverter<CalendarAttendeeParticipationStatus?, String?> {
  const CalendarAttendeeParticipationStatusNullableConverter();

  @override
  CalendarAttendeeParticipationStatus? fromJson(String? json) => json != null ? CalendarAttendeeParticipationStatus(json) : null;

  @override
  String? toJson(CalendarAttendeeParticipationStatus? object) => object?.value;
}