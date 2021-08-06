import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';

class MailboxIdsConverter {
  MapEntry<MailboxId, bool> convert(String key, bool value) => MapEntry(MailboxId(Id(key)), value);
}