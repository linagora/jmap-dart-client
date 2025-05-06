import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/mailbox_id_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/clear_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clear_mailbox_method.g.dart';

@JsonSerializable(
  explicitToJson: true,
  converters: [
    AccountIdConverter(),
    MailboxIdConverter(),
  ],
)
class ClearMailboxMethod extends ClearMethod {
  final MailboxId mailboxId;

  ClearMailboxMethod(AccountId accountId, this.mailboxId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Mailbox/clear');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
        CapabilityIdentifier.jmapCore,
        CapabilityIdentifier.jmapMail,
        CapabilityIdentifier.jmapMailboxClear,
      };

  Set<CapabilityIdentifier> get requiredCapabilitiesSupportTeamMailboxes => {
        CapabilityIdentifier.jmapCore,
        CapabilityIdentifier.jmapMail,
        CapabilityIdentifier.jmapTeamMailboxes,
        CapabilityIdentifier.jmapMailboxClear,
      };

  @override
  List<Object?> get props => [methodName, accountId, mailboxId, requiredCapabilities];

  factory ClearMailboxMethod.fromJson(Map<String, dynamic> json) =>
      _$ClearMailboxMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClearMailboxMethodToJson(this);
}
