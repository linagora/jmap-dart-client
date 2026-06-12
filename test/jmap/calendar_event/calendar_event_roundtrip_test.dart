import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/jmap/calendar_event/alert_value.dart';
import 'package:jmap_dart_client/jmap/calendar_event/by_day.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';
import 'package:jmap_dart_client/jmap/calendar_event/keyword.dart';
import 'package:jmap_dart_client/jmap/calendar_event/location_value.dart';
import 'package:jmap_dart_client/jmap/calendar_event/participant_value.dart';
import 'package:jmap_dart_client/jmap/calendar_event/recurrence_rules.dart';
import 'package:jmap_dart_client/jmap/calendar_event/role.dart';
import 'package:jmap_dart_client/jmap/calendar_event/send_to.dart';
import 'package:jmap_dart_client/jmap/calendar_event/trigger.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/util/calendar_event_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('ietf CalendarEvent API - Live Test', () {
    test('create/get/verify/delete calendar event roundtrip', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );
      const weekly = "weekly";

      final accountId = client.accountId;
      final httpClient = client.httpClient;

      final calendar = CalendarEvent(
      calendarIds: {'c': true},
      start: "2023-04-28T14:00:00",
      duration: "P2DT1H",
      status: "confirmed",
      type: "Event",
      prodId: "-//IDN jscontact.com//Calendar app 3.4.2//EN",
      sequence: 3,
      title: "Artsy",
      description: "Scrum  meeting with the developers.",
      privacy: "secret",
      timeZone: "Europe/Berlin",
      isDraft: false,
      freeBusyStatus: "busy",
      organizerCalendarAddress:
          "mailto:6489-4f14-a57f-c1@schedule.example.com",

      locations: {
        LocationId('1'): LocationValue(type: "Location", name: "Karlsruhe"),
      },
       keywords: Keyword(
        anniversary: true,
        appointment: null,
        business: true,
        education: true,
        holiday: true,
        meeting: null,
        miscellaneous: null,
        nonWorkingHrs: null,
        notInOffice: null,
        personal: null,
        phoneCall: null,
        sickDay: null,
        specialOccasion: null,
        travel: null,
        vacation: null,
      ),
      participants: {
        ParticipantId("1"): ParticipantValue(
          type: "Participant",
          name: "Tom",
          scheduleId: "sched-1",
          kind: "individual",
          participationStatus: "accepted",
          calendarAddress:
              "mailto:6489-4f14-a57f-c1@calendar.example.com",
          sendTo: SendTo(imip: "mailto:tom@foobar.example.com"),
          roles: {Role('attendee'): true},
          expectReply: true,
          scheduleStatus: ["1.2;sent"],
          language: "en",
          email: "tom@foobar.example.com",
        ),
      },
      alerts: {
        AlertId("1"): AlertValue(
          trigger: Trigger(
            type: "OffsetTrigger",
            offset: "-PT10M",
            relativeTo: "start",
          ),
          action: "display",
        ),
        AlertId("2"): AlertValue(
          trigger: Trigger(
            type: "OffsetTrigger",
            offset: "-P2D",
            relativeTo: "start",
          ),
          action: "display",
        ),
      },
      recurrenceRule: RecurrenceRules(
        frequency: weekly,
        interval: 1,
        count: 5,
        byDay: {
          ByDay(day: "mo"),
          ByDay(day: "we"),
        },
        bySetPosition: const [1, -1],
        until: "2023-12-31T23:59:59",
      ),
    );

      //create
      final createResp = await CalendarEventUtil.createCalendarEvent(
        client: httpClient,
        accountId: accountId,
        event: calendar,
      );
      final createdId = createResp.created!.values.first.id!.id.value;

      //get and verify initial values
      final getResp1 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );

      final fetched1 = getResp1!;
      expect(fetched1.title, equals(calendar.title));
      expect(fetched1.description, equals(calendar.description));
      expect(fetched1.calendarIds, equals(calendar.calendarIds));
      expect(fetched1.status, equals(calendar.status));
      expect(fetched1.timeZone, equals(calendar.timeZone));
      expect(fetched1.calendarIds, equals(calendar.calendarIds));
      expect(fetched1.locations, equals(calendar.locations));
      expect(fetched1.start, equals(calendar.start));
      expect(fetched1.duration, equals(calendar.duration));
      expect(fetched1.privacy, equals(calendar.privacy));
      expect(fetched1.freeBusyStatus, equals(calendar.freeBusyStatus));
      expect(fetched1.prodId, equals(calendar.prodId));
      expect(fetched1.sequence, equals(calendar.sequence));
      expect(fetched1.type, equals(calendar.type));
      expect(fetched1.participants, isNotNull);
      final expectedTom = calendar.participants!.values.first;
      final fetchedTom = fetched1.participants!.values.firstWhere(
        (p) => p.calendarAddress == expectedTom.calendarAddress,
      );
      expect(fetchedTom, equals(expectedTom));
      expect(fetched1.alerts, equals(calendar.alerts));
      expect(fetched1.recurrenceRule, equals(calendar.recurrenceRule));
      expect(fetched1.keywords, equals(calendar.keywords));
      expect(fetched1.organizerCalendarAddress,
          equals(calendar.organizerCalendarAddress));

      expect(fetched1.isDraft, equals(calendar.isDraft));

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

      //get and verify modified values
      final getResp2 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );

      final fetched2 = getResp2!;
      expect(fetched2.title, equals('Artsy updated'));
      expect(fetched2.description, equals('Updated scrum meeting.'));


      //delete
      await CalendarEventUtil.deleteCalendarEvent(
        client: httpClient,
        accountId: accountId,
        id: Id(createdId),
      );

      //verify not found
      final getResp3 = await CalendarEventUtil.getCalendarEventById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(getResp3, null);
    }, timeout: const Timeout(Duration(seconds: 600)));
  });
}
