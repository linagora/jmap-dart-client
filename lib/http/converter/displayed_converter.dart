import 'package:jmap_dart_client/jmap/mail/email/submission/delivery_status.dart';
import 'package:json_annotation/json_annotation.dart';

class DisplayedConverter implements JsonConverter<Displayed, String> {
  const DisplayedConverter();

  @override
  Displayed fromJson(String json) => Displayed(json);

  @override
  String toJson(Displayed object) => object.value;
}