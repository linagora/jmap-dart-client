import 'package:jmap_dart_client/jmap/core/url_jmap.dart';
import 'package:json_annotation/json_annotation.dart';

class UrlJmapConverter implements JsonConverter<UrlJmap, String> {
  const UrlJmapConverter();

  @override
  UrlJmap fromJson(String json) => UrlJmap(json);

  @override
  String toJson(UrlJmap object) => object.value;
}