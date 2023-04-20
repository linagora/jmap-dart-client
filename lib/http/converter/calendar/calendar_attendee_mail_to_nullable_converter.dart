import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_mail_to.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/mail_address.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarAttendeeMailToNullableConverter implements JsonConverter<CalendarAttendeeMailTo?, String?> {
  const CalendarAttendeeMailToNullableConverter();

  @override
  CalendarAttendeeMailTo? fromJson(String? json) => json != null ? CalendarAttendeeMailTo(MailAddress(json)) : null;

  @override
  String? toJson(CalendarAttendeeMailTo? object) => object?.mailAddress.value;
}