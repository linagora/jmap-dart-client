import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

class EmailConverter implements JsonConverter<Email, Map<String, dynamic>> {
  const EmailConverter();

  @override
  Email fromJson(Map<String, dynamic> json) => Email.fromJson(json);

  @override
  Map<String, dynamic> toJson(Email object) => object.toJson();
}