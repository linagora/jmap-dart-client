import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_expect_reply.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarAttendeeExpectReplyNullableConverter implements JsonConverter<CalendarAttendeeExpectReply?, bool?> {
  const CalendarAttendeeExpectReplyNullableConverter();

  @override
  CalendarAttendeeExpectReply? fromJson(bool? json) => json != null ? CalendarAttendeeExpectReply(json) : null;

  @override
  bool? toJson(CalendarAttendeeExpectReply? object) => object?.value;
}