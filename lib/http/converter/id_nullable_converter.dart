
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

class IdNullableConverter implements JsonConverter<Id?, String?> {
  const IdNullableConverter();

  @override
  Id? fromJson(String? json) {
    return json != null ? Id(json) : null;
  }

  @override
  String? toJson(Id? object) {
    return object?.value;
  }
}