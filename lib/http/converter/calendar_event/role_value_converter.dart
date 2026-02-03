import 'package:jmap_dart_client/jmap/calendar_event/role.dart';

class RoleConverter {
  MapEntry<Role, bool> parseEntry(String key, bool value) => MapEntry(Role(key), value);

  MapEntry<String, bool> toJson(Role context, bool value) => MapEntry(context.value, value);
}

