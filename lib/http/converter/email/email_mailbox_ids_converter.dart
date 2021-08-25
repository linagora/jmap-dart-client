import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';

class EmailMailboxIdsConverter {
  MapEntry<MailboxId, bool> parseEntry(String key, bool value) => MapEntry(MailboxId(Id(key)), value);

  MapEntry<String, bool> toJson(MailboxId mailboxId, bool value) {
    return MapEntry(IdConverter().toJson(mailboxId.id), value);
  }
}