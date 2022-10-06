import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';

class SetErrorConverter {
  MapEntry<Id, SetError> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(Id(key), SetError.fromJson(value));
    } else {
      return MapEntry(Id(key), value);
    }
  }
}
