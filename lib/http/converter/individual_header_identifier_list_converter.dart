import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';

class IndividualHeaderIdentifierListConverter {

  Map<IndividualHeaderIdentifier, List<String>>? parseEntry(String key, dynamic value) {
    if (value == null) return null;
    final list = (value as List<dynamic>).cast<String>();
    return {IndividualHeaderIdentifier(key): list};
  }

  List<String>? toJson(
    Map<IndividualHeaderIdentifier, List<String>>? header,
    IndividualHeaderIdentifier id,
  ) {
    if (header == null) return null;
    return header[id];
  }
}
