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

  group('EmailBodyValue.fromJson resilience', () {
    test('malformed individualHeaders entry falls back to RawHeaderValue, valid entries preserved', () {
      final json = {
        'value': 'Hello',
        'isEncodingProblem': false,
        'isTruncated': false,
        'header:Accept-Language:asText': 'en-US',
        'header:Content-Language:asDate': 99, // int instead of String → RawHeaderValue('99')
      };

      final result = EmailBodyValue.fromJson(json);

      expect(result.value, equals('Hello'));
      expect(result.individualHeaders.length, equals(2));
      expect(result.acceptLanguageHeader?.value, equals('en-US'));
      expect(
        result.individualHeaders[IndividualHeaderIdentifier('header:Content-Language:asDate')],
        equals(const RawHeaderValue('99')),
      );
    });

    test('all individualHeaders malformed → all become RawHeaderValue, core fields still parse', () {
      final json = {
        'value': 'Body text',
        'isEncodingProblem': true,
        'isTruncated': false,
        'header:Subject:asText': 42,   // int → RawHeaderValue('42')
        'header:Date:asDate': true,    // bool → RawHeaderValue('true')
      };

      final result = EmailBodyValue.fromJson(json);

      expect(result.value, equals('Body text'));
      expect(result.isEncodingProblem, isTrue);
      expect(result.individualHeaders.length, equals(2));
      expect(
        result.individualHeaders[IndividualHeaderIdentifier('header:Subject:asText')],
        equals(const RawHeaderValue('42')),
      );
      expect(
        result.individualHeaders[IndividualHeaderIdentifier('header:Date:asDate')],
        equals(const RawHeaderValue('true')),
      );
    });
  });

  group('EmailBodyValue.toJson resilience', () {
    test('toJson round-trip skips null-value headers', () {
      final obj = EmailBodyValue(
        value: 'Hi',
        isEncodingProblem: false,
        isTruncated: false,
        individualHeaders: {
          IndividualHeaderIdentifier.acceptLanguageHeader: const TextHeaderValue('en'),
          IndividualHeaderIdentifier.contentLanguageHeader: const TextHeaderValue(null),
        },
      );

      final result = obj.toJson();

      expect(result['value'], equals('Hi'));
      expect(result.containsKey('header:Accept-Language:asText'), isTrue);
      expect(result.containsKey('header:Content-Language:asText'), isFalse);
    });
  });
}
