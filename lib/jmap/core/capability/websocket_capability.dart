import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'websocket_capability.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WebSocketCapability extends CapabilityProperties {
  final bool? supportsPush;
  final Uri? url;

  WebSocketCapability({this.supportsPush, this.url});

  factory WebSocketCapability.fromJson(Map<String, dynamic> json) => _$WebSocketCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$WebSocketCapabilityToJson(this);

  static WebSocketCapability deserialize(Map<String, dynamic> json) => WebSocketCapability.fromJson(json);

  @override
  List<Object?> get props => [supportsPush, url];
}