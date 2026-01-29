import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';
import 'package:jmap_dart_client/jmap/calendar_event/location_value.dart';
import 'package:jmap_dart_client/http/converter/calendar_event/location_id_converter.dart';

class LocationValueConverter {
  MapEntry<LocationId, LocationValue> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(LocationId(key), LocationValue.fromJson(value));
    } else {
      return MapEntry(LocationId(key), value);
    }
  }

  MapEntry<String, dynamic> toJson(LocationId locationId, LocationValue value) {
    return MapEntry(const LocationIdConverter().toJson(locationId), value.toJson());
  }
}
