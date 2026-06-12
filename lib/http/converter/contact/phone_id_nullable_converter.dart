import 'package:jmap_dart_client/jmap/contact/contact_id.dart';
import 'package:json_annotation/json_annotation.dart';

class PhoneIdNullableConverter implements JsonConverter<PhoneId?, String?> {
  const PhoneIdNullableConverter();

  @override
  PhoneId? fromJson(String? json) => json != null ? PhoneId(json) : null;

  @override
  String? toJson(PhoneId? object) => object?.value;
}