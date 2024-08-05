// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_public_asset_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPublicAssetResponse _$GetPublicAssetResponseFromJson(
        Map<String, dynamic> json) =>
    GetPublicAssetResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['state'] as String),
      (json['list'] as List<dynamic>)
          .map((e) => PublicAsset.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$GetPublicAssetResponseToJson(
        GetPublicAssetResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'state': const StateConverter().toJson(instance.state),
      'list': instance.list,
      'notFound': instance.notFound?.map(const IdConverter().toJson).toList(),
    };
