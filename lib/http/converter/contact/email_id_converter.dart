import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/contact_id.dart';

class EmailIdConverter implements JsonConverter<EmailId, String> {
  const EmailIdConverter();

  @override
  EmailId fromJson(String json) => EmailId(json);

  @override
  String toJson(EmailId object) => object.value;
}