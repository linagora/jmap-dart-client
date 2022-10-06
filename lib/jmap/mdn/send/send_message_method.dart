import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/identities/identity_id_converter.dart';
import 'package:jmap_dart_client/http/converter/mdn/mdn_converter.dart';
import 'package:jmap_dart_client/http/converter/set/set_method_properties_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/mdn/mdn.dart';

class SendMessageMethod extends MethodRequiringAccountId {
  final IdentityId identityId;

  final Map<Id, Mdn> send;

  final Map<Id, PatchObject>? onSuccessUpdateEmail;

  SendMessageMethod(
    AccountId accountId, {
    required this.identityId,
    required this.send,
    this.onSuccessUpdateEmail,
  }) : super(accountId);

  @override
  MethodName get methodName => MethodName('MDN/send');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
        CapabilityIdentifier.jmapMdn,
        CapabilityIdentifier.jmapMail,
        CapabilityIdentifier.jmapCore,
      };

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
      'identityId': const IdentityIdConverter().toJson(identityId),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull(
        'send', send.map((key, value) => MdnConverter().toJson(key, value)));
    writeNotNull(
        'onSuccessUpdateEmail',
        onSuccessUpdateEmail?.map((key, value) =>
            SetMethodPropertiesConverter().fromMapIdToJson(key, value)));
    return val;
  }

  @override
  List<Object?> get props => [
    methodName,
    accountId,
    identityId,
    send,
    onSuccessUpdateEmail,
    requiredCapabilities
  ];
}
