// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blob.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blob _$BlobFromJson(Map<String, dynamic> json) => Blob(
      blobId: json['id'] as String?,
      size: json['size'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      parentId: json['parentId'] as String?,
    );

Map<String, dynamic> _$BlobToJson(Blob instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.blobId);
  writeNotNull('size', instance.size);
  writeNotNull('parentId', instance.parentId);
  writeNotNull('data', instance.data);
  return val;
}
