import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/file_node/files_rights.dart';

class FilesRightsMapConverter
    implements JsonConverter<Map<String, FilesRights>?, Map<String, dynamic>?> {
  const FilesRightsMapConverter();

  @override
  Map<String, FilesRights>? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return json.map(
      (key, value) =>
          MapEntry(key, FilesRights.fromJson(value as Map<String, dynamic>)),
    );
  }

  @override
  Map<String, dynamic>? toJson(Map<String, FilesRights>? object) {
    if (object == null) return null;
    return object.map(
      (key, value) => MapEntry(key, value.toJson()),
    );
  }
}
