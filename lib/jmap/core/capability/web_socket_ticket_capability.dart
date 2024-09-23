import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'web_socket_ticket_capability.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WebSocketTicketCapability extends CapabilityProperties {
  final Uri? generationEndpoint;
  final Uri? revocationEndpoint;

  WebSocketTicketCapability({required this.generationEndpoint, required this.revocationEndpoint});

  factory WebSocketTicketCapability.fromJson(Map<String, dynamic> json) => _$WebSocketTicketCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$WebSocketTicketCapabilityToJson(this);

  static WebSocketTicketCapability deserialize(Map<String, dynamic> json) => WebSocketTicketCapability.fromJson(json);

  @override
  List<Object?> get props => [generationEndpoint, revocationEndpoint];
}