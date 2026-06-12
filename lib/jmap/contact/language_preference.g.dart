// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguagePref _$LanguagePrefFromJson(Map<String, dynamic> json) => LanguagePref(
      type: json['@type'] as String? ?? 'LanguagePref',
      language: json['language'] as String,
      contexts: const ContextsMapConverter()
          .fromJson(json['contexts'] as Map<String, dynamic>?),
      pref: parseIntNullable(json['pref']),
    );

Map<String, dynamic> _$LanguagePrefToJson(LanguagePref instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  val['language'] = instance.language;
  val['contexts'] = const ContextsMapConverter().toJson(instance.contexts);
  writeNotNull('pref', instance.pref);
  return val;
}
