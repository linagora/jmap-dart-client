import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

class EmailIdNullableConverter implements JsonConverter<EmailId?, String?> {
  const EmailIdNullableConverter();

  @override
  EmailId? fromJson(String? json) => json != null ? EmailId(Id(json)) : null;

  @override
  String? toJson(EmailId? object) => object?.id.value;
}