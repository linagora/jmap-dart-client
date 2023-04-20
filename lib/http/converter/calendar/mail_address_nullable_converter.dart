import 'package:jmap_dart_client/jmap/mail/calendar/properties/mail_address.dart';
import 'package:json_annotation/json_annotation.dart';

class MailAddressNullableConverter implements JsonConverter<MailAddress?, String?> {
  const MailAddressNullableConverter();

  @override
  MailAddress? fromJson(String? json) => json != null ? MailAddress(json) : null;

  @override
  String? toJson(MailAddress? object) => object?.value;
}