import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/calendar/calender_event.dart';
import 'package:jmap_dart_client/jmap/calendar/calendar_event.dart';
import 'package:jmap_dart_client/jmap/calendar/extension_fields.dart';
import 'package:jmap_dart_client/jmap/calendar/organizer.dart';
import 'package:jmap_dart_client/jmap/calendar/parse.dart';
import 'package:jmap_dart_client/jmap/calendar/participants.dart';
import 'package:jmap_dart_client/jmap/calendar/recurrence_rules.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

void main() {
  group("parse should succeed test", () {
    final requesttoparse = {
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
    };
    final calendarEvent1 = CalendarEvent(
      accountId:
          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
      parsed: Parsed(
        blobId: BlobId(
            uid: "ea127690-0440-404b-af98-9823c855a283",
            title: "Gatling: break LemonLDAP!",
            description: "Let's write some basic OIDC benchmarks",
            start: "2023-02-09T10:00:00",
            duration: "PT2H0M0S",
            end: "2023-02-09T12:00:00",
            timeZone: "Asia/Ho_Chi_Minh",
            location: "5 Dien Bien Phu, Ha Noi",
            method: "REQUEST",
            sequence: 0,
            priority: 0,
            freeBusyStatus: "busy",
            privacy: "public",
            organizer: Organizer(
                name: "Benoît TELLIER", mailto: "btellier@linagora.com"),
            participants: [
              Participants(
                  name: "Benoît TELLIER",
                  mailto: "btellier@domain.tld",
                  kind: "individual",
                  role: "chair",
                  participationStatus: "accepted",
                  expectReply: false),
              Participants(
                  name: "Benoît TELLIER",
                  mailto: "btellier@domain.tld",
                  kind: "individual",
                  role: "chair",
                  participationStatus: "accepted",
                  expectReply: false),
            ],
            extensionFields: ExtensionFields(
              xOPENPAASVIDEOCONFERENCE: [
                "https://jitsi.linagora.com/abcd",
                "https://jitsi.linagora.com/abcd",
              ],
              xOPENPAASCUSTOMHEADER1: ["whatever1", "whatever2"],
            ),
            recurrenceRules: [
              RecurrenceRules(
                  frequency: "yearly",
                  byDay: ["mo"],
                  byMonth: ["10"],
                  bySetPosition: [1, 2],
                  until: "2024-01-11T09:00:00Z"),
            ]),
      ),
    );

    test('parse should succeed', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost('', (server) => server.reply(200, requesttoparse));

      final httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();
      final requestBuilder =
          JmapRequestBuilder(httpClient, processingInvocation);
      final accountId = AccountId(Id(
          '3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12'));

      // final getIdentityMethod = GetIdentityMethod(accountId);
      // final getIdentityInvocation = requestBuilder.invocation(getIdentityMethod);
      // final response = await (requestBuilder
      //       ..usings(getIdentityMethod.requiredCapabilities))
      //     .build()
      //     .execute();

      // final resultList = response.parse<GetIdentityResponse>(
      //     getIdentityInvocation.methodCallId, GetIdentityResponse.deserialize);

      // expect(resultList?.list.length, equals(2));
      // expect(resultList?.list, containsAll({expectIdentity1, expectIdentity2}));
    });
  });
}
