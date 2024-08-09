import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/calendar_event.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/parse/calendar_event_parse_method.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/parse/calendar_event_parse_response.dart';
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
  group('Test to json calendar event parse method', () {
    final CalendarEvent expectedCalendarEvent = CalendarEvent(
        eventId: EventId('ea127690-0440-404b-af98-9823c855a283'),
        title: 'Gatling: break LemonLDAP!',
        description: 'Let\'s write some basic OIDC benchmarks',
        startDate: DateTime.parse('2023-02-09T10:00:00'),
        duration: CalendarDuration('PT2H0M0S'),
        endDate: DateTime.parse('2023-02-09T12:00:00'),
        startUtcDate: UTCDate(DateTime.parse('2023-07-26T08:45:00Z')),
        endUtcDate: UTCDate(DateTime.parse('2023-07-26T09:45:00Z')),
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
              participationStatus: CalendarAttendeeParticipationStatus.accepted,
              expectReply: CalendarAttendeeExpectReply(false)),
          CalendarAttendee(
              name: CalendarAttendeeName('Van Tung TRAN'),
              mailto: CalendarAttendeeMailTo(MailAddress('vttran@domain.tld')),
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

    final CalendarEvent expectedCalendarEvent2 = CalendarEvent(
        eventId: EventId('2a127690-0440-404b-af98-9823c855a283'),
        title: 'Title 2',
        description: 'Let\'s write some basic OIDC benchmarks',
        startDate: DateTime.parse('2023-02-09T10:00:00'),
        duration: CalendarDuration('PT2H0M0S'),
        endDate: DateTime.parse('2023-02-09T12:00:00'),
        startUtcDate: UTCDate(DateTime.parse('2023-07-26T08:45:00Z')),
        endUtcDate: UTCDate(DateTime.parse('2023-07-26T09:45:00Z')),
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
              participationStatus: CalendarAttendeeParticipationStatus.accepted,
              expectReply: CalendarAttendeeExpectReply(false)),
          CalendarAttendee(
              name: CalendarAttendeeName('Van Tung TRAN'),
              mailto: CalendarAttendeeMailTo(MailAddress('vttran@domain.tld')),
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

    final CalendarEvent expectedCalendarEvent3 = CalendarEvent(
      eventId: EventId('ea127690-0440-404b-af98-9823c855a283'),
      title: 'Gatling: break LemonLDAP!',
      description: 'Let\'s write some basic OIDC benchmarks',
    );

    final accountId = AccountId(
        Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6'));
    final blobId1 = Id('0f9f65ab-dc7b-4146-850f-6e4881093965');
    final blobId2 = Id('1f9f65ab-dc7b-4146-850f-6e4881093965');
    final blobIdNotFound = Id('3f9f65ab-dc7b-4146-850f-6e4881093965');
    final blobIdNotParsable = Id('4f9f65ab-dc7b-4146-850f-6e4881093965');

    test('CalendarEventParseMethod parse should succeed', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter =
          DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "CalendarEvent/parse",
                    {
                      "accountId": accountId.id.value,
                      "parsed": {
                        blobId1.value: [
                          {
                            "uid": "ea127690-0440-404b-af98-9823c855a283",
                            "title": "Gatling: break LemonLDAP!",
                            "description":
                                "Let's write some basic OIDC benchmarks",
                            "start": "2023-02-09T10:00:00",
                            "duration": "PT2H0M0S",
                            "end": "2023-02-09T12:00:00",
                            "utcStart": "2023-07-26T08:45:00Z",
                            "utcEnd": "2023-07-26T09:45:00Z",
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
                              "X-OPENPAAS-VIDEOCONFERENCE": [
                                "https://jitsi.linagora.com/abcd"
                              ],
                              "X-OPENPAAS-CUSTOM-HEADER1": [
                                "whatever1",
                                "whatever2"
                              ]
                            },
                            "recurrenceRules": [
                              {
                                "frequency": "yearly",
                                "byDay": ["mo"],
                                "byMonth": ["10"],
                                "bySetPosition": [1, 2],
                                "until": "2024-01-11T09:00:00Z"
                              }
                            ]
                          }
                        ]
                      }
                    },
                    "c0"
                  ]
                ]
              }),
          data: {
            "using": [
              "urn:ietf:params:jmap:core",
              "com:linagora:params:calendar:event"
            ],
            "methodCalls": [
              [
                "CalendarEvent/parse",
                {
                  "accountId": accountId.id.value,
                  "blobIds": [blobId1.value]
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 333
          });

      final calendarEventParseMethod =
          CalendarEventParseMethod(accountId, {blobId1});
      final httpClient = HttpClient(dio);
      final requestBuilder =
          JmapRequestBuilder(httpClient, ProcessingInvocation());
      final invocation = requestBuilder.invocation(calendarEventParseMethod);
      final response = await (requestBuilder
            ..usings(calendarEventParseMethod.requiredCapabilities))
          .build()
          .execute();

      final calendarEventParsed = response.parse<CalendarEventParseResponse>(
          invocation.methodCallId, CalendarEventParseResponse.deserialize);

      expect(calendarEventParsed!.parsed![blobId1],
          containsOnce(expectedCalendarEvent));
    });

    test('CalendarEventParseMethod parse should support several blobIds',
        () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter =
          DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "CalendarEvent/parse",
                    {
                      "accountId": accountId.id.value,
                      "parsed": {
                        blobId1.value: [
                          {
                            "uid": "ea127690-0440-404b-af98-9823c855a283",
                            "title": "Gatling: break LemonLDAP!",
                            "description":
                                "Let's write some basic OIDC benchmarks",
                            "start": "2023-02-09T10:00:00",
                            "duration": "PT2H0M0S",
                            "end": "2023-02-09T12:00:00",
                            "utcStart": "2023-07-26T08:45:00Z",
                            "utcEnd": "2023-07-26T09:45:00Z",
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
                              "X-OPENPAAS-VIDEOCONFERENCE": [
                                "https://jitsi.linagora.com/abcd"
                              ],
                              "X-OPENPAAS-CUSTOM-HEADER1": [
                                "whatever1",
                                "whatever2"
                              ]
                            },
                            "recurrenceRules": [
                              {
                                "frequency": "yearly",
                                "byDay": ["mo"],
                                "byMonth": ["10"],
                                "bySetPosition": [1, 2],
                                "until": "2024-01-11T09:00:00Z"
                              }
                            ]
                          }
                        ],
                        blobId2.value: [
                          {
                            "uid": "2a127690-0440-404b-af98-9823c855a283",
                            "title": "Title 2",
                            "description":
                                "Let's write some basic OIDC benchmarks",
                            "start": "2023-02-09T10:00:00",
                            "duration": "PT2H0M0S",
                            "end": "2023-02-09T12:00:00",
                            "utcStart": "2023-07-26T08:45:00Z",
                            "utcEnd": "2023-07-26T09:45:00Z",
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
                              "X-OPENPAAS-VIDEOCONFERENCE": [
                                "https://jitsi.linagora.com/abcd"
                              ],
                              "X-OPENPAAS-CUSTOM-HEADER1": [
                                "whatever1",
                                "whatever2"
                              ]
                            },
                            "recurrenceRules": [
                              {
                                "frequency": "yearly",
                                "byDay": ["mo"],
                                "byMonth": ["10"],
                                "bySetPosition": [1, 2],
                                "until": "2024-01-11T09:00:00Z"
                              }
                            ]
                          }
                        ]
                      }
                    },
                    "c0"
                  ]
                ]
              }),
          data: {
            "using": [
              "urn:ietf:params:jmap:core",
              "com:linagora:params:calendar:event"
            ],
            "methodCalls": [
              [
                "CalendarEvent/parse",
                {
                  "accountId": accountId.id.value,
                  "blobIds": [
                    blobId1.value,
                    blobId2.value,
                  ]
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 409
          });

      final calendarEventParseMethod =
          CalendarEventParseMethod(accountId, {blobId1, blobId2});
      final httpClient = HttpClient(dio);
      final requestBuilder =
          JmapRequestBuilder(httpClient, ProcessingInvocation());
      final invocation = requestBuilder.invocation(calendarEventParseMethod);
      final response = await (requestBuilder
            ..usings(calendarEventParseMethod.requiredCapabilities))
          .build()
          .execute();

      final calendarEventParsed = response.parse<CalendarEventParseResponse>(
          invocation.methodCallId, CalendarEventParseResponse.deserialize);

      expect(calendarEventParsed!.parsed!.length, 2);
      expect(
          calendarEventParsed.parsed!.values,
          containsAll([
            [expectedCalendarEvent],
            [expectedCalendarEvent2]
          ]));
      expect(calendarEventParsed.parsed![blobId1],
          containsOnce(expectedCalendarEvent));
      expect(calendarEventParsed.parsed![blobId2],
          containsOnce(expectedCalendarEvent2));
    });

    test(
        'CalendarEventParseMethod parse should return not found result when blobId does not exist',
        () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter =
          DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "CalendarEvent/parse",
                    {
                      "accountId": accountId.id.value,
                      "notFound": [blobIdNotFound.value]
                    },
                    "c0"
                  ]
                ]
              }),
          data: {
            "using": [
              "urn:ietf:params:jmap:core",
              "com:linagora:params:calendar:event"
            ],
            "methodCalls": [
              [
                "CalendarEvent/parse",
                {
                  "accountId": accountId.id.value,
                  "blobIds": [blobIdNotFound.value]
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 333
          });

      final calendarEventParseMethod =
          CalendarEventParseMethod(accountId, {blobIdNotFound});
      final httpClient = HttpClient(dio);
      final requestBuilder =
          JmapRequestBuilder(httpClient, ProcessingInvocation());
      final invocation = requestBuilder.invocation(calendarEventParseMethod);
      final response = await (requestBuilder
            ..usings(calendarEventParseMethod.requiredCapabilities))
          .build()
          .execute();

      final calendarEventParsed = response.parse<CalendarEventParseResponse>(
          invocation.methodCallId, CalendarEventParseResponse.deserialize);

      expect(calendarEventParsed!.notFound, contains(blobIdNotFound));
    });

    test('CalendarEventParseMethod parse should return not parsable', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter =
          DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "CalendarEvent/parse",
                    {
                      "accountId": accountId.id.value,
                      "notParsable": [blobIdNotParsable.value]
                    },
                    "c0"
                  ]
                ]
              }),
          data: {
            "using": [
              "urn:ietf:params:jmap:core",
              "com:linagora:params:calendar:event"
            ],
            "methodCalls": [
              [
                "CalendarEvent/parse",
                {
                  "accountId": accountId.id.value,
                  "blobIds": [blobIdNotParsable.value]
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 333
          });

      final calendarEventParseMethod =
          CalendarEventParseMethod(accountId, {blobIdNotParsable});
      final httpClient = HttpClient(dio);
      final requestBuilder =
          JmapRequestBuilder(httpClient, ProcessingInvocation());
      final invocation = requestBuilder.invocation(calendarEventParseMethod);
      final response = await (requestBuilder
            ..usings(calendarEventParseMethod.requiredCapabilities))
          .build()
          .execute();

      final calendarEventParsed = response.parse<CalendarEventParseResponse>(
          invocation.methodCallId, CalendarEventParseResponse.deserialize);

      expect(calendarEventParsed!.notParsable, contains(blobIdNotParsable));
    });

    test('CalendarEventParseMethod parse with properties should succeed',
        () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter =
          DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "CalendarEvent/parse",
                    {
                      "accountId": accountId.id.value,
                      "parsed": {
                        blobId1.value: [
                          {
                            "uid": "ea127690-0440-404b-af98-9823c855a283",
                            "title": "Gatling: break LemonLDAP!",
                            "description":
                                "Let's write some basic OIDC benchmarks",
                          }
                        ]
                      }
                    },
                    "c0"
                  ]
                ]
              }),
          data: {
            "using": [
              "urn:ietf:params:jmap:core",
              "com:linagora:params:calendar:event"
            ],
            "methodCalls": [
              [
                "CalendarEvent/parse",
                {
                  "accountId": accountId.id.value,
                  "blobIds": [blobId1.value],
                  "properties": ["uid", "title", "description"]
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 481
          });

      final calendarEventParseMethod =
          CalendarEventParseMethod(accountId, {blobId1})
            ..addProperties(Properties({"uid", "title", "description"}));
      final httpClient = HttpClient(dio);
      final requestBuilder =
          JmapRequestBuilder(httpClient, ProcessingInvocation());
      final invocation = requestBuilder.invocation(calendarEventParseMethod);
      final response = await (requestBuilder
            ..usings(calendarEventParseMethod.requiredCapabilities))
          .build()
          .execute();

      final calendarEventParsed = response.parse<CalendarEventParseResponse>(
          invocation.methodCallId, CalendarEventParseResponse.deserialize);

      expect(calendarEventParsed!.parsed![blobId1],
          containsOnce(expectedCalendarEvent3));
    });
  });
}
