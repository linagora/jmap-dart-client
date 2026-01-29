import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:json_annotation/json_annotation.dart';

class RelatedToNameConverter implements JsonConverter<RelatedToName, String> {
  const RelatedToNameConverter();

  @override
  RelatedToName fromJson(String json) => RelatedToName(json);

  @override
  String toJson(RelatedToName object) => object.value;
}


