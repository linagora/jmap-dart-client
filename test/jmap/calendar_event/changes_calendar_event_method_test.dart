import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/util/calendar_event_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('IETF CalendarEvent/changes live', () {
    test('live changes call', () async {
      final liveClient = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final first = await CalendarEventUtil.getCalendarEvents(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
      );

      final resp = await CalendarEventUtil.changesCalendarEvents(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
        sinceState: first.state,
      );

      expect(resp.oldState.value, isNotNull);
      expect(resp.newState.value, isNotNull);
    });
  });

  group('Cyrus CalendarEvent/changes live', () {
    test('live changes call', () async {
      final liveClient = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final first = await CalendarEventUtil.getCalendarEvents(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
      );

      final resp = await CalendarEventUtil.changesCalendarEvents(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
        sinceState: first.state,
        
      );

      expect(resp.oldState.value, isNotNull);
      expect(resp.newState.value, isNotNull);
    });
  });
  group('CalendarEvent/changes - mocked', () {
    late Dio dio;
    late DioAdapter mock;
    late HttpClient http;

    const base = 'http://domain.com/jmap';
    final acc = AccountId(Id('acc-123'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST', baseUrl: base));
      mock = DioAdapter(dio: dio);
      http = HttpClient(dio);
    });

    test('get changes calendar events', () async {
      mock.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s-1",
          "methodResponses": [
            [
              "CalendarEvent/changes",
              {
                "accountId": "acc-123",
                "oldState": "old-state",
                "newState": "new-state",
                "hasMoreChanges": false,
                "created": ["ev-1"],
                "updated": ["ev-2"],
                "destroyed": []
              },
              "c0"
            ]
          ]
        }),
        data: Matchers.any,
      );

      final resp = await CalendarEventUtil.changesCalendarEvents(
        client: http,
        accountId: acc,
        sinceState: State("old-state"),
      );

      expect(resp.oldState.value, "old-state");
      expect(resp.newState.value, "new-state");
      expect(resp.created.first.value, "ev-1");
      expect(resp.updated.first.value, "ev-2");
      expect(resp.destroyed, isEmpty);
    });
    test('CalendarEvent/changes returns created updated destroyed', () async {
      mock.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "sCyrus",
          "methodResponses": [
            [
              "CalendarEvent/changes",
              {
                "accountId": "accCyrus",
                "oldState": "st-100",
                "newState": "st-101",
                "hasMoreChanges": true,
                "created": ["event-1", "event-2"],
                "updated": ["event-3"],
                "destroyed": ["event-4"]
              },
              "c0"
            ]
          ]
        }),
        data: Matchers.any,
      );

      final resp = await CalendarEventUtil.changesCalendarEvents(
        client: http,
        accountId: acc,
        sinceState: State("st-100"),
      );

      expect(resp.oldState.value, "st-100");
      expect(resp.newState.value, "st-101");
      expect(resp.created.map((e) => e.value).toList(), ["event-1", "event-2"]);
      expect(resp.updated.map((e) => e.value).toList(), ["event-3"]);
      expect(resp.destroyed.map((e) => e.value).toList(), ["event-4"]);
      expect(resp.hasMoreChanges, true);
    });
  });
}
