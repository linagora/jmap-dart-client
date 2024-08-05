import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_public_asset_method.g.dart';

@JsonSerializable(converters: [AccountIdConverter(), IdConverter()])
class GetPublicAssetMethod extends MethodRequiringAccountId with OptionalIds {
  GetPublicAssetMethod(super.accountId);

  @override
  MethodName get methodName => MethodName('PublicAsset/get');

  @override
  List<Object?> get props => [accountId, ids];

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapPublicAsset
  };
  
  @override
  Map<String, dynamic> toJson() => _$GetPublicAssetMethodToJson(this);
}