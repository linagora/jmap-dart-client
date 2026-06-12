// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoKey _$CryptoKeyFromJson(Map<String, dynamic> json) => CryptoKey(
      type: json['@type'] as String? ?? 'CryptoKey',
      uri: json['uri'] as String,
      mediaType: json['mediaType'] as String?,
      pref: parseIntNullable(json['pref']),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$CryptoKeyToJson(CryptoKey instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  val['uri'] = instance.uri;
  val['mediaType'] = instance.mediaType;
  writeNotNull('pref', instance.pref);
  val['label'] = instance.label;
  return val;
}
