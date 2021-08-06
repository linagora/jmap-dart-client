import 'package:jmap_dart_client/jmap/mail/email/email_comparator_property.dart';
import 'package:json_annotation/json_annotation.dart';

class EmailComparatorPropertyConverter implements JsonConverter<EmailComparatorProperty, String> {
  const EmailComparatorPropertyConverter();

  @override
  EmailComparatorProperty fromJson(String json) => EmailComparatorProperty(json);

  @override
  String toJson(EmailComparatorProperty object) => object.value;
}