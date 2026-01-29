import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/calendar/changes/changes_calendar_response.dart';
import 'package:jmap_dart_client/util/calendar_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('Calendar/changes - mocked', () {
    late Dio dio;
    late DioAdapter adapter;
    late HttpClient httpClient;

    final accountId = AccountId(Id('ietf-account'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST'))
        ..options.baseUrl = 'https://mocked.example/jmap';
      adapter = DioAdapter(dio: dio);
      httpClient = HttpClient(dio);
    });

    test('Calendar/changes returns created, updated, destroyed', () async {
      adapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s1",
            "methodResponses": [
              [
                "Calendar/changes",
                {
                  "accountId": "ietf-account",
                  "oldState": "st1",
                  "newState": "st2",
                  "hasMoreChanges": false,
                  "created": ["1"],
                  "updated": ["2"],
                  "destroyed": ["3"]
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final resp = await CalendarUtil.changesCalendars(
        client: httpClient,
        accountId: accountId,
        sinceState: State('st1'),
      );

      expect(resp, isA<ChangesCalendarResponse>());
      expect(resp.oldState.value, 'st1');
      expect(resp.newState.value, 'st2');
      expect(resp.created.map((e) => e.value), contains('1'));
      expect(resp.updated.map((e) => e.value), contains('2'));
      expect(resp.destroyed.map((e) => e.value), contains('3'));
    });
  });

  group('Calendar/changes - IETF live', () {
    test('get calendar changes using state from get', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final getResp = await CalendarUtil.getCalendars(
        client: client.httpClient,
        accountId: client.accountId,
      );

      final state = getResp.state;
      expect(state, isNotNull);

      final changesResp = await CalendarUtil.changesCalendars(
        client: client.httpClient,
        accountId: client.accountId,
        sinceState: state,
      );

      expect(changesResp.oldState.value, state.value);
      expect(changesResp.newState, isNotNull);
      expect(changesResp.created, isNotNull);
      expect(changesResp.updated, isNotNull);
      expect(changesResp.destroyed, isNotNull);
    });
  });
}
