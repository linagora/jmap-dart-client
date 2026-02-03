import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/calendar_event/alert_value.dart';
import 'package:jmap_dart_client/jmap/calendar_event/by_day.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';
import 'package:jmap_dart_client/jmap/calendar_event/keywords.dart';
import 'package:jmap_dart_client/jmap/calendar_event/location_value.dart';
import 'package:jmap_dart_client/jmap/calendar_event/participant_value.dart';
import 'package:jmap_dart_client/jmap/calendar_event/recurrence_rules.dart';
import 'package:jmap_dart_client/jmap/calendar_event/role.dart';
import 'package:jmap_dart_client/jmap/calendar_event/send_to.dart';
import 'package:jmap_dart_client/jmap/calendar_event/trigger.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/util/calendar_event_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('JsContact CalendarEvent API - Live Test', () {
    test('create -> get -> modify -> get -> delete', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_jscontact.json',
      );

      final accountId = client.accountId;
      final httpClient = client.httpClient;
      const weekly = 'weekly';

      final calendar = CalendarEvent(
        start: '2023-04-28T14:00:00',
        duration: 'P2DT1H',
        status: 'confirmed',
        type: 'Event',
        prodId: '-//IDN jscontact.com//Calendar app 3.4.2//EN',
        sequence: 3,
        title: 'Artsy',
        description: 'Scrum  meeting with the developers.',
        privacy: 'secret',
        timeZone: 'Europe/Berlin',
        locations: {
          LocationId('1'):
              LocationValue(type: 'Location', name: 'Karlsruhe'),
        },
        keywords: Keyword(
          business: true,
          anniversary: true,
          education: true,
          holiday: true,
        ),
         recurrenceRule: RecurrenceRules(
          frequency: weekly,
          interval: 1,
          count: 5,
          byDay: {
            ByDay(day: 'mo'),
            ByDay(day: 'we'),
          },
          bySetPosition: const [1, -1],
          until: '2023-12-31T23:59:59',
        ),
        participants: {
          ParticipantId('1'): ParticipantValue(
            type: 'Participant',
            name: 'Test User 1',
            scheduleId: '23',
            sendTo: SendTo(imip: 'mailto:testuser@jmaptest.de'),
            kind: 'individual',
            language: 'en',
            roles: {Role('attendee'): true},
            expectReply: true,
            scheduleStatus: ['5.0'],
          ),
        },
        alerts: {
          AlertId('1'): AlertValue(
            trigger: Trigger(
              type: 'OffsetTrigger',
              offset: '-PT10M',
              relativeTo: 'start',
            ),
            action: 'display',
          ),
          AlertId('2'): AlertValue(
            trigger: Trigger(
              type: 'OffsetTrigger',
              offset: '-P2D',
              relativeTo: 'start',
            ),
            action: 'display',
          ),
        },
      );

      // CREATE
      final createResp = await CalendarEventUtil.createCalendarEvent(
        client: httpClient,
        accountId: accountId,
        event: calendar,
      );
      final createdId = createResp.created!.values.first.id!.id.value;

      // GET AFTER CREATE
      final fetched1 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(fetched1, isNotNull);

      expect(fetched1!.title, equals(calendar.title));
      expect(fetched1.description, equals(calendar.description));
      expect(fetched1.start, equals(calendar.start));
      expect(fetched1.timeZone, equals(calendar.timeZone));
      expect(fetched1.keywords, isNotNull);
      expect(fetched1.keywords!.business, isTrue);
      expect(fetched1.recurrenceRule, isNotNull);
      expect(
        fetched1.recurrenceRule!.frequency,
        equals(calendar.recurrenceRule!.frequency),
      );
      expect(
        fetched1.recurrenceRule!.until,
        equals(calendar.recurrenceRule!.until),
      );
      expect(fetched1.participants, isNotNull);
      final p1 = fetched1.participants![ParticipantId('1')]!;
      expect(p1.name, equals('Test User 1'));
      expect(p1.sendTo!.imip, equals('mailto:testuser@jmaptest.de'));
      expect(fetched1.alerts, isNotNull);
      expect(fetched1.alerts!.length, equals(2));

      // MODIFY
      final patch = PatchObject({
        'title': 'Artsy updated',
        'description': 'Updated scrum meeting.',
      });

      await CalendarEventUtil.updateCalendarEvent(
        client: httpClient,
        accountId: accountId,
        id: Id(createdId),
        patch: patch,
      );

      // GET AFTER MODIFY
      final fetched2 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(fetched2, isNotNull);
      expect(fetched2!.title, equals('Artsy updated'));
      expect(fetched2.description, equals('Updated scrum meeting.'));

      // DELETE
      await CalendarEventUtil.deleteCalendarEvent(
        client: httpClient,
        accountId: accountId,
        id: Id(createdId),
      );

      // VERIFY NOT FOUND 
      final fetched3 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(fetched3, isNull);
    }, timeout: const Timeout(Duration(seconds: 600)));
  });

  group('ietf CalendarEvent API - Live Test', () {
    test('create -> get -> modify -> get -> delete', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final accountId = client.accountId;
      final httpClient = client.httpClient;

      const weekly = 'weekly';

      final calendar = CalendarEvent(
        calendarIds: {'c': true},
        start: '2023-04-28T14:00:00',
        duration: 'P2DT1H',
        status: 'confirmed',
        type: 'Event',
        prodId: '-//IDN jscontact.com//Calendar app 3.4.2//EN',
        sequence: 3,
        title: 'Artsy',
        description: 'Scrum  meeting with the developers.',
        privacy: 'secret',
        timeZone: 'Europe/Berlin',
        locations: {
          LocationId('1'):
              LocationValue(type: 'Location', name: 'Karlsruhe'),
        },
        keywords: Keyword(
          business: true,
          anniversary: true,
          education: true,
          holiday: true,
        ),
        recurrenceRule: RecurrenceRules(
          frequency: weekly,
          interval: 1,
          count: 5,
          byDay: {
            ByDay(day: 'mo'),
            ByDay(day: 'we'),
          },
          bySetPosition: const [1, -1],
          until: '2023-12-31T23:59:59',
        ),
        participants: {
          ParticipantId("1"): ParticipantValue(
            type: "Participant",
            name: "Test User 1",
            scheduleId: "sched-1",
            kind: "individual",
            participationStatus: "accepted",
            calendarAddress:
                "mailto:6489-4f14-a57f-c1@calendar.example.com",
            sendTo: SendTo(imip: "mailto:testuser@jmaptest.de"),
          ),
        },
        alerts: {
          AlertId('1'): AlertValue(
            trigger: Trigger(
              type: 'OffsetTrigger',
              offset: '-PT10M',
              relativeTo: 'start',
            ),
            action: 'display',
          ),
          AlertId('2'): AlertValue(
            trigger: Trigger(
              type: 'OffsetTrigger',
              offset: '-P2D',
              relativeTo: 'start',
            ),
            action: 'display',
          ),
        },
      );

      // CREATE
      final createResp = await CalendarEventUtil.createCalendarEvent(
        client: httpClient,
        accountId: accountId,
        event: calendar,
      );
      final createdId = createResp.created!.entries.first.value.id!.id.value;

      // GET AFTER CREATE
      final fetched1 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(fetched1, isNotNull);
      expect(fetched1!.title, equals(calendar.title));
      expect(fetched1.description, equals(calendar.description));
      expect(fetched1.start, equals(calendar.start));
      expect(fetched1.timeZone, equals(calendar.timeZone));
      expect(fetched1.keywords, isNotNull);
      expect(fetched1.keywords!.business, isTrue);
      expect(fetched1.recurrenceRule, isNotNull);
      expect(
        fetched1.recurrenceRule!.frequency,
        equals(calendar.recurrenceRule!.frequency),
      );
      expect(
        fetched1.recurrenceRule!.until,
        equals(calendar.recurrenceRule!.until),
      );
      expect(fetched1.participants, isNotNull);
      final p1 = fetched1.participants![ParticipantId('1')]!;
      expect(p1.name, equals('Test User 1'));
      expect(p1.sendTo!.imip, equals('mailto:testuser@jmaptest.de'));
      expect(fetched1.alerts!.length, equals(2));

      // MODIFY 
      final patch = PatchObject({
        'title': 'Artsy updated',
        'description': 'Updated scrum meeting.',
      });

      await CalendarEventUtil.updateCalendarEvent(
        client: httpClient,
        accountId: accountId,
        id: Id(createdId),
        patch: patch,
      );

      // GET AFTER MODIFY
      final fetched2 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(fetched2, isNotNull);
      expect(fetched2!.title, equals('Artsy updated'));
      expect(fetched2.description, equals('Updated scrum meeting.'));

      // DELETE
      await CalendarEventUtil.deleteCalendarEvent(
        client: httpClient,
        accountId: accountId,
        id: Id(createdId),
      );

      // VERIFY NOT FOUND
      final fetched3 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(fetched3, isNull);
    }, timeout: const Timeout(Duration(seconds: 600)));
  });
  group('Cyrus CalendarEvent API - Live Test', () {
    test('create -> get -> modify -> get -> delete', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final accountId = client.accountId;
      final httpClient = client.httpClient;
      const weekly = 'weekly';

      final calendar = CalendarEvent(
        calendarIds: {'Default': true},
        start: '2023-04-28T14:00:00',
        duration: 'P2DT1H',
        status: 'confirmed',
        type: 'Event',
        prodId: '-//IDN jscontact.com//Calendar app 3.4.2//EN',
        sequence: 3,
        title: 'Artsy',
        description: 'Scrum  meeting with the developers.',
        privacy: 'secret',
        timeZone: 'Europe/Berlin',
        locations: {
          LocationId('1'):
              LocationValue(type: 'Location', name: 'Karlsruhe'),
        },
        keywords: Keyword(
          business: true,
          anniversary: true,
          education: true,
          holiday: true,
        ),
        recurrenceRules: [
          RecurrenceRules(
            frequency: weekly,
            interval: 1,
            byDay: { ByDay(day: 'mo'), ByDay(day: 'we') },
            until: '2023-12-31T23:59:59',
          ),
        ],
        participants: {
          ParticipantId('1'): ParticipantValue(
            type: 'Participant',
            name: 'Test User 1',
            scheduleId: '23',
            sendTo: SendTo(imip: 'mailto:testuser@jmaptest.de'),
            kind: 'individual',
            language: 'en',
            roles: {Role('attendee'): true},
            expectReply: true,
            scheduleStatus: ['5.0'],
          ),
        },
        alerts: {
          AlertId('1'): AlertValue(
            trigger: Trigger(
              type: 'OffsetTrigger',
              offset: '-PT10M',
              relativeTo: 'start',
            ),
            action: 'display',
          ),
          AlertId('2'): AlertValue(
            trigger: Trigger(
              type: 'OffsetTrigger',
              offset: '-P2D',
              relativeTo: 'start',
            ),
            action: 'display',
          ),
        },
      );

      // CREATE
      final createResp = await CalendarEventUtil.createCalendarEvent(
        client: httpClient,
        accountId: accountId,
        event: calendar,
      );
      final createdId = createResp.created!.values.first.id!.id.value;

      // GET AFTER CREATE
      final fetched1 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(fetched1, isNotNull);

      expect(fetched1!.title, equals(calendar.title));
      expect(fetched1.description, equals(calendar.description));
      expect(fetched1.start, equals(calendar.start));
      expect(fetched1.timeZone, equals(calendar.timeZone));
      expect(fetched1.calendarIds, equals(calendar.calendarIds));

      expect(fetched1.participants, isNotNull);
      final p1 = fetched1.participants![ParticipantId('1')]!;
      expect(p1.name, equals('Test User 1'));
      expect(p1.sendTo!.imip, equals('mailto:testuser@jmaptest.de'));

      expect(fetched1.alerts, isNotNull);
      expect(fetched1.alerts!.length, equals(2));

      // MODIFY 
      final patch = PatchObject({
        'title': 'Artsy updated',
        'description': 'Updated scrum meeting.',
      });

      await CalendarEventUtil.updateCalendarEvent(
        client: httpClient,
        accountId: accountId,
        id: Id(createdId),
        patch: patch,
      );

      // GET AFTER MODIFY
      final fetched2 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(fetched2, isNotNull);
      expect(fetched2!.title, equals('Artsy updated'));
      expect(fetched2.description, equals('Updated scrum meeting.'));

      // DELETE
      await CalendarEventUtil.deleteCalendarEvent(
        client: httpClient,
        accountId: accountId,
        id: Id(createdId),
      );

      // VERIFY NOT FOUND
      final fetched3 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(fetched3, isNull);
    }, timeout: const Timeout(Duration(seconds: 600)));
  });


  group('CalendarEvent/set - mocked Set/Destroy', () {
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

    test('CalendarEvent/set create', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s1",
            "methodResponses": [
              [
                "CalendarEvent/set",
                {
                  "accountId": "acc1",
                  "created": {
                    "c1": {"id": "e1#event.ics"}
                  }
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final parsed = await CalendarEventUtil.setCalendarEvents(
        client: httpClient,
        accountId: accountId,
        create: {
          Id('c1'): CalendarEvent(title: 'Team Sync'),
        },
        methodCallId: MethodCallId('c0'),
      );

      expect(parsed.accountId.id.value, 'acc1');
      expect(parsed.created!.containsKey(Id('c1')), isTrue);
      expect(parsed.created![Id('c1')]!.id!.id.value, 'e1#event.ics');
    });

    test('CalendarEvent/set destroy', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s2",
            "methodResponses": [
              [
                "CalendarEvent/set",
                {
                  "accountId": "acc1",
                  "destroyed": ["e1#event.ics"]
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final parsed = await CalendarEventUtil.deleteCalendarEvent(
        client: httpClient,
        accountId: accountId,
        id: Id('e1#event.ics'),
      );

      expect(parsed.accountId.id.value, 'acc1');
      expect(parsed.destroyed!.map((e) => e.value), contains('e1#event.ics'));
    });
  });
}
