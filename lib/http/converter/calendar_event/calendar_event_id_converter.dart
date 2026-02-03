import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarEventIdConverter implements JsonConverter<CalendarEventId, String> {
  const CalendarEventIdConverter();

  @override
  CalendarEventId fromJson(String json) => CalendarEventId(Id(json));

  @override
  String toJson(CalendarEventId object) => object.id.value;
}