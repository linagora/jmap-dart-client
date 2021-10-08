import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:json_annotation/json_annotation.dart';

class UTCDateConverter implements JsonConverter<UTCDate, String> {
  const UTCDateConverter();

  @override
  UTCDate fromJson(String json) => UTCDate(DateTime.parse(json).toUtc());

  @override
  String toJson(UTCDate object) => object.value.toUtc().toIso8601String();
}