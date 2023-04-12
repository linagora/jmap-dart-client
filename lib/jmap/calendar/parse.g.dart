// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parsed _$ParsedFromJson(Map<String, dynamic> json) => Parsed(
      blobId: json['blobId'] == null
          ? null
          : BlobId.fromJson(json['blobId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParsedToJson(Parsed instance) => <String, dynamic>{
      'blobId': instance.blobId,
    };
