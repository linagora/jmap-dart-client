
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:json_annotation/json_annotation.dart';

class PropertiesConverter implements JsonConverter<Properties?, List<String>?> {
  const PropertiesConverter();

  @override
  Properties? fromJson(List<String>? json) {
    return json != null ? Properties(json.toSet()) : null;
  }

  @override
  List<String>? toJson(Properties? object) {
    if (object == null) {
      return null;
    }

    if (object.value.isEmpty) {
      return null;
    }

    return object.value.toList();
  }
}