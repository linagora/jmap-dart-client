import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_blob_method.g.dart';

@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable()
class GetBlobMethod extends GetMethod {
  GetBlobMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Blob/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities =>
      {CapabilityIdentifier.jmapCore, CapabilityIdentifier.jmapBlob};

  factory GetBlobMethod.fromJson(Map<String, dynamic> json) =>
      _$GetBlobMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetBlobMethodToJson(this);

  @override
  List<Object?> get props => [
        methodName,
        accountId,
        ids,
        properties,
        referenceIds,
        referenceProperties,
        requiredCapabilities,
      ];
}
