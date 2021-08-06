// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_body_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailBodyPart _$EmailBodyPartFromJson(Map<String, dynamic> json) {
  return EmailBodyPart(
    const PartIdNullableConverter().fromJson(json['partId'] as String?),
    const IdNullableConverter().fromJson(json['blobId'] as String?),
    const UnsignedIntNullableConverter().fromJson(json['size'] as int?),
    (json['headers'] as List<dynamic>?)
        ?.map((e) => EmailHeader.fromJson(e as Map<String, dynamic>))
        .toSet(),
    json['name'] as String?,
    const MediaTypeNullableConverter().fromJson(json['type'] as String?),
    json['charset'] as String?,
    json['disposition'] as String?,
    json['cid'] as String?,
    (json['language'] as List<dynamic>?)?.map((e) => e as String).toSet(),
    json['location'] as String?,
    (json['subParts'] as List<dynamic>?)
        ?.map((e) => EmailBodyPart.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$EmailBodyPartToJson(EmailBodyPart instance) =>
    <String, dynamic>{
      'partId': const PartIdNullableConverter().toJson(instance.partId),
      'blobId': const IdNullableConverter().toJson(instance.blobId),
      'size': const UnsignedIntNullableConverter().toJson(instance.size),
      'headers': instance.headers?.toList(),
      'name': instance.name,
      'type': const MediaTypeNullableConverter().toJson(instance.type),
      'charset': instance.charset,
      'disposition': instance.disposition,
      'cid': instance.cid,
      'language': instance.language?.toList(),
      'location': instance.location,
      'subParts': instance.subParts?.toList(),
    };
