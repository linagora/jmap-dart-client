import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_relation.dart';

class RelationValueNullableConverter implements JsonConverter<Relation?, String?> {
  const RelationValueNullableConverter();

  @override
  Relation? fromJson(String? json) => json != null ? Relation(json) : null;

  @override
  String? toJson(Relation? object) => object?.value;
}