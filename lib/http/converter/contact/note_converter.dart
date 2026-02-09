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
    Note value) {
    final json = value.toJson();
    return MapEntry(id, json);
  }
}
