import 'package:jmap_dart_client/jmap/mail/email/submission/delivery_status.dart';
import 'package:json_annotation/json_annotation.dart';

class DeliveredConverter implements JsonConverter<Delivered, String> {
  const DeliveredConverter();

  @override
  Delivered fromJson(String json) => Delivered(json);

  @override
  String toJson(Delivered object) => object.value;
}