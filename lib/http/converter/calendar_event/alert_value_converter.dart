import 'package:jmap_dart_client/jmap/calendar_event/alert_value.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';
import 'package:jmap_dart_client/http/converter/calendar_event/alert_id_converter.dart';



class AlertValueConverter {
  MapEntry<AlertId, AlertValue> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(AlertId(key), AlertValue.fromJson(value));
    } else {
      return MapEntry(AlertId(key), value);
    }
  }

  MapEntry<String, dynamic> toJson(AlertId alertId, AlertValue value) {
    return MapEntry(const AlertIdConverter().toJson(alertId), value.toJson());
  }
}
