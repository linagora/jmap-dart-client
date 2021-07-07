import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:json_annotation/json_annotation.dart';

class MethodNameConverter implements JsonConverter<MethodName, String> {
  const MethodNameConverter();

  @override
  MethodName fromJson(String json) => MethodName(json);

  @override
  String toJson(MethodName object) => object.value;
}