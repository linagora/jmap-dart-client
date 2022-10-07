import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/identities/identity_id_converter.dart';
import 'package:jmap_dart_client/http/converter/send/send_method_properties_converter.dart';
import 'package:jmap_dart_client/http/converter/set/set_method_properties_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/send_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/set/set_email_submission_method.dart';
import 'package:jmap_dart_client/jmap/mdn/mdn.dart';

class MDNSendMethod extends SendMethod<MDN> with OptionalOnSuccessUpdateEmail {

  final IdentityId identityId;

  MDNSendMethod(super.accountId, super.send, this.identityId);

  @override
  MethodName get methodName => MethodName('MDN/send');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapMdn
  };

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
      'send': send.map((id, mdn) =>
          SendMethodPropertiesConverter().fromMapIdToJson(id, mdn.toJson())),
      'identityId': const IdentityIdConverter().toJson(identityId),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('onSuccessUpdateEmail', onSuccessUpdateEmail
        ?.map((id, update) => SetMethodPropertiesConverter()
        .fromMapEmailSubmissionIdToJson(id, update)));
    return val;
  }

  @override
  List<Object?> get props => [
    accountId,
    send,
    identityId,
    onSuccessUpdateEmail
  ];
}
