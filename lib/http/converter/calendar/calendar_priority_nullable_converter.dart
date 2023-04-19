import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_priority.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarPriorityNullableConverter implements JsonConverter<CalendarPriority?, int?> {
  const CalendarPriorityNullableConverter();

  @override
  CalendarPriority? fromJson(int? json) => json != null ? CalendarPriority(json) : null;

  @override
  int? toJson(CalendarPriority? object) => object?.value;
}