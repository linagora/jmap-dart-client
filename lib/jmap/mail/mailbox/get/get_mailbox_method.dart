import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_mailbox_method.g.dart';

@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable(explicitToJson: true)
class GetMailboxMethod extends GetMethod {
  GetMailboxMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Mailbox/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail
  };

  Set<CapabilityIdentifier> get requiredCapabilitiesSupportTeamMailboxes => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapTeamMailboxes
  };

  @override
  List<Object?> get props => [methodName, accountId, ids, properties, requiredCapabilities];

  factory GetMailboxMethod.fromJson(Map<String, dynamic> json) => _$GetMailboxMethodFromJson(json);

  Map<String, dynamic> toJson() => _$GetMailboxMethodToJson(this);
}