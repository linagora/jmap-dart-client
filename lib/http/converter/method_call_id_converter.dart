import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:json_annotation/json_annotation.dart';

class MethodCallIdConverter implements JsonConverter<MethodCallId, String> {
  const MethodCallIdConverter();

  @override
  MethodCallId fromJson(String json) => MethodCallId(json);

  @override
  String toJson(MethodCallId object) => object.value;
}