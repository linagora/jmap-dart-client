
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';
import 'package:json_annotation/json_annotation.dart';

class MethodResponseConverter implements JsonConverter<MethodResponse, dynamic> {
  const MethodResponseConverter();

  @override
  MethodResponse fromJson(dynamic json) {
    return fromJson(json);
  }

  @override
  dynamic toJson(MethodResponse object) {
    return object;
  }
}