import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_duration.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarDurationNullableConverter implements JsonConverter<CalendarDuration?, String?> {
  const CalendarDurationNullableConverter();

  @override
  CalendarDuration? fromJson(String? json) => json != null ? CalendarDuration(json) : null;

  @override
  String? toJson(CalendarDuration? object) => object?.value;
}