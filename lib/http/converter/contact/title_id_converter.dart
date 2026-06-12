import 'package:jmap_dart_client/jmap/contact/contact_id.dart';
import 'package:json_annotation/json_annotation.dart';

class TitleIdConverter implements JsonConverter<TitleId, String> {
  const TitleIdConverter();

  @override
  TitleId fromJson(String json) => TitleId(json);

  @override
  String toJson(TitleId object) => object.value;
}


