// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      kind: json['kind'] as String,
      uri: json['uri'] as String,
      mediaType: json['mediaType'] as String?,
      contexts: const ContextsMapConverter()
          .fromJson(json['contexts'] as Map<String, dynamic>?),
      pref: json['pref'] as int?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'kind': instance.kind,
      'uri': instance.uri,
      'mediaType': instance.mediaType,
      'contexts': const ContextsMapConverter().toJson(instance.contexts),
      'pref': instance.pref,
      'label': instance.label,
    };
