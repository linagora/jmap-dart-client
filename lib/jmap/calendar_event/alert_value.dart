import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/calendar_event/trigger.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alert_value.g.dart';

@JsonSerializable()
class AlertValue with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? action;

  final Trigger? trigger;

  AlertValue({
    this.type = 'Alert',
    this.action = 'Alert',
    this.trigger,
  });

  factory AlertValue.calendarAlert({Trigger? trigger}) =>
      AlertValue(action: 'CalendarAlert', trigger: trigger);

  factory AlertValue.fromJson(Map<String, dynamic> json) =>
      _$AlertValueFromJson(json);

  Map<String, dynamic> toJson() => _$AlertValueToJson(this);

  @override
  List<Object?> get props => [type, action, trigger];
}
