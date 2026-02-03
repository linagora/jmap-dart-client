import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_relation.dart';

class RelationValueConverter implements JsonConverter<Relation, String> {
  const RelationValueConverter();

  @override
  Relation fromJson(String json) => Relation(json);

  @override
  String toJson(Relation object) => object.value;
}

