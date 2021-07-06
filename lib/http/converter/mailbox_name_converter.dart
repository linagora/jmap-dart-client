import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class MailboxNameConverter implements JsonConverter<MailboxName?, String?> {
  const MailboxNameConverter();

  @override
  MailboxName? fromJson(String? json) => json != null ? MailboxName(json) : null;

  @override
  String? toJson(MailboxName? object) => object?.name;
}