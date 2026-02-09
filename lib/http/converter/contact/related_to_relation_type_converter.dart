import 'package:json_annotation/json_annotation.dart';

class RelationTypeConverter
    implements JsonConverter<Map<String, bool>?, Map<String, dynamic>?> {
  const RelationTypeConverter();

  @override
  Map<String, bool>? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return json.map((k, v) => MapEntry(k, v as bool));
  }

  @override
  Map<String, dynamic>? toJson(Map<String, bool>? object) {
    if (object == null) return null;
    return Map<String, dynamic>.from(object);
  }
}
