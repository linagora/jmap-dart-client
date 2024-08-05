// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicAsset _$PublicAssetFromJson(Map<String, dynamic> json) => PublicAsset(
      id: const IdNullableConverter().fromJson(json['id'] as String?),
      publicURI: json['publicURI'] as String?,
      size: json['size'] as int?,
      contentType: json['contentType'] as String?,
      blobId: const IdNullableConverter().fromJson(json['blobId'] as String?),
      identityIds:
          _$JsonConverterFromJson<Map<String, dynamic>, Map<IdentityId, bool>>(
              json['identityIds'],
              const PublicAssetIdentitiesConverter().fromJson),
    );

Map<String, dynamic> _$PublicAssetToJson(PublicAsset instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', const IdNullableConverter().toJson(instance.id));
  writeNotNull('publicURI', instance.publicURI);
  writeNotNull('size', instance.size);
  writeNotNull('contentType', instance.contentType);
  writeNotNull('blobId', const IdNullableConverter().toJson(instance.blobId));
  writeNotNull(
      'identityIds',
      _$JsonConverterToJson<Map<String, dynamic>, Map<IdentityId, bool>>(
          instance.identityIds, const PublicAssetIdentitiesConverter().toJson));
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
