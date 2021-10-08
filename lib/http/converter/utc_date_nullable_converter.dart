import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:json_annotation/json_annotation.dart';

class UTCDateNullableConverter implements JsonConverter<UTCDate?, String?> {
  const UTCDateNullableConverter();

  @override
  UTCDate? fromJson(String? json) => json != null ? UTCDate(DateTime.parse(json).toUtc()) : null;

  @override
  String? toJson(UTCDate? object) => object?.value.toUtc().toIso8601String();
}