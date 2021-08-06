import 'package:jmap_dart_client/jmap/mail/email/keyword_identifier.dart';

class KeyWordIdentifierConverter {
  MapEntry<KeyWordIdentifier, bool> convert(String key, bool value) => MapEntry(KeyWordIdentifier(key), value);
}