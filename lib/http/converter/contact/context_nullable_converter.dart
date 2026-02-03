import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';

class ContextValueNullableConverter implements JsonConverter<Context?, String?> {
  const ContextValueNullableConverter();

  @override
  Context? fromJson(String? json) => json != null ? Context(json) : null;

  @override
  String? toJson(Context? object) => object?.value;
}