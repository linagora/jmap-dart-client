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
    LanguagePref value) {
    final json = value.toJson();
    return MapEntry(id, json);
  }
}
