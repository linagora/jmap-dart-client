
import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/http/converter/utc_date_converter.dart';
import 'package:jmap_dart_client/http/converter/utc_date_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';

void main() {

  const utcDateStringTest = '2021-10-04T04:39:56.000Z';
  final expectUTCDate = UTCDate(DateTime.parse('2021-10-04T04:39:56.000Z').toUtc());
  final testUTCDate = UTCDate(DateTime.parse('2021-10-04T04:39:56.000Z').toUtc());
  const expectUTCDateString = '2021-10-04T04:39:56.000Z';

  group('UTCDateConverter', () {
    test('should return UTCDate when receive a properly formatted json', () {
      expect(expectUTCDate, const UTCDateConverter().fromJson(utcDateStringTest));
    });

    test('should return utc date string valid when receive a utc date', () {
      expect(expectUTCDateString, const UTCDateConverter().toJson(testUTCDate));
    });
  });

  group('UTCDateNullableConverter', () {
    test('should return UTCDate when receive a properly formatted json', () {
      expect(expectUTCDate, const UTCDateNullableConverter().fromJson(utcDateStringTest));
    });

    test('should return utc date string valid when receive a utc date', () {
      expect(expectUTCDateString, const UTCDateNullableConverter().toJson(testUTCDate));
    });
  });
}