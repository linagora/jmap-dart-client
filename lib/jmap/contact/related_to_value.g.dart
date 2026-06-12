// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'related_to_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelatedToValue _$RelatedToValueFromJson(Map<String, dynamic> json) =>
    RelatedToValue(
      type: json['@type'] as String?,
      relation: json['relation'] is Map<String, dynamic>
          ? (json['relation'] as Map<String, dynamic>)
              .map((key, value) => RelationConverter().parseEntry(key, value))
          : null,
    );

Map<String, dynamic> _$RelatedToValueToJson(RelatedToValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) val[key] = value;
  }

  writeNotNull('@type', instance.type);
  writeNotNull(
    'relation',
    instance.relation?.map(
      (key, value) => RelationConverter().toJson(key, value),
    ),
  );

  return val;
}
