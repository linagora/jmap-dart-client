// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speak_to_as.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakToAs _$SpeakToAsFromJson(Map<String, dynamic> json) => SpeakToAs(
      type: json['@type'] as String?,
      grammaticalGender: json['grammaticalGender'] as String?,
      pronouns: (json['pronouns'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Pronouns.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$SpeakToAsToJson(SpeakToAs instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('grammaticalGender', instance.grammaticalGender);
  writeNotNull(
      'pronouns', instance.pronouns?.map((k, e) => MapEntry(k, e.toJson())));
  return val;
}
