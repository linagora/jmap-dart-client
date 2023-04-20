import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_id.dart';
import 'package:json_annotation/json_annotation.dart';

class EventIdNullableConverter implements JsonConverter<EventId?, String?> {
  const EventIdNullableConverter();

  @override
  EventId? fromJson(String? json) => json != null ? EventId(json) : null;

  @override
  String? toJson(EventId? object) => object?.id;
}