
import 'package:jmap_dart_client/jmap/core/error/error_type.dart';
import 'package:json_annotation/json_annotation.dart';

class ErrorTypeConverter implements JsonConverter<ErrorType, String> {
  const ErrorTypeConverter();

  @override
  ErrorType fromJson(String json) => ErrorType(json);

  @override
  String toJson(ErrorType object) => object.value;
}