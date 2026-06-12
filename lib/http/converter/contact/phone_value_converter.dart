import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/contact_id.dart';
import 'package:jmap_dart_client/jmap/contact/phone_value.dart';


class PhoneValueConverter {
  MapEntry<String, dynamic> toJson(
    PhoneId id,
    PhoneValue value, {
    required ContactApiVersion apiVersion,
  }) {
    return MapEntry(id.value, value.toVersionedJson(apiVersion));
  }

  MapEntry<PhoneId, PhoneValue> parseEntry(String key, dynamic raw) {
    final json = raw as Map<String, dynamic>;
    return MapEntry(PhoneId(key), PhoneValue.fromJson(json));
  }
}

