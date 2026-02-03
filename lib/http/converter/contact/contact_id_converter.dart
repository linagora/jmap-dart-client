import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:json_annotation/json_annotation.dart';

class ContactIdConverter implements JsonConverter<ContactId, String> {
  const ContactIdConverter();

  @override
  ContactId fromJson(String json) => ContactId(Id(json));

  @override
  String toJson(ContactId object) => object.id.value;
}