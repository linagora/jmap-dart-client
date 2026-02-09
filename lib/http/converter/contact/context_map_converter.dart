import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';
import 'package:json_annotation/json_annotation.dart';

class ContextsMapConverter
    implements JsonConverter<Map<Context, bool>?, Map<String, dynamic>?> {
  const ContextsMapConverter();

  @override
  Map<Context, bool>? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return json.map(
      (key, value) => ContextConverter().parseEntry(key, value as bool),
    );
  }

  @override
  Map<String, dynamic>? toJson(Map<Context, bool>? object) {
    if (object == null) return null;
    return object.map(
      (key, value) => ContextConverter().toJson(key, value),
    );
  }
}