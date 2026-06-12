// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      type: json['@type'] as String? ?? 'Link',
      kind: json['kind'] as String?,
      uri: json['uri'] as String,
      mediaType: json['mediaType'] as String?,
      contexts: const ContextsMapConverter()
          .fromJson(json['contexts'] as Map<String, dynamic>?),
      pref: parseIntNullable(json['pref']),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$LinkToJson(Link instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('kind', instance.kind);
  val['uri'] = instance.uri;
  writeNotNull('mediaType', instance.mediaType);
  writeNotNull(
      'contexts', const ContextsMapConverter().toJson(instance.contexts));
  writeNotNull('pref', instance.pref);
  writeNotNull('label', instance.label);
  return val;
}
