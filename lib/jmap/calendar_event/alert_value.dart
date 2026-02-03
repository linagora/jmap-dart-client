import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/calendar_event/trigger.dart';
import 'package:json_annotation/json_annotation.dart';

class AlertValue with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final String? action;

  final Trigger? trigger;

  AlertValue({this.action, this.trigger});

  factory AlertValue.fromJson(Map<String, dynamic> json) => _$AlertValueFromJson(json);

  Map<String, dynamic> toJson() => _$AlertValueToJson(this);

  @override
  List<Object?> get props => [action, trigger];
}

AlertValue _$AlertValueFromJson(Map<String, dynamic> json) =>
    AlertValue(
      action: json['action'] as String?,
      trigger: json['trigger'] == null
          ? null
          : Trigger.fromJson(json['trigger'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlertValueToJson(AlertValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('action', instance.action);
  writeNotNull('trigger', instance.trigger);
  return val;
}
