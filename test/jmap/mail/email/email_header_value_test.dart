import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_address.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_header_value.dart';

void main() {
  group('EmailHeaderValue.fromJson', () {
    test('asText parses string and round-trips', () {
      const key = 'header:Subject:asText';
      const json = 'Hello world';

      final result = EmailHeaderValue.fromJson(key, json);

      expect(result, isA<TextHeaderValue>());
      expect((result as TextHeaderValue).value, equals('Hello world'));
      expect(result.toJson(), equals('Hello world'));
    });

    test('asRaw parses raw string and round-trips', () {
      const key = 'header:X-Custom:asRaw';
      const json = ' raw value ';

      final result = EmailHeaderValue.fromJson(key, json);

      expect(result, isA<RawHeaderValue>());
      expect((result as RawHeaderValue).value, equals(' raw value '));
      expect(result.toJson(), equals(' raw value '));
    });

    test('asDate parses ISO string to DateHeaderValue and round-trips', () {
      const key = 'header:Date:asDate';
      const isoString = '2024-01-15T10:30:00Z';

      final result = EmailHeaderValue.fromJson(key, isoString);

      expect(result, isA<DateHeaderValue>());
      final dateValue = (result as DateHeaderValue).value;
      expect(dateValue, isA<UTCDate>());
      expect(dateValue!.value, equals(DateTime.parse(isoString)));
      expect(result.toJson(), equals('2024-01-15T10:30:00.000Z'));
    });

    test('asAddresses parses address list and round-trips', () {
      const key = 'header:From:asAddresses';
      final json = [
        {'name': 'Alice', 'email': 'alice@example.com'},
        {'name': null, 'email': 'bob@example.com'},
      ];

      final result = EmailHeaderValue.fromJson(key, json);

      expect(result, isA<AddressesHeaderValue>());
      final addresses = (result as AddressesHeaderValue).addresses;
      expect(addresses.length, equals(2));
      expect(addresses[0], equals(EmailAddress('Alice', 'alice@example.com')));
      expect(addresses[1], equals(EmailAddress(null, 'bob@example.com')));

      final encoded = result.toJson() as List;
      expect(encoded.length, equals(2));
      expect(encoded[0]['email'], equals('alice@example.com'));
    });

    test('asMessageIds parses id list and round-trips', () {
      const key = 'header:Message-ID:asMessageIds';
      final json = ['abc@host.com', 'def@host.com'];

      final result = EmailHeaderValue.fromJson(key, json);

      expect(result, isA<MessageIdsEmailHeaderValue>());
      expect((result as MessageIdsEmailHeaderValue).ids, equals(['abc@host.com', 'def@host.com']));
      expect(result.toJson(), equals(['abc@host.com', 'def@host.com']));
    });

    test('asURLs parses url list and round-trips', () {
      const key = 'header:List-Unsubscribe:asURLs';
      final json = ['https://example.com/unsub', 'mailto:unsub@example.com'];

      final result = EmailHeaderValue.fromJson(key, json);

      expect(result, isA<URLsHeaderValue>());
      expect((result as URLsHeaderValue).urls, equals(['https://example.com/unsub', 'mailto:unsub@example.com']));
      expect(result.toJson(), equals(['https://example.com/unsub', 'mailto:unsub@example.com']));
    });

    test('asRaw:all parses list into AllHeaderValue of RawHeaderValues', () {
      const key = 'header:Received:asRaw:all';
      final json = [' from a.example.com', ' from b.example.com'];

      final result = EmailHeaderValue.fromJson(key, json);

      expect(result, isA<AllHeaderValue>());
      final all = (result as AllHeaderValue).values;
      expect(all.length, equals(2));
      expect(all[0], isA<RawHeaderValue>());
      expect((all[0] as RawHeaderValue).value, equals(' from a.example.com'));
      expect((all[1] as RawHeaderValue).value, equals(' from b.example.com'));

      final encoded = result.toJson() as List;
      expect(encoded, equals([' from a.example.com', ' from b.example.com']));
    });

    test('unknown suffix falls back to RawHeaderValue without throwing', () {
      const key = 'header:Foo:asWeird';
      const json = 'some value';

      final result = EmailHeaderValue.fromJson(key, json);

      expect(result, isA<RawHeaderValue>());
      expect((result as RawHeaderValue).value, equals('some value'));
    });

    test('asDate with null json parses to DateHeaderValue with null value', () {
      const key = 'header:Date:asDate';

      final result = EmailHeaderValue.fromJson(key, null);

      expect(result, isA<DateHeaderValue>());
      expect((result as DateHeaderValue).value, isNull);
      expect(result.toJson(), isNull);
    });
  });
}
