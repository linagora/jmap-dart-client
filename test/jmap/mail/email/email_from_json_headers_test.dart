import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_header_value.dart';
import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';

Map<String, dynamic> _minimalEmailJson({Map<String, dynamic> extra = const {}}) {
  return {
    ...extra,
  };
}

void main() {
  group('Email.fromJson headers resilience', () {
    test('one bad headers entry is skipped, valid entries preserved', () {
      final json = _minimalEmailJson(extra: {
        'headers': [
          {'name': 'Subject', 'value': 'Hello'},
          {'name': 123, 'value': 'bad'}, // int name → throws
        ],
      });

      final email = Email.fromJson(json);

      expect(email.headers, isNotNull);
      expect(email.headers!.length, equals(1));
      expect(email.headers!.first.name, equals('Subject'));
    });

    test('all headers entries bad → empty set, no throw', () {
      final json = _minimalEmailJson(extra: {
        'headers': [
          {'name': 123, 'value': 456},
          'not-a-map',
        ],
      });

      expect(() => Email.fromJson(json), returnsNormally);
      final email = Email.fromJson(json);
      expect(email.headers, isEmpty);
    });

    test('null headers field → headers is null', () {
      final email = Email.fromJson(_minimalEmailJson());
      expect(email.headers, isNull);
    });
  });

  group('Email.fromJson bodyValues resilience', () {
    test('one bad bodyValues entry skipped, valid entries preserved', () {
      final json = _minimalEmailJson(extra: {
        'bodyValues': {
          '1': {
            'value': 'Good body',
            'isEncodingProblem': false,
            'isTruncated': false,
          },
          '2': 'not-a-map', // wrong type → throws
        },
      });

      final email = Email.fromJson(json);

      expect(email.bodyValues, isNotNull);
      expect(email.bodyValues!.length, equals(1));
    });

    test('all bodyValues bad → bodyValues is null', () {
      final json = _minimalEmailJson(extra: {
        'bodyValues': {
          '1': 'bad',
          '2': 42,
        },
      });

      final email = Email.fromJson(json);
      expect(email.bodyValues, isNull);
    });

    test('null bodyValues field → bodyValues is null', () {
      final email = Email.fromJson(_minimalEmailJson());
      expect(email.bodyValues, isNull);
    });
  });

  group('Email.fromJson individualHeaders resilience', () {
    test('one bad individualHeaders entry skipped, valid entries preserved', () {
      final json = _minimalEmailJson(extra: {
        'header:Subject:asText': 'My Subject',
        'header:Date:asDate': 99, // int instead of String → throws
      });

      final email = Email.fromJson(json);

      expect(email.individualHeaders.length, equals(1));
      expect(
        email.individualHeaders[IndividualHeaderIdentifier.asText('Subject')],
        equals(const TextHeaderValue('My Subject')),
      );
    });

    test('all individualHeaders bad → empty map, rest of Email parses', () {
      final json = _minimalEmailJson(extra: {
        'subject': 'Test',
        'header:Subject:asText': 42,  // int → throws
        'header:Date:asDate': true,   // bool → throws
      });

      final email = Email.fromJson(json);

      expect(email.subject, equals('Test'));
      expect(email.individualHeaders, isEmpty);
    });

    test('no header: keys → empty individualHeaders', () {
      final json = _minimalEmailJson(extra: {'subject': 'Clean'});
      final email = Email.fromJson(json);
      expect(email.individualHeaders, isEmpty);
    });
  });

  group('Email.toJson individualHeaders resilience', () {
    test('null-value headers are omitted from output', () {
      final email = Email(
        individualHeaders: {
          IndividualHeaderIdentifier.asText('Subject'): const TextHeaderValue('Hello'),
          IndividualHeaderIdentifier.asText('X-Null'): const TextHeaderValue(null),
        },
      );

      final result = email.toJson();

      expect(result.containsKey('header:Subject:asText'), isTrue);
      expect(result['header:Subject:asText'], equals('Hello'));
      expect(result.containsKey('header:X-Null:asText'), isFalse);
    });
  });
}
