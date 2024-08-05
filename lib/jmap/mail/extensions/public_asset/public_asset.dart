import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/id_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/http/converter/identities/public_asset_identities_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_asset.g.dart';

typedef PublicAssetIdentities = Map<IdentityId, bool>;

@JsonSerializable(
  converters: [
    IdNullableConverter(),
    PublicAssetIdentitiesConverter(),
  ],
  includeIfNull: false,
)
class PublicAsset with EquatableMixin {
  final Id? id;
  final String? publicURI;
  final int? size;
  final String? contentType;
  final Id? blobId;
  final PublicAssetIdentities? identityIds;

  PublicAsset({
      this.id,
      this.publicURI,
      this.size,
      this.contentType,
      this.blobId,
      this.identityIds,
  });
  
  @override
  List<Object?> get props => [
    id,
    publicURI,
    size,
    contentType,
    blobId,
    identityIds,
  ];

  factory PublicAsset.fromJson(Map<String, dynamic> json) => _$PublicAssetFromJson(json);
  Map<String, dynamic> toJson() => _$PublicAssetToJson(this);
}
