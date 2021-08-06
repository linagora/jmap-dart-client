import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/collation_identifier_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:jmap_dart_client/jmap/core/sort/collation_identifier.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

part 'core_capability.g.dart';

@CollationIdentifierConverter()
@UnsignedIntConverter()
@JsonSerializable()
class CoreCapability extends CapabilityProperties with EquatableMixin {
  final UnsignedInt maxSizeUpload;
  final UnsignedInt maxConcurrentUpload;
  final UnsignedInt maxSizeRequest;
  final UnsignedInt maxConcurrentRequests;
  final UnsignedInt maxCallsInRequest;
  final UnsignedInt maxObjectsInGet;
  final UnsignedInt maxObjectsInSet;
  final Set<CollationIdentifier> collationAlgorithms;

  CoreCapability(
      this.maxSizeUpload,
      this.maxConcurrentUpload,
      this.maxSizeRequest,
      this.maxConcurrentRequests,
      this.maxCallsInRequest,
      this.maxObjectsInGet,
      this.maxObjectsInSet,
      this.collationAlgorithms);

  factory CoreCapability.fromJson(Map<String, dynamic> json) => _$CoreCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$CoreCapabilityToJson(this);

  static CoreCapability deserialize(Map<String, dynamic> json) => CoreCapability.fromJson(json);

  @override
  List<Object?> get props => [
    maxSizeUpload,
    maxConcurrentUpload,
    maxSizeRequest,
    maxConcurrentRequests,
    maxCallsInRequest,
    maxObjectsInGet,
    maxObjectsInSet,
    collationAlgorithms
  ];
}