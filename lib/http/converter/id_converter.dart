
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/reference_id.dart';
import 'package:json_annotation/json_annotation.dart';

class IdConverter implements JsonConverter<Id, String> {
  const IdConverter();

  @override
  Id fromJson(String json) {
    return Id(json);
  }

  @override
  String toJson(Id object) {
    if (object is ReferenceId) {
      return object.toString();
    } else {
      return object.value;
    }
  }

}