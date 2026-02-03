import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/calendar/calendar.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/util/calendar_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {

  String uniqueCalendarName(String prefix) {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return '$prefix $ts';
  }
  group('JsContact Calendar API - Live Test', () {
    test('create calendar', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_jscontact.json',
      );

      final resp = await CalendarUtil.createCalendar(
        client: client.httpClient,
        accountId: client.accountId,
        calendar: Calendar(
          name: uniqueCalendarName('JsContact'),
        ),
      );

      expect(resp.accountId.id.value, isNotNull);
      expect(resp.created, isNotNull);
    });
  });

  group('IETF Calendar API - Live Test', () {
    test('create calendar', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final resp = await CalendarUtil.createCalendar(
        client: client.httpClient,
        accountId: client.accountId,
        calendar: Calendar(
          name: 'IETF Test Calendar',
          description: 'Live test calendar',
          isVisible: true,
        ),
      );

      expect(resp.accountId.id.value, 'd333333');
      expect(resp.created, isNotNull);
      expect(resp.created!.isNotEmpty, true);

      final createdCalendar = resp.created!.values.first;
      expect(createdCalendar.id, isNotNull);
      expect(createdCalendar.id!.value, isNotEmpty);
    });
  });

  group('Cyrus Calendar API - Live Test', () {
    test('create calendar', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final resp = await CalendarUtil.createCalendar(
        client: client.httpClient,
        accountId: client.accountId,
        calendar: Calendar(
          name: 'Cyrus Test Calendar',
          description: 'Live test calendar',
          isVisible: true,
        ),
      );

      expect(resp.accountId.id.value, isNotNull);
    });
  });

  group('Calendar/set destroy - Live Test', () {
    test('delete calendar', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_jscontact.json',
      );

      final created = await CalendarUtil.createCalendar(
        client: client.httpClient,
        accountId: client.accountId,
        calendar: Calendar(
          name: 'Temp Calendar',
          isVisible: true,
        ),
      );

      final calendarId = created.created!.values.first.id!;
      final resp = await CalendarUtil.deleteCalendar(
        client: client.httpClient,
        accountId: client.accountId,
        id: calendarId,
      );

      expect(resp.destroyed!.map((e) => e.value), contains(calendarId.value));
    });
  });
  group('Calendar/set - mocked Set/Destroy', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late HttpClient httpClient;
    final accountId = AccountId(Id('acc1'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST'))
        ..options.baseUrl = 'https://mocked.example/jmap';
      dioAdapter = DioAdapter(dio: dio);
      httpClient = HttpClient(dio);
    });

    test('Calendar/set create', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s1",
            "methodResponses": [
              [
                "Calendar/set",
                {
                  "accountId": "acc1",
                  "created": {
                    "c1": {"id": "cal1"}
                  }
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final resp = await CalendarUtil.setCalendars(
        client: httpClient,
        accountId: accountId,
        create: {
          Id('c1'): Calendar(
            name: 'Work',
            description: 'Work calendar',
            color: '#FF0000',
            isVisible: true,
          ),
        },
        methodCallId: MethodCallId('c0'),
      );

      expect(resp.accountId.id.value, 'acc1');
      expect(resp.created!.containsKey(Id('c1')), isTrue);
      expect(resp.created![Id('c1')]!.id!.value, 'cal1');
    });

    test('Calendar/set destroy', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s2",
            "methodResponses": [
              [
                "Calendar/set",
                {
                  "accountId": "acc1",
                  "destroyed": ["cal1"]
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final resp = await CalendarUtil.deleteCalendar(
        client: httpClient,
        accountId: accountId,
        id: Id('cal1'),
      );

      expect(resp.accountId.id.value, 'acc1');
      expect(resp.destroyed!.map((e) => e.value), contains('cal1'));
    });
  });

  group('Calendar/get - mocked', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late HttpClient httpClient;
    final accountId = AccountId(Id('acc1'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST'))
        ..options.baseUrl = 'https://mocked.example/jmap';
      dioAdapter = DioAdapter(dio: dio);
      httpClient = HttpClient(dio);
    });

    test('Calendar/get returns list', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s3",
            "methodResponses": [
              [
                "Calendar/get",
                {
                  "accountId": "acc1",
                  "state": "st1",
                  "list": [
                    {
                      "id": "cal1",
                      "name": "Personal",
                      "color": "#00FF00",
                      "isVisible": true
                    }
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

      expect(resp.accountId.id.value, 'acc1');
      expect(resp.list.length, 1);
      expect(resp.list.first.name, 'Personal');
    });
  });
}
