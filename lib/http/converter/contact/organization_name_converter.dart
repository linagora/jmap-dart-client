import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:json_annotation/json_annotation.dart';

class OrganizationNameConverter implements JsonConverter<OrganizationName, String> {
  const OrganizationNameConverter();

  @override
  OrganizationName fromJson(String json) => OrganizationName(json);

  @override
  String toJson(OrganizationName object) => object.value;
}


