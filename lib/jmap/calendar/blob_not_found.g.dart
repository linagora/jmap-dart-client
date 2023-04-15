// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blob_not_found.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlobNotFound _$BlobNotFoundFromJson(Map<String, dynamic> json) => BlobNotFound(
      accountId: json['accountId'] == null
          ? null
          : AccountId.fromJson(json['accountId'] as Map<String, dynamic>),
      notFound: (json['notFound'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BlobNotFoundToJson(BlobNotFound instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'notFound': instance.notFound,
    };
