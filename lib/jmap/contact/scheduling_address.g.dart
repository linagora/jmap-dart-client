// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduling_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchedulingAddress _$SchedulingAddressFromJson(Map<String, dynamic> json) =>
    SchedulingAddress(
      type: json['@type'] as String? ?? 'SchedulingAddress',
      uri: json['uri'] as String?,
      contexts: const ContextsMapConverter()
          .fromJson(json['contexts'] as Map<String, dynamic>?),
      pref: parseIntNullable(json['pref']),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$SchedulingAddressToJson(SchedulingAddress instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  val['uri'] = instance.uri;
  val['contexts'] = const ContextsMapConverter().toJson(instance.contexts);
  writeNotNull('pref', instance.pref);
  val['label'] = instance.label;
  return val;
}
