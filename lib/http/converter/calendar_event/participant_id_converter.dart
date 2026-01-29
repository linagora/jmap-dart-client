import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';

class ParticipantIdConverter implements JsonConverter<ParticipantId, String> {
  const ParticipantIdConverter();

  @override
  ParticipantId fromJson(String json) => ParticipantId(json);

  @override
  String toJson(ParticipantId object) => object.value;
}


