// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      type: json['@type'] as String? ?? 'Media',
      kind: json['kind'] as String,
      uri: json['uri'] as String?,
      mediaType: json['mediaType'] as String?,
      contexts: const ContextsMapConverter()
          .fromJson(json['contexts'] as Map<String, dynamic>?),
      pref: parseIntNullable(json['pref']),
      label: json['label'] as String?,
      blobId: json['blobId'] as String?,
    );

Map<String, dynamic> _$MediaToJson(Media instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  val['kind'] = instance.kind;
  writeNotNull('uri', instance.uri);
  writeNotNull('mediaType', instance.mediaType);
  writeNotNull(
      'contexts', const ContextsMapConverter().toJson(instance.contexts));
  writeNotNull('pref', instance.pref);
  writeNotNull('label', instance.label);
  writeNotNull('blobId', instance.blobId);
  return val;
}
