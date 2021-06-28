import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class UnreadEmailsConverter implements JsonConverter<UnreadEmails?, int?> {
  const UnreadEmailsConverter();

  @override
  UnreadEmails? fromJson(int? json) {
    return json != null ? UnreadEmails(UnsignedInt(json)) : null;
  }

  @override
  int? toJson(UnreadEmails? object) {
    return object?.value.value.toInt();
  }
}