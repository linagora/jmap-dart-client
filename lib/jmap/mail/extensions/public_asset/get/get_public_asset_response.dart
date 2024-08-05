import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/public_asset.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_public_asset_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetPublicAssetResponse extends GetResponse<PublicAsset> {
  GetPublicAssetResponse(super.accountId, super.state, super.list, super.notFound);
  
  @override
  List<Object?> get props => [accountId, state, list, notFound];

  static GetPublicAssetResponse deserialize(Map<String, dynamic> json) 
    => _$GetPublicAssetResponseFromJson(json);
}