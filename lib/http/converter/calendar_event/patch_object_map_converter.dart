import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';

class PatchObjectMapConverter
    implements JsonConverter<Map<String, PatchObject>, Map<String, dynamic>> {
  const PatchObjectMapConverter();

  @override
  Map<String, PatchObject> fromJson(Map<String, dynamic> json) {
    return json.map(
      (key, value) =>
          MapEntry(key, PatchObject(value as Map<String, dynamic>)),
    );
  }

  @override
  Map<String, dynamic> toJson(Map<String, PatchObject> object) {
    return object.map(
      (key, value) => MapEntry(key, value.toJson()),
    );
  }
}
