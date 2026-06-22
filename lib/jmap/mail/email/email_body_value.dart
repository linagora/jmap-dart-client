import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_header_value.dart';
import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';

class EmailBodyValue with EquatableMixin {
  final String value;
  final bool isEncodingProblem;
  final bool isTruncated;
  final Map<IndividualHeaderIdentifier, EmailHeaderValue> individualHeaders;

  EmailBodyValue({
    required this.value,
    required this.isEncodingProblem,
    required this.isTruncated,
    this.individualHeaders = const {},
  });

  // Backward-compat getters for pre-existing body part headers
  TextHeaderValue? get acceptLanguageHeader {
    final value =
        individualHeaders[IndividualHeaderIdentifier.acceptLanguageHeader];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get contentLanguageHeader {
    final value =
        individualHeaders[IndividualHeaderIdentifier.contentLanguageHeader];
    return value is TextHeaderValue ? value : null;
  }

  factory EmailBodyValue.fromJson(Map<String, dynamic> json) {
    return EmailBodyValue(
      value: json['value'] as String,
      isEncodingProblem: json['isEncodingProblem'] as bool,
      isTruncated: json['isTruncated'] as bool,
      individualHeaders: () {
        final entries = json.entries.where((e) => e.key.startsWith('header:')).toList();
        return Map.fromEntries(entries.map((e) => MapEntry(
          IndividualHeaderIdentifier(e.key),
          EmailHeaderValue.fromJson(e.key, e.value),
        )));
      }(),
    );
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('value', value);
    writeNotNull('isEncodingProblem', isEncodingProblem);
    writeNotNull('isTruncated', isTruncated);
    individualHeaders.forEach((id, value) {
      if (value.toJson() == null) return;
      val[id.value] = value.toJson();
    });

    return val;
  }

  @override
  List<Object?> get props => [
    value,
    isEncodingProblem,
    isTruncated,
    individualHeaders,
  ];
}