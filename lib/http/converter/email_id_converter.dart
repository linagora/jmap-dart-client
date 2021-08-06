import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

class EmailIdConverter implements JsonConverter<EmailId, String> {
  const EmailIdConverter();

  @override
  EmailId fromJson(String json) => EmailId(Id(json));

  @override
  String toJson(EmailId object) => object.id.value;
}