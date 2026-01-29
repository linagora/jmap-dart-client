import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/language_preference.dart';

class LanguagePrefConverter {
  MapEntry<String, LanguagePref> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(key, LanguagePref.fromJson(value));
    } else {
      return MapEntry(key, value as LanguagePref);
    }
  }

  MapEntry<String, dynamic> toJson(
    String id,
    LanguagePref value, {
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
  }) {
    final json = value.toVersionedJson(apiVersion);
    return MapEntry(id, json);
  }
}
