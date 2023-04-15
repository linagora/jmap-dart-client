// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_body_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailBodyPart _$EmailBodyPartFromJson(Map<String, dynamic> json) =>
    EmailBodyPart(
      partId:
          const PartIdNullableConverter().fromJson(json['partId'] as String?),
      blobId: const IdNullableConverter().fromJson(json['blobId'] as String?),
      size: const UnsignedIntNullableConverter().fromJson(json['size'] as int?),
      headers: (json['headers'] as List<dynamic>?)
          ?.map((e) => EmailHeader.fromJson(e as Map<String, dynamic>))
          .toSet(),
      name: json['name'] as String?,
      type:
          const MediaTypeNullableConverter().fromJson(json['type'] as String?),
      charset: json['charset'] as String?,
      disposition: json['disposition'] as String?,
      cid: json['cid'] as String?,
      language:
          (json['language'] as List<dynamic>?)?.map((e) => e as String).toSet(),
      location: json['location'] as String?,
      subParts: (json['subParts'] as List<dynamic>?)
          ?.map((e) => EmailBodyPart.fromJson(e as Map<String, dynamic>))
          .toSet(),
    );

Map<String, dynamic> _$EmailBodyPartToJson(EmailBodyPart instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'partId', const PartIdNullableConverter().toJson(instance.partId));
  writeNotNull('blobId', const IdNullableConverter().toJson(instance.blobId));
  writeNotNull(
      'size', const UnsignedIntNullableConverter().toJson(instance.size));
  writeNotNull('headers', instance.headers?.toList());
  writeNotNull('name', instance.name);
  writeNotNull(
      'type', const MediaTypeNullableConverter().toJson(instance.type));
  writeNotNull('charset', instance.charset);
  writeNotNull('disposition', instance.disposition);
  writeNotNull('cid', instance.cid);
  writeNotNull('language', instance.language?.toList());
  writeNotNull('location', instance.location);
  writeNotNull('subParts', instance.subParts?.toList());
  return val;
}
