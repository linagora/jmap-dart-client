import 'package:jmap_dart_client/jmap/contact/contact_id.dart';
import 'package:json_annotation/json_annotation.dart';

class EmailIdNullableConverter implements JsonConverter<EmailId?, String?> {
  const EmailIdNullableConverter();

  @override
  EmailId? fromJson(String? json) => json != null ? EmailId(json) : null;

  @override
  String? toJson(EmailId? object) => object?.value;
}