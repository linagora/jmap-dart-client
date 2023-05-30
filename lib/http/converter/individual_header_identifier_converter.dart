
import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';

class IndividualHeaderIdentifierNullableConverter {

  Map<IndividualHeaderIdentifier, String?>? parseEntry(String key, String? value) {
    if (value == null) {
      return null;
    } else {
      return Map.fromEntries([MapEntry(IndividualHeaderIdentifier(key), value)]);
    }
  }

  String? toJson(Map<IndividualHeaderIdentifier, String?>? header, IndividualHeaderIdentifier individualHeaderIdentifier) {
    if (header == null) {
      return null;
    } else {
      return header[individualHeaderIdentifier];
    }
  }
}