import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/calendar/parse/parse_calender_method.dart';
import 'package:jmap_dart_client/jmap/calendar/parse/parse_calender_response.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

void main() {
  group('test parseCalender method', () {
    final expectedParsed1 = {
      "accountId":
          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
      "parsed": {
        "0f9f65ab-dc7b-4146-850f-6e4881093965": {
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
              "byDay": ["mo"],
              "byMonth": ["10"],
              "bySetPosition": [1, 2],
              "until": "2024-01-11T09:00:00Z"
            }
          ]
        }
      }
    };

    final expectedParsed2 = {
      "accountId":
          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
      "notFound": ["0f9f65ab-dc7b-4146-850f-6e4881093965"]
    };

    final expectedParsed3 = {
      "accountId":
          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
      "notParsable": ["0f9f65ab-dc7b-4146-850f-6e4881093965"]
    };

    test('blob id parsed successfully', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "CalendarEvent/parse",
                    {
                      "accountId":
                          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
                      "parsed": {
                        "0f9f65ab-dc7b-4146-850f-6e4881093965": {
                          "uid": "ea127690-0440-404b-af98-9823c855a283",
                          "title": "Gatling: break LemonLDAP!",
                          "description":
                              "Let's write some basic OIDC benchmarks",
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
                      }
                    },
                    "c1"
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
                  "accountId":
                      "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
                  "blobIds": ["0f9f65ab-dc7b-4146-850f-6e4881093965"]
                },
                "c1"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 1755
          });

      print("Test URL: ${dio.options.baseUrl}");

      final parseCalenderMethod = ParseCalenderMethod(AccountId(Id(
          '0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555')));
      final httpClient = HttpClient(dio);

      final processingInvocation = ProcessingInvocation();
      final requestBuilder =
          JmapRequestBuilder(httpClient, processingInvocation);
      final getCalendarInvocation =
          requestBuilder.invocation(parseCalenderMethod);

      final response = await (requestBuilder).build().execute();

      final parseCalenderResponse = response.parse<ParseCalenderResponse>(
          getCalendarInvocation.methodCallId,
          ParseCalenderResponse.deserialize);
      expect(parseCalenderResponse!.parsed, equals(expectedParsed1));
    });

    test('blob id is not found,', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "CalendarEvent/parse",
                    {
                      "accountId":
                          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
                      "notFound": ["0f9f65ab-dc7b-4146-850f-6e4881093965"]
                    },
                    "c1"
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
                  "accountId":
                      "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
                  "blobIds": ["0f9f65ab-dc7b-4146-850f-6e4881093965"]
                },
                "c1"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 1755
          });

      print("Test URL: ${dio.options.baseUrl}");

      final parseCalenderMethod = ParseCalenderMethod(AccountId(Id(
          '0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555')));
      final httpClient = HttpClient(dio);

      final processingInvocation = ProcessingInvocation();
      final requestBuilder =
          JmapRequestBuilder(httpClient, processingInvocation);
      final getCalendarInvocation =
          requestBuilder.invocation(parseCalenderMethod);

      final response = await (requestBuilder).build().execute();

      final parseCalenderResponse = response.parse<ParseCalenderResponse>(
          getCalendarInvocation.methodCallId,
          ParseCalenderResponse.deserialize);
      expect(parseCalenderResponse!.parsed, equals(expectedParsed1));
    });

    test('blob id has been found but is not parsable', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "CalendarEvent/parse",
                    {
                      "accountId":
                          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
                      "notParsable": ["0f9f65ab-dc7b-4146-850f-6e4881093965"]
                    },
                    "c1"
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
                  "accountId":
                      "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
                  "blobIds": ["0f9f65ab-dc7b-4146-850f-6e4881093965"]
                },
                "c1"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 1755
          });

      print("Test URL: ${dio.options.baseUrl}");

      final parseCalenderMethod = ParseCalenderMethod(AccountId(Id(
          '0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555')));
      final httpClient = HttpClient(dio);

      final processingInvocation = ProcessingInvocation();
      final requestBuilder =
          JmapRequestBuilder(httpClient, processingInvocation);
      final getCalendarInvocation =
          requestBuilder.invocation(parseCalenderMethod);

      final response = await (requestBuilder).build().execute();

      final parseCalenderResponse = response.parse<ParseCalenderResponse>(
          getCalendarInvocation.methodCallId,
          ParseCalenderResponse.deserialize);
      expect(parseCalenderResponse!.parsed, equals(expectedParsed1));
    });
  });
}
