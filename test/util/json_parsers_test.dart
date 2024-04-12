import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/util/json_parsers.dart';

void main() {
  final jsonParsers = JsonParsers();

  group('json parsers test:', () {
    group('parse account id test:', () {
      test('should return account id when json contains account id',() {
        // arrange
        const rawAccountId = 'abc123';
        final json = {'accountId': rawAccountId};

        // act
        final accountId = jsonParsers.parsingAccountId(json);

        // assert
        expect(accountId, AccountId(Id(rawAccountId)));
      });

      test('should throw TypeError exception when json doesn\'t contains account id',() {
        // arrange
        final json = <String, dynamic>{};

        // assert
        expect(
          () => jsonParsers.parsingAccountId(json),
          throwsA(isA<TypeError>()));
      });

      test('should throw TypeError exception when accountId json is not String',() {
        // arrange
        const rawAccountId = 'abc123';
        final json = {'accountId': [rawAccountId]};

        // assert
        expect(
          () => jsonParsers.parsingAccountId(json),
          throwsA(isA<TypeError>()));
      });
    });

    group('parse list id test:', () {
      test('should return list id when json contains list id',() {
        // arrange
        const rawListId = ['abc123'];
        final json = {'listId': rawListId};

        // act
        final listId = jsonParsers.parsingListId(json, 'listId');

        // assert
        expect(listId, rawListId.map((id) => Id(id)).toList());
      });

      test('should return null when json doesn\'t contains list id',() {
        // arrange
        final json = <String, dynamic>{};

        // act
        final listId = jsonParsers.parsingListId(json, 'listId');

        // assert
        expect(listId, null);
      });

      test('should return null when list id json is not List<String>',() {
        // arrange
        final json = {'listId': 'abc123'};

        // act
        final listId = jsonParsers.parsingListId(json, 'listId');

        // assert
        expect(listId, null);
      });
    });

    group('parse list event id test:', () {
      test('should return list event id when json contains list event id',() {
        // arrange
        const rawListEventId = ['abc123'];
        final json = {'listEventId': rawListEventId};

        // act
        final listEventId = jsonParsers.parsingListEventId(json, 'listEventId');

        // assert
        expect(listEventId, rawListEventId.map((id) => EventId(id)).toList());
      });

      test('should return null when json doesn\'t contains list event id',() {
        // arrange
        final json = <String, dynamic>{};

        // act
        final listEventId = jsonParsers.parsingListEventId(json, 'listEventId');

        // assert
        expect(listEventId, null);
      });

      test('should return null when list event id json is not List<String>',() {
        // arrange
        final json = {'listEventId': 'abc123'};

        // act
        final listEventId = jsonParsers.parsingListEventId(json, 'listEventId');

        // assert
        expect(listEventId, null);
      });
    });
  });
}