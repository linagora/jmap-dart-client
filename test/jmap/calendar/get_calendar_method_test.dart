import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/calendar/calendar.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/util/calendar_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('Calendar/get - mocked', () {
    late Dio dio;
    late DioAdapter adapter;
    late HttpClient httpClient;

    final accountId = AccountId(Id('normaluser'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST'))
        ..options.baseUrl =
            'https://www.audriga.eu/test/nextcloud26/index.php/apps/jmap/jmap';
      adapter = DioAdapter(dio: dio);
      httpClient = HttpClient(dio);
    });

    test('Calendar/get returns list of calendars', () async {
      adapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s1",
            "methodResponses": [
              [
                "Calendar/get",
                {
                  "accountId": "normaluser",
                  "state": "st1",
                  "list": [
                    {"id": 1, "name": "Personal"},
                    {"id": 2, "name": "Work"}
                  ],
                  "notFound": []
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final resp = await CalendarUtil.getCalendars(
        client: httpClient,
        accountId: accountId,
      );

      expect(resp.accountId.id.value, 'normaluser');
      expect(resp.list.length, 2);
      expect(resp.list.first.name, 'Personal');
    });
  });

  group('Calendar/get - live API', () {
    test('get calendars from real server', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_jscontact.json',
      );

      final resp = await CalendarUtil.getCalendars(
        client: client.httpClient,
        accountId: client.accountId,
      );

      expect(resp.list, isNotEmpty);
      expect(resp.list.first, isA<Calendar>());
      expect(resp.list.first.name, isNotNull);
    });
  });

    group('Calendar/get - IETF live', () {
    test('get calendars', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final resp = await CalendarUtil.getCalendars(
        client: client.httpClient,
        accountId: client.accountId,
      );

      expect(resp.list, isNotEmpty);
      expect(resp.list.first, isA<Calendar>());
      expect(resp.list.first.name, isNotNull);
    });
  });
}
