import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/calendar_event/role.dart';

class RoleMapConverter
    implements JsonConverter<Map<Role, bool>?, Map<String, dynamic>?> {
  const RoleMapConverter();

  @override
  Map<Role, bool>? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return json.map<Role, bool>((key, value) {
      return MapEntry(Role(key as String), value as bool);
    });
  }

  @override
  Map<String, dynamic>? toJson(Map<Role, bool>? object) {
    if (object == null) return null;

    return object.map<String, dynamic>((key, value) {
      return MapEntry(key.value, value);
    });
  }
}
