import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/set/set_method_properties_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/set_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/public_asset.dart';

class SetPublicAssetMethod extends SetMethod<PublicAsset> {

  SetPublicAssetMethod(super.accountId);

  @override
  MethodName get methodName => MethodName('PublicAsset/set');

  @override
  List<Object?> get props => [accountId, ifInState, create, update, destroy];

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapPublicAsset
  };

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('create', create
      ?.map((id, create) => SetMethodPropertiesConverter().fromMapIdToJson(id, create.toJson())));
    writeNotNull('update', update
      ?.map((id, update) => SetMethodPropertiesConverter().fromMapIdToJson(id, update.toJson())));
    writeNotNull('destroy', destroy
      ?.map((destroyId) => const IdConverter().toJson(destroyId)).toList());

    return val;
  }
}