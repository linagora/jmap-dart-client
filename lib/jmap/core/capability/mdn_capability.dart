import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mdn_capability.g.dart';

@JsonSerializable()
class MdnCapability extends CapabilityProperties with EquatableMixin {
  MdnCapability();

  factory MdnCapability.fromJson(Map<String, dynamic> json) => _$MdnCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$MdnCapabilityToJson(this);

  static MdnCapability deserialize(Map<String, dynamic> json) => MdnCapability.fromJson(json);

  @override
  List<Object?> get props => [];
}