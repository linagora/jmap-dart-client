import 'package:jmap_dart_client/jmap/core/sort/collation_identifier.dart';
import 'package:json_annotation/json_annotation.dart';

class CollationIdentifierNullableConverter implements JsonConverter<CollationIdentifier?, String?> {
  const CollationIdentifierNullableConverter();

  @override
  CollationIdentifier? fromJson(String? json) => json != null ? CollationIdentifier(json) : null;

  @override
  String? toJson(CollationIdentifier? object) => object?.value;
}