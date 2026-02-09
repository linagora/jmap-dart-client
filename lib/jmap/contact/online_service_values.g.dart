// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_service_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnlineServiceValue _$OnlineServiceValueFromJson(Map<String, dynamic> json) =>
    OnlineServiceValue(
      type: json['@type'] as String?,
      service: json['service'] as String?,
      uri: json['uri'] as String?,
      user: json['user'] as String?,
      label: json['label'] as String?,
      contexts: const ContextsMapConverter()
          .fromJson(json['contexts'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$OnlineServiceValueToJson(OnlineServiceValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  val['service'] = instance.service;
  val['uri'] = instance.uri;
  val['user'] = instance.user;
  val['label'] = instance.label;
  val['contexts'] = const ContextsMapConverter().toJson(instance.contexts);
  return val;
}
