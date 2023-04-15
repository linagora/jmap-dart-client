// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blob_found_not_parsable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlobFoundNotParsable _$BlobFoundNotParsableFromJson(
        Map<String, dynamic> json) =>
    BlobFoundNotParsable(
      accountId: json['accountId'] == null
          ? null
          : AccountId.fromJson(json['accountId'] as Map<String, dynamic>),
      notParsable: (json['notParsable'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BlobFoundNotParsableToJson(
        BlobFoundNotParsable instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'notParsable': instance.notParsable,
    };
