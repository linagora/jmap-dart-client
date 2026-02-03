import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/note.dart';

class NoteValueConverter {
  MapEntry<String, Note> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(key, Note.fromJson(value));
    } else {
      return MapEntry(key, value as Note);
    }
  }

  MapEntry<String, dynamic> toJson(
    String id,
    Note value, {
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
  }) {
    final json = value.toVersionedJson(apiVersion);
    return MapEntry(id, json);
  }
}
