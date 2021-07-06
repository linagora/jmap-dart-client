
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

class IdConverter implements JsonConverter<Id, String> {
  const IdConverter();

  @override
  Id fromJson(String json) {
    return Id(json);
  }

  @override
  String toJson(Id object) {
    return object.value;
  }

}