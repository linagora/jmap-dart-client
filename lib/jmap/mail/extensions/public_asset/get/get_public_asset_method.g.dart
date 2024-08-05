// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_public_asset_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPublicAssetMethod _$GetPublicAssetMethodFromJson(
        Map<String, dynamic> json) =>
    GetPublicAssetMethod(
      const AccountIdConverter().fromJson(json['accountId'] as String),
    )..ids = (json['ids'] as List<dynamic>?)
        ?.map((e) => const IdConverter().fromJson(e as String))
        .toSet();

Map<String, dynamic> _$GetPublicAssetMethodToJson(
    GetPublicAssetMethod instance) {
  final val = <String, dynamic>{
    'accountId': const AccountIdConverter().toJson(instance.accountId),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ids', instance.ids?.map(const IdConverter().toJson).toList());
  return val;
}
