import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:json_annotation/json_annotation.dart';

class CapabilityIdentifierConverter implements JsonConverter<CapabilityIdentifier, String> {
  const CapabilityIdentifierConverter();

  @override
  CapabilityIdentifier fromJson(String json) => CapabilityIdentifier(Uri.parse(json));

  @override
  String toJson(CapabilityIdentifier object) => object.value.toString();
}