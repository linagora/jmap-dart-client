// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pronouns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pronouns _$PronounsFromJson(Map<String, dynamic> json) => Pronouns(
      type: json['@type'] as String?,
      pronouns: json['pronouns'] as String,
      pref: json['pref'] as int?,
    );

Map<String, dynamic> _$PronounsToJson(Pronouns instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  val['pronouns'] = instance.pronouns;
  writeNotNull('pref', instance.pref);
  return val;
}
