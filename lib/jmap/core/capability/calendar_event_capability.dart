import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_capability.g.dart';

@JsonSerializable(includeIfNull: false)
class CalendarEventCapability extends CapabilityProperties {
  final List<String>? replySupportedLanguage;

  CalendarEventCapability({this.replySupportedLanguage});
  
  factory CalendarEventCapability.fromJson(Map<String, dynamic> json) 
    => _$CalendarEventCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventCapabilityToJson(this);

  static CalendarEventCapability deserialize(Map<String, dynamic> json) {
    return CalendarEventCapability.fromJson(json);
  }
  
  @override
  List<Object?> get props => [replySupportedLanguage];
}