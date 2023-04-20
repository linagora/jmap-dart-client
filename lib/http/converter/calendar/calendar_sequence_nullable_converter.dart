import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_sequence.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarSequenceNullableConverter implements JsonConverter<CalendarSequence?, int?> {
  const CalendarSequenceNullableConverter();

  @override
  CalendarSequence? fromJson(int? json) => json != null ? CalendarSequence(json) : null;

  @override
  int? toJson(CalendarSequence? object) => object?.value;
}