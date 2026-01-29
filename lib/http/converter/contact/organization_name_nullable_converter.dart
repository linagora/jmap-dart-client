import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:json_annotation/json_annotation.dart';

class OrganizationNameNullableConverter implements JsonConverter<OrganizationName?, String?> {
  const OrganizationNameNullableConverter();

  @override
  OrganizationName? fromJson(String? json) => json != null ? OrganizationName(json) : null;

  @override
  String? toJson(OrganizationName? object) => object?.value;
}