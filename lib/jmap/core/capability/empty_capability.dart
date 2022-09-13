import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'empty_capability.g.dart';

@JsonSerializable()
class EmptyCapability extends CapabilityProperties {
  EmptyCapability();

  factory EmptyCapability.fromJson(Map<String, dynamic> json) => _$EmptyCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyCapabilityToJson(this);

  @override
  List<Object?> get props => [];
}