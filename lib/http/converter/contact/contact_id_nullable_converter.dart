import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

class ContactIdNullableConverter implements JsonConverter<ContactId?, String?> {
  const ContactIdNullableConverter();

  @override
  ContactId? fromJson(String? json) => json != null ? ContactId(Id(json)) : null;
  @override
  String? toJson(ContactId? object) => object?.id.value;
}