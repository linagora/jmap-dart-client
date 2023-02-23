import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_capability.g.dart';

@JsonSerializable()
class TestCapability extends CapabilityProperties {
  static CapabilityIdentifier testCapabilityIdentifier = CapabilityIdentifier(Uri.parse('urn:test:tmail:params:custom'));

  final int testParam1;
  final String testParam2;
  final Set<String> testParam3;

  TestCapability(this.testParam1, this.testParam2, this.testParam3);

  factory TestCapability.fromJson(Map<String, dynamic> json) => _$TestCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$TestCapabilityToJson(this);

  static TestCapability deserialize(Map<String, dynamic> json) => TestCapability.fromJson(json);

  @override
  List<Object?> get props => [testParam1, testParam2, testParam3];
}