// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertValue _$AlertValueFromJson(Map<String, dynamic> json) => AlertValue(
      type: json['@type'] as String? ?? 'Alert',
      action: json['action'] as String? ?? 'Alert',
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

  writeNotNull('@type', instance.type);
  writeNotNull('action', instance.action);
  val['trigger'] = instance.trigger;
  return val;
}
