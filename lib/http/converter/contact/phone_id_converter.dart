import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:json_annotation/json_annotation.dart';

class PhoneIdConverter implements JsonConverter<PhoneId, String> {
  const PhoneIdConverter();

  @override
  PhoneId fromJson(String json) => PhoneId(json);

  @override
  String toJson(PhoneId object) => object.value;
}


