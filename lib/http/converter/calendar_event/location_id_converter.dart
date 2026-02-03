import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';

class LocationIdConverter implements JsonConverter<LocationId, String> {
  const LocationIdConverter();

  @override
  LocationId fromJson(String json) => LocationId(json);

  @override
  String toJson(LocationId object) => object.value;
}


