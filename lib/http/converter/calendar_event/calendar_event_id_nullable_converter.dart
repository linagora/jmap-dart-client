import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarEventIdNullableConverter implements JsonConverter<CalendarEventId?, String?> {
  const CalendarEventIdNullableConverter();

  @override
  CalendarEventId? fromJson(String? json) => json != null ? CalendarEventId(Id(json)) : null;

  @override
  String? toJson(CalendarEventId? object) => object?.id.value;
}