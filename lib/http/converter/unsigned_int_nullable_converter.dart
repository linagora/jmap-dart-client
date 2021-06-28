import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

class UnsignedIntNullableConverter implements JsonConverter<UnsignedInt?, int?> {
  const UnsignedIntNullableConverter();

  @override
  UnsignedInt? fromJson(int? json) {
    return json != null ? UnsignedInt(json) : null;
  }

  @override
  int? toJson(UnsignedInt? object) {
    return object?.value.toInt();
  }
}