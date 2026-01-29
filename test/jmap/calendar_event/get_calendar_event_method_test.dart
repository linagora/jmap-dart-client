import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/util/calendar_event_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('JsContact CalendarEvent API - Live Test', () {
    test('get events', () async {
      final liveClient = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_jscontact.json',
      );

      final resp = await CalendarEventUtil.getCalendarEvents(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
      );

      expect(resp.accountId.id.value, liveClient.accountId.id.value);

      for (final e in resp.list) {
        expect(e.id?.id.value, isNotEmpty);
        expect(e.type, isNotNull);
      }
    });

    test('get calendar event by id', () async {
      final liveClient = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_jscontact.json',
      );

      // First fetch all events
      final all = await CalendarEventUtil.getCalendarEvents(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
      );

      expect(all.list.isNotEmpty, true, reason: 'Server should have events');

      final first = all.list.first;
      final eventId = first.id!.id.value;

      // Fetch one event
      final single = await CalendarEventUtil.getCalendarEventById(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
        id: eventId,
      );

      expect(single, isNotNull);
      expect(single!.id?.id.value, eventId);
      expect(single.type, isNotNull);
    });
  });
  
  group('IETF CalendarEvent API - Live Test', () {
    test('get events', () async {
      final liveClient = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final resp = await CalendarEventUtil.getCalendarEvents(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
      );

      expect(resp.accountId.id.value, liveClient.accountId.id.value);
      expect(resp.state.value, isNotEmpty);

      for (final e in resp.list) {
        expect(e.id?.id.value, isNotEmpty);
        expect(e.type, 'Event');
        expect(e.title, isNotNull);
      }
    });
  });

  group('Cyrus CalendarEvent API - Live Test', () {
    test('get events', () async {
      final liveClient = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final resp = await CalendarEventUtil.getCalendarEvents(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
      );

      expect(resp.accountId.id.value, liveClient.accountId.id.value);
      expect(resp.state.value, isNotEmpty);

      for (final e in resp.list) {
        expect(e.id?.id.value, isNotEmpty);
        expect(e.type, 'Event');
      }
    });
  });
  group('CalendarEvent/get - mocked tests', () {
    late Dio dio;
    late DioAdapter mock;
    late HttpClient http;
    final acc = AccountId(Id('acc1'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST', baseUrl: 'https://mocked.test/jmap'));
      mock = DioAdapter(dio: dio);
      http = HttpClient(dio);
    });

    test('CalendarEvent/get returns list', () async {
      mock.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s2",
          "methodResponses": [
            [
              "CalendarEvent/get",
              {
                "accountId": "acc1",
                "state": "st-1",
                "list": [
                  {
                    "id": "e1#event.ics",
                    "@type": "CalendarEvent",
                    "title": "Team Sync",
                    "start": "2025-09-03T09:00:00Z"
                  },
                  {
                    "id": "e2#event.ics",
                    "@type": "CalendarEvent",
                    "title": "1:1",
                    "start": "2025-09-04T10:00:00Z"
                  }
                ],
                "notFound": []
              },
              "c0"
            ]
          ]
        }),
        data: Matchers.any,
      );

      final resp = await CalendarEventUtil.getCalendarEvents(
        client: http,
        accountId: acc,
      );

      expect(resp.accountId.id.value, 'acc1');
      expect(resp.list.length, 2);
      expect(resp.list[0].title, 'Team Sync');
      expect(resp.list[1].title, '1:1');
    });
  });
}
