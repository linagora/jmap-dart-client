import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';

class AlertIdConverter implements JsonConverter<AlertId, String> {
  const AlertIdConverter();

  @override
  AlertId fromJson(String json) => AlertId(json);

  @override
  String toJson(AlertId object) => object.value;
}


