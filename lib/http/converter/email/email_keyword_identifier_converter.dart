import 'package:jmap_dart_client/jmap/mail/email/keyword_identifier.dart';

class EmailKeywordIdentifierConverter {
  MapEntry<KeyWordIdentifier, bool> parseEntry(String key, bool value) => MapEntry(KeyWordIdentifier(key), value);

  MapEntry<String, bool> toJson(KeyWordIdentifier keyword, bool value) => MapEntry(keyword.value, value);
}