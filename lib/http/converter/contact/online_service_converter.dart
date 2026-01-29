import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/online_service_values.dart';

class OnlineServiceValueConverter {
  MapEntry<String, OnlineServiceValue> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(key, OnlineServiceValue.fromJson(value));
    } else {
      return MapEntry(key, value as OnlineServiceValue);
    }
  }

  MapEntry<String, dynamic> toJson(
    String id,
    OnlineServiceValue value, {
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
  }) {
    final json = value.toVersionedJson(apiVersion);
    return MapEntry(id, json);
  }
}
