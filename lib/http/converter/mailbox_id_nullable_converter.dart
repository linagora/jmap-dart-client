import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class MailboxIdNullableConverter implements JsonConverter<MailboxId?, String?> {
  const MailboxIdNullableConverter();

  @override
  MailboxId? fromJson(String? json) => json != null ? MailboxId(Id(json)) : null;

  @override
  String? toJson(MailboxId? object) => object?.id.value;
}