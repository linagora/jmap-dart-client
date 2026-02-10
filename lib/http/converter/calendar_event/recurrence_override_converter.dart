import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';

class RecurrenceOverridesConverter
    implements JsonConverter<Map<String, PatchObject>?, Map<String, dynamic>?> {
  const RecurrenceOverridesConverter();

  @override
  Map<String, PatchObject>? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return json.map(
      (key, value) => MapEntry(
        key,
        PatchObject(Map<String, dynamic>.from(value as Map)),
      ),
    );
  }

  @override
  Map<String, dynamic>? toJson(Map<String, PatchObject>? overrides) {
    if (overrides == null) return null;

    return overrides.map(
      (key, patch) => MapEntry(
        key,
        patch.toJson(), 
      ),
    );
  }
}
