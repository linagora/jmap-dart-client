import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/individual_header_identifier_converter.dart';
import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';

class EmailBodyValue with EquatableMixin {
  final String value;
  final bool isEncodingProblem;
  final bool isTruncated;
  final Map<IndividualHeaderIdentifier, String?>? acceptLanguageHeader;
  final Map<IndividualHeaderIdentifier, String?>? contentLanguageHeader;

  EmailBodyValue({
    required this.value,
    required this.isEncodingProblem,
    required this.isTruncated,
    this.acceptLanguageHeader,
    this.contentLanguageHeader
  });

  factory EmailBodyValue.fromJson(Map<String, dynamic> json) {
    return EmailBodyValue(
      value: json['value'] as String,
      isEncodingProblem: json['isEncodingProblem'] as bool,
      isTruncated: json['isTruncated'] as bool,
      acceptLanguageHeader: IndividualHeaderIdentifierNullableConverter()
        .parseEntry(
          IndividualHeaderIdentifier.acceptLanguageHeader.value,
          json[IndividualHeaderIdentifier.acceptLanguageHeader.value] as String?
        ),
      contentLanguageHeader: IndividualHeaderIdentifierNullableConverter()
        .parseEntry(
          IndividualHeaderIdentifier.contentLanguageHeader.value,
          json[IndividualHeaderIdentifier.contentLanguageHeader.value] as String?
        ),
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
    writeNotNull(
      IndividualHeaderIdentifier.acceptLanguageHeader.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        acceptLanguageHeader,
        IndividualHeaderIdentifier.acceptLanguageHeader
      )
    );
    writeNotNull(
      IndividualHeaderIdentifier.contentLanguageHeader.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        contentLanguageHeader,
        IndividualHeaderIdentifier.contentLanguageHeader
      )
    );
    return val;
  }

  @override
  List<Object?> get props => [
    value,
    isEncodingProblem,
    isTruncated,
    acceptLanguageHeader,
    contentLanguageHeader,
  ];
}