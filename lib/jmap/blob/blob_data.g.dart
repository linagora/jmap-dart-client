// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blob_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlobData _$BlobDataFromJson(Map<String, dynamic> json) => BlobData(
      id: json['id'] as String,
      size: json['size'] as int,
      dataAsText: json['data:asText'] as String?,
      dataAsBase64: json['data:asBase64'] as String?,
      digestSha: json['digest:sha'] as String?,
      digestSha256: json['digest:sha-256'] as String?,
      isEncodingProblem: json['isEncodingProblem'] as bool?,
      isTruncated: json['isTruncated'] as bool?,
    );

Map<String, dynamic> _$BlobDataToJson(BlobData instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'size': instance.size,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data:asText', instance.dataAsText);
  writeNotNull('data:asBase64', instance.dataAsBase64);
  writeNotNull('digest:sha', instance.digestSha);
  writeNotNull('digest:sha-256', instance.digestSha256);
  writeNotNull('isEncodingProblem', instance.isEncodingProblem);
  writeNotNull('isTruncated', instance.isTruncated);
  return val;
}
