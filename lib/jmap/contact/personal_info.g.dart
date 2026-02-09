// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalInfo _$PersonalInfoFromJson(Map<String, dynamic> json) => PersonalInfo(
      kind: json['kind'] as String,
      level: json['level'] as int?,
      contexts: const ContextsMapConverter()
          .fromJson(json['contexts'] as Map<String, dynamic>?),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$PersonalInfoToJson(PersonalInfo instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'level': instance.level,
      'contexts': const ContextsMapConverter().toJson(instance.contexts),
      'label': instance.label,
    };
