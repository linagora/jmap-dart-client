import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vacation_capability.g.dart';

@JsonSerializable()
class VacationCapability extends CapabilityProperties {
  VacationCapability();

  factory VacationCapability.fromJson(Map<String, dynamic> json) => _$VacationCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$VacationCapabilityToJson(this);

  static VacationCapability deserialize(Map<String, dynamic> json) => VacationCapability.fromJson(json);

  @override
  List<Object?> get props => [];
}