// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguagePref _$LanguagePrefFromJson(Map<String, dynamic> json) => LanguagePref(
      language: json['language'] as String,
      type: json['type'] as String?,
      contexts: const ContextsMapConverter()
          .fromJson(json['contexts'] as Map<String, dynamic>?),
      pref: json['pref'] as int?,
    );

Map<String, dynamic> _$LanguagePrefToJson(LanguagePref instance) =>
    <String, dynamic>{
      'type': instance.type,
      'language': instance.language,
      'contexts': const ContextsMapConverter().toJson(instance.contexts),
      'pref': instance.pref,
    };
