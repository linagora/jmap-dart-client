import 'package:http_parser/http_parser.dart';
import 'package:json_annotation/json_annotation.dart';

class MediaTypeConverter implements JsonConverter<MediaType, String> {
  const MediaTypeConverter();

  @override
  MediaType fromJson(String json) => MediaType.parse(json);

  @override
  String toJson(MediaType object) => object.type;
}