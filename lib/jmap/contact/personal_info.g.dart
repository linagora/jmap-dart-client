// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalInfo _$PersonalInfoFromJson(Map<String, dynamic> json) => PersonalInfo(
      type: json['@type'] as String? ?? 'PersonalInfo',
      kind: json['kind'] as String,
      value: json['value'] as String,
      level: json['level'] as String?,
      contexts: const ContextsMapConverter()
          .fromJson(json['contexts'] as Map<String, dynamic>?),
      listAs: parseIntNullable(json['listAs']),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$PersonalInfoToJson(PersonalInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  val['kind'] = instance.kind;
  val['value'] = instance.value;
  writeNotNull('level', instance.level);
  writeNotNull(
      'contexts', const ContextsMapConverter().toJson(instance.contexts));
  writeNotNull('listAs', instance.listAs);
  writeNotNull('label', instance.label);
  return val;
}
