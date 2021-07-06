import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class MailboxIdConverter implements JsonConverter<MailboxId, String> {
  const MailboxIdConverter();

  @override
  MailboxId fromJson(String json) => MailboxId(Id(json));

  @override
  String toJson(MailboxId object) => object.id.value;
}