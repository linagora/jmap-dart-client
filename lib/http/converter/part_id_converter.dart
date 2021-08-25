
import 'package:jmap_dart_client/jmap/mail/email/email_body_part.dart';
import 'package:json_annotation/json_annotation.dart';

class PartIdConverter implements JsonConverter<PartId, String> {
  const PartIdConverter();

  @override
  PartId fromJson(String json) => PartId(json);

  @override
  String toJson(PartId object) => object.value;
}