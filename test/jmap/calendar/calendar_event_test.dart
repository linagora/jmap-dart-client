import 'dart:convert';

import 'package:test/test.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/calendar_event.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_expect_reply.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_kind.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_mail_to.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_name.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_participation_status.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_role.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_duration.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_extension_fields.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_free_busy_status.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_organizer.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_priority.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_privacy.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_sequence.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_method.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/mail_address.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/recurrence_rule/day_of_week.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/recurrence_rule/recurrence_rule.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/recurrence_rule/recurrence_rule_frequency.dart';

void main() {
  group('calendar event object test', () {
    test('get should parsing correctly calendar event', () {
      const calendarEventString = '''{
          "uid": "ea127690-0440-404b-af98-9823c855a283",
          "title": "Gatling: break LemonLDAP!",
          "description": "Let's write some basic OIDC benchmarks",
          "start": "2023-02-09T10:00:00",
          "duration": "PT2H0M0S",
          "end": "2023-02-09T12:00:00",
          "timeZone": "Asia/Ho_Chi_Minh",
          "location": "5 Dien Bien Phu, Ha Noi",
          "method": "REQUEST",
          "sequence": 0,
          "priority": 5,
          "freeBusyStatus": "busy",
          "privacy": "public",
          "organizer": {
            "name": "Benoît TELLIER",
            "mailto": "btellier@linagora.com"
          },
          "participants": [
            {
              "name": "Benoît TELLIER",
              "mailto": "btellier@domain.tld",
              "kind": "individual",
              "role": "chair",
              "participationStatus": "accepted",
              "expectReply": false
            },
            {
              "name": "Van Tung TRAN",
              "mailto": "vttran@domain.tld",
              "kind": "individual",
              "role": "requested-participant",
              "participationStatus": "needs-action",
              "expectReply": true
            }
          ],
          "extensionFields": {
            "X-OPENPAAS-VIDEOCONFERENCE": ["https://jitsi.linagora.com/abcd"],
            "X-OPENPAAS-CUSTOM-HEADER1": ["whatever1", "whatever2"]
          },
          "recurrenceRules": [
            {  
             "frequency": "yearly",
             "byDay": [ "mo" ],
             "byMonth": [ "10" ],
             "bySetPosition": [ 1, 2 ],
             "until":"2024-01-11T09:00:00Z"
            }
          ]
      }''';

      final CalendarEvent expectedCalendarEvent = CalendarEvent(
          eventId: EventId('ea127690-0440-404b-af98-9823c855a283'),
          title: 'Gatling: break LemonLDAP!',
          description: 'Let\'s write some basic OIDC benchmarks',
          startDate: DateTime.parse('2023-02-09T10:00:00'),
          duration: CalendarDuration('PT2H0M0S'),
          endDate: DateTime.parse('2023-02-09T12:00:00'),
          timeZone: 'Asia/Ho_Chi_Minh',
          location: '5 Dien Bien Phu, Ha Noi',
          method: EventMethod.request,
          sequence: CalendarSequence(0),
          priority: CalendarPriority(5),
          freeBusyStatus: CalendarFreeBusyStatus.busy,
          privacy: CalendarPrivacy.public,
          organizer: CalendarOrganizer(
              name: 'Benoît TELLIER',
              mailto: MailAddress('btellier@linagora.com')),
          participants: [
            CalendarAttendee(
                name: CalendarAttendeeName('Benoît TELLIER'),
                mailto:
                    CalendarAttendeeMailTo(MailAddress('btellier@domain.tld')),
                kind: CalendarAttendeeKind.individual,
                role: CalendarAttendeeRole.chair,
                participationStatus:
                    CalendarAttendeeParticipationStatus.accepted,
                expectReply: CalendarAttendeeExpectReply(false)),
            CalendarAttendee(
                name: CalendarAttendeeName('Van Tung TRAN'),
                mailto:
                    CalendarAttendeeMailTo(MailAddress('vttran@domain.tld')),
                kind: CalendarAttendeeKind.individual,
                role: CalendarAttendeeRole.requestedParticipant,
                participationStatus:
                    CalendarAttendeeParticipationStatus.needsAction,
                expectReply: CalendarAttendeeExpectReply(true))
          ],
          extensionFields: CalendarExtensionFields({
            'X-OPENPAAS-VIDEOCONFERENCE': ['https://jitsi.linagora.com/abcd'],
            'X-OPENPAAS-CUSTOM-HEADER1': ['whatever1', 'whatever2']
          }),
          recurrenceRules: [
            RecurrenceRule(
                frequency: RecurrenceRuleFrequency.yearly,
                byDay: [DayOfWeek.monday],
                byMonth: ['10'],
                bySetPosition: [1, 2],
                until: UTCDate(DateTime.parse('2024-01-11T09:00:00Z')))
          ]);

      final parsedCalendarEvent =
          CalendarEvent.fromJson(json.decode(calendarEventString));

      expect(parsedCalendarEvent, equals(expectedCalendarEvent));
    });
  });
}
