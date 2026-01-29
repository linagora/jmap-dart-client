// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_blob_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBlobResponse _$GetBlobResponseFromJson(Map<String, dynamic> json) =>
    GetBlobResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      json['state'] == null
          ? State('') 
          : const StateConverter().fromJson(json['state'] as String),

      (json['list'] as List<dynamic>?)
              ?.map((e) => BlobData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <BlobData>[], 

      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$GetBlobResponseToJson(GetBlobResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'state': const StateConverter().toJson(instance.state),
      'list': instance.list.map((e) => e.toJson()).toList(),
      'notFound':
          instance.notFound?.map(const IdConverter().toJson).toList(),
    };
