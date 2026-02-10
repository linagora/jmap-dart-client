// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trigger _$TriggerFromJson(Map<String, dynamic> json) => Trigger(
      type: json['@type'] as String?,
      relativeTo: json['relativeTo'] as String?,
      offset: json['offset'] as String?,
      when: json['when'] as String?,
      relatedTo: (json['relatedTo'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, RelatedToValue.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$TriggerToJson(Trigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('relativeTo', instance.relativeTo);
  writeNotNull('offset', instance.offset);
  writeNotNull('when', instance.when);
  writeNotNull('relatedTo', instance.relatedTo);
  return val;
}
