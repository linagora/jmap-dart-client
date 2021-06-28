import 'package:jmap_dart_client/jmap/core/request/reference_path.dart';
import 'package:json_annotation/json_annotation.dart';

class ReferencePathConverter implements JsonConverter<ReferencePath, String> {
  const ReferencePathConverter();

  @override
  ReferencePath fromJson(String json) => ReferencePath(json);

  @override
  String toJson(ReferencePath object) => object.value;
}