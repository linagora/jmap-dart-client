
import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';

class IndividualHeaderIdentifierNullableConverter {

  MapEntry<IndividualHeaderIdentifier, String?> parseEntry(String key, String? value) => MapEntry(IndividualHeaderIdentifier(key), value);

  String? toJson(Map<IndividualHeaderIdentifier, String?>? header, IndividualHeaderIdentifier individualHeaderIdentifier) {
    return header?[individualHeaderIdentifier];
  }
}