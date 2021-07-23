import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:json_annotation/json_annotation.dart';

class CapabilityIdentifierConverter implements JsonConverter<CapabilityIdentifier, Uri> {
  const CapabilityIdentifierConverter();

  @override
  CapabilityIdentifier fromJson(Uri json) => CapabilityIdentifier(json);

  @override
  Uri toJson(CapabilityIdentifier object) => object.value;
}