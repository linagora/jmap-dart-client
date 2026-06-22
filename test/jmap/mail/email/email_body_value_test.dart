import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_value.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_header_value.dart';
import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';

void main() {
  group('EmailBodyValue.fromJson', () {
    test('parses header:Accept-Language:asText and header:Content-Language:asText into getters and map', () {
      final json = {
        'value': 'Hello',
        'isEncodingProblem': false,
        'isTruncated': false,
        'header:Accept-Language:asText': 'en-US',
        'header:Content-Language:asText': 'fr',
      };

      final result = EmailBodyValue.fromJson(json);

      expect(result.acceptLanguageHeader, isA<TextHeaderValue>());
      expect(result.acceptLanguageHeader!.value, equals('en-US'));
      expect(result.contentLanguageHeader, isA<TextHeaderValue>());
      expect(result.contentLanguageHeader!.value, equals('fr'));
      expect(result.individualHeaders.length, equals(2));
      expect(
        result.individualHeaders[IndividualHeaderIdentifier.acceptLanguageHeader],
        equals(const TextHeaderValue('en-US')),
      );
      expect(
        result.individualHeaders[IndividualHeaderIdentifier.contentLanguageHeader],
        equals(const TextHeaderValue('fr')),
      );
    });

    test('toJson round-trip includes header keys', () {
      final json = {
        'value': 'Hello',
        'isEncodingProblem': false,
        'isTruncated': false,
        'header:Accept-Language:asText': 'en-US',
        'header:Content-Language:asText': 'fr',
      };

      final result = EmailBodyValue.fromJson(json).toJson();

      expect(result['value'], equals('Hello'));
      expect(result['header:Accept-Language:asText'], equals('en-US'));
      expect(result['header:Content-Language:asText'], equals('fr'));
    });

    test('no-header JSON produces empty individualHeaders', () {
      final json = {
        'value': 'Hello',
        'isEncodingProblem': false,
        'isTruncated': false,
      };

      final result = EmailBodyValue.fromJson(json);

      expect(result.individualHeaders, isEmpty);
      expect(result.acceptLanguageHeader, isNull);
      expect(result.contentLanguageHeader, isNull);
    });
  });
}
